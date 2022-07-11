// To parse this JSON data, do
//
//     final allCardSetResponse = allCardSetResponseFromJson(jsonString);

import 'dart:convert';

List<AllCardSetResponse> allCardSetResponseFromJson(String str) =>
    List<AllCardSetResponse>.from(
        json.decode(str).map((x) => AllCardSetResponse.fromJson(x)));

String allCardSetResponseToJson(List<AllCardSetResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllCardSetResponse {
  AllCardSetResponse({
    this.setName,
    this.setCode,
    this.numOfCards,
    this.tcgDate,
  });

  String? setName;
  String? setCode;
  int? numOfCards;
  DateTime? tcgDate;

  factory AllCardSetResponse.fromJson(Map<String, dynamic> json) =>
      AllCardSetResponse(
        setName: json["set_name"],
        setCode: json["set_code"],
        numOfCards: json["num_of_cards"],
        tcgDate:
            json["tcg_date"] == null ? null : DateTime.parse(json["tcg_date"]),
      );

  Map<String, dynamic> toJson() => {
        "set_name": setName,
        "set_code": setCode,
        "num_of_cards": numOfCards,
        "tcg_date": tcgDate == null
            ? null
            : "${tcgDate?.year.toString().padLeft(4, '0')}-${tcgDate?.month.toString().padLeft(2, '0')}-${tcgDate?.day.toString().padLeft(2, '0')}",
      };

  AllCardSetResponse copyWith({
    String? setName,
    String? setCode,
    int? numOfCards,
    DateTime? tcgDate,
  }) =>
      AllCardSetResponse(
        setName: setName ?? this.setName,
        setCode: setCode ?? this.setCode,
        numOfCards: numOfCards ?? this.numOfCards,
        tcgDate: tcgDate ?? this.tcgDate,
      );
}
