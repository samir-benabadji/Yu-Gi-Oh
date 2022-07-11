import 'package:yugioh/bloc/bloc_index.dart';
import 'package:yugioh/services/service_index.dart';
import 'package:yugioh/services/yugioh_db_service/response_model/all_card_response_model.dart';
import 'package:rxdart/rxdart.dart';

import '../../widgets/list_vertical_cards_widget/list_vertical_cards_widget.dart';


class MainScreenBloc {
  final databaseService = ServiceFacade.getService<YugiohService>();
  BehaviorSubject<String> nameFilterString = BehaviorSubject<String>.seeded('');

  acceptFilterName(String nameToFilter) {
    nameFilterString.add(nameToFilter);
  }

  Stream<List<CardInfoOnVerticalListModel>> observeAllcardsChange() {
    return Rx.combineLatest2(
        databaseService.observerAllCardInformation(), nameFilterString.stream,
        (AllCardResponseModel a, String b) {
      if (b.isEmpty) {
        return a.data
                ?.map(
                  (cardFromServer) => CardInfoOnVerticalListModel(
                      cardImage:
                          cardFromServer.cardImages?.first.imageUrl ?? '',
                      cardIndentifier: cardFromServer.id.toString(),
                      cardName: cardFromServer.name ?? '',
                      cardText: ' '),
                )
                .toList() ??
            [];
      }
      return a.data
              ?.where(
                  (element) => element.name?.toLowerCase().contains(b) ?? false)
              .map(
                (cardFromServer) => CardInfoOnVerticalListModel(
                    cardImage: cardFromServer.cardImages?.first.imageUrl ?? '',
                    cardIndentifier: cardFromServer.id.toString(),
                    cardName: cardFromServer.name ?? '',
                    cardText: ' '),
              )
              .toList() ??
          [];
    });
  }

  onFocusCardData(String originalID) {
    databaseService
        .observerAllCardInformation()
        .switchMap(
          (value) => Stream.value(
            value.data?.firstWhere(
              (element) => element.id.toString() == originalID,
            ),
          ),
        )
        .listen((cardToObserve) {
      if (cardToObserve != null) {
        GlobalBloc.appStateBloc.acceptCard(cardToObserve);
      }
    });
  }
}
