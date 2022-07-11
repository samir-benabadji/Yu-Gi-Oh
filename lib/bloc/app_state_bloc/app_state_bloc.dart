
import 'package:yugioh/presentationals/widgets/list_vertical_card_set_widget/list_vertical_card_set_widget.dart';
import 'package:yugioh/services/yugioh_db_service/response_model/all_card_response_model.dart';
import 'package:rxdart/subjects.dart';

class AppStateBloc {
  final BehaviorSubject<CardData> _currentCard = BehaviorSubject<CardData>();
  final BehaviorSubject<ListVerticalCardSetModel> _currentCardSet =
      BehaviorSubject<ListVerticalCardSetModel>();
  acceptCard(CardData newData) {
    _currentCard.add(newData);
  }

  acceptCardSet(ListVerticalCardSetModel newData) {
    _currentCardSet.add(newData);
  }

  Stream<CardData> cardToShow() {
    return _currentCard.stream;
  }

  CardData focusedCard() {
    return _currentCard.value;
  }

  ListVerticalCardSetModel focusedCardSet() {
    return _currentCardSet.value;
  }
}
