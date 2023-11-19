// To parse this JSON data, do
//
//     final points = pointsFromJson(jsonString);

import 'dart:convert';

Points pointsFromJson(String str) => Points.fromJson(json.decode(str));

String pointsToJson(Points data) => json.encode(data.toJson());

class Points {
    String balancePts;
    String name;
    String memberType;

    Points({
        required this.balancePts,
        required this.name,
        required this.memberType,
    });

    factory Points.fromJson(Map<String, dynamic> json) => Points(
        balancePts:(json['balance_pts']!="") ? json["balance_pts"]??'0':'0',
        name: json["name"],
        memberType: json["member_type"],
    );

    Map<String, dynamic> toJson() => {
        "balance_pts": balancePts,
        "name": name,
        "member_type": memberType,
    };
}
