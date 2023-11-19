// To parse this JSON data, do
//
//     final leaderBoard = leaderBoardFromJson(jsonString);

import 'dart:convert';

List<LeaderBoard> leaderBoardFromJson(String str) => List<LeaderBoard>.from(
    json.decode(str).map((x) => LeaderBoard.fromJson(x)));

String leaderBoardToJson(List<LeaderBoard> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LeaderBoard {
  String name;
  String earningPoint;
  String city;

  LeaderBoard({
    required this.name,
    required this.city,
    required this.earningPoint,
  });

  factory LeaderBoard.fromJson(Map<String, dynamic> json) => LeaderBoard(
        name: json["Name"],
        earningPoint: json["EarningPoint"].toString(),
        city: json['City'] ?? 'NA',
      );

  Map<String, dynamic> toJson() => {
        "Name": name,
        "EarningPoint": earningPoint,
      };
}
