// To parse this JSON data, do
//
//     final dealers = dealersFromJson(jsonString);

import 'dart:convert';

List<Dealers> dealersFromJson(dynamic str) => List<Dealers>.from(str.map((x) => Dealers.fromJson(x)));

String dealersToJson(List<Dealers> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Dealers {
    String dealerName;
    String address;

    Dealers({
        required this.dealerName,
        required this.address,
    });

    factory Dealers.fromJson(Map<String, dynamic> json) => Dealers(
        dealerName: json["dealer_name"],
        address: json["address"],
    );

    Map<String, dynamic> toJson() => {
        "dealer_name": dealerName,
        "address": address,
    };
}
