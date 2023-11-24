// To parse this JSON data, do
//
//     final cities = citiesFromJson(jsonString);

import 'dart:convert';

List<Cities> citiesFromJson(dynamic str) => List<Cities>.from(str.map((x) => Cities.fromJson(x)));

String citiesToJson(List<Cities> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Cities {
    String city;

    Cities({
        required this.city,
    });

    factory Cities.fromJson(Map<String, dynamic> json) => Cities(
        city: json["City"],
    );

    Map<String, dynamic> toJson() => {
        "City": city,
    };
}
