// To parse this JSON data, do
//
//     final totalPoints = totalPointsFromJson(jsonString);

import 'dart:convert';

List<TotalPoints> totalPointsFromJson(dynamic str) =>
    List<TotalPoints>.from(str.map((x) => TotalPoints.fromJson(x)));

String totalPointsToJson(List<TotalPoints> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TotalPoints {
  int totalPointsRedeemed;
  int totalPointsEarned;

  TotalPoints({
    required this.totalPointsRedeemed,
    required this.totalPointsEarned,
  });

  factory TotalPoints.fromJson(Map<String, dynamic> json) => TotalPoints(
        totalPointsRedeemed: json["TotalPointsRedeemed"]??0,
        totalPointsEarned: json["TotalPointsEarned"]??0,
      );

  Map<String, dynamic> toJson() => {
        "TotalPointsRedeemed": totalPointsRedeemed,
        "TotalPointsEarned": totalPointsEarned,
      };
}
