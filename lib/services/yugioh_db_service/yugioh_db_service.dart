import 'dart:convert';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:async';
import './response_model/all_card_response_model.dart';
import 'package:http/retry.dart';
import 'response_model/all_card_set_response_model.dart';
import "package:collection/collection.dart";

class CardSetInformation {
  final AllCardSetResponse setInfo;
  final List<CardData> cards;

  CardSetInformation({required this.setInfo, required this.cards});
}

class IsolatedParamForFilterCardSet {
  final AllCardResponseModel allCards;
  final List<AllCardSetResponse> cardSets;

  IsolatedParamForFilterCardSet(
    this.allCards,
    this.cardSets,
  );
}

class YugiohService {
  final _client = RetryClient(http.Client());
  final _linkToGetAllSet = 'https://db.ygoprodeck.com/api/v7/cardsets.php';
  final _linkToGetAllCards = 'https://db.ygoprodeck.com/api/v7/cardinfo.php';
  final BehaviorSubject<AllCardResponseModel> _allCards =
      BehaviorSubject<AllCardResponseModel>.seeded(
          AllCardResponseModel(data: []));
  final BehaviorSubject<List<AllCardSetResponse>> _allCardSet =
      BehaviorSubject<List<AllCardSetResponse>>.seeded([]);
  final BehaviorSubject<List<CardSetInformation>> _allCardSetWithCards =
      BehaviorSubject<List<CardSetInformation>>.seeded([]);
  YugiohService() {
    _buildAllCardSet();
    getAllCardFromApi();
    getAllCardSetFromApi();
  }
  Future<void> getAllCardFromApi() async {
    try {
      var response = await _client.get(Uri.parse(_linkToGetAllCards));
      final result = await compute(parseResult, response.body);
      _allCards.add(result);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  getAllCardSetFromApi() async {
    try {
      var response = await _client.get(Uri.parse(_linkToGetAllSet));
      final result = allCardSetResponseFromJson(response.body)
          .map((e) => (e.tcgDate != null)
              ? e
              : e.copyWith(tcgDate: DateTime.utc(-271821, 04, 20)))
          .toList();

      result.sort((a, b) => b.tcgDate!.compareTo(a.tcgDate!));
      _allCardSet.add(result);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Stream<AllCardResponseModel> observerAllCardInformation() {
    return _allCards.stream;
  }

  Stream<List<CardSetInformation>> observeCardSet() {
    return _allCardSetWithCards.stream;
  }

  _buildAllCardSet() {
    Rx.combineLatest2(
      _allCards.stream,
      _allCardSet.stream,
      (
        AllCardResponseModel allCards,
        List<AllCardSetResponse> cardSets,
      ) async {
        /// Isolated for better UX
        return compute(filteringCardSet,
            IsolatedParamForFilterCardSet(allCards, cardSets));
      },
    ).listen((event) {
      event.then(
        (value) => _allCardSetWithCards.add(value),
      );
    });
  }

  dispose() {
    _allCards.close();
  }
}

/// All code below is thread-spawn function
/// Because the parsing method is really heavy,
///  so we want to move it to another thread to keep the UI interaction
AllCardResponseModel parseResult(String responseBody) {
  final parsed = jsonDecode(responseBody);
  return AllCardResponseModel.fromJson(parsed);
}

List<CardSetInformation> filteringCardSet(
  IsolatedParamForFilterCardSet input,
) {
  final allCardsData = input.allCards.data ?? [];
  return input.cardSets
      .map(
        (cardSet) => CardSetInformation(
            cards: allCardsData.where((element) {
              if (element.cardSets == null) {
                return false;
              }

              final result = element.cardSets
                      ?.map((card) => card.setName?.toLowerCase())
                      .contains(cardSet.setName?.toLowerCase()) ??
                  false;

              return result;
            }).toList(),
            setInfo: cardSet),
      )
      .toList();
}

Set<String> findAllCardSet(AllCardResponseModel responseModel) {
  if (responseModel.data == null) {
    return <String>{};
  }
  return responseModel.data!
      .map((e) => e.cardSets?.map((setCard) => setCard.setName))
      .expand((element) => element?.whereType<String>().toList() ?? [])
      .whereType<String>()
      .toSet();
}
