// To parse this JSON data, do
//
//     final states = statesFromJson(jsonString);

import 'dart:convert';

List<States> statesFromJson(dynamic str) => List<States>.from(str.map((x) => States.fromJson(x)));

String statesToJson(List<States> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class States {
    String state;

    States({
        required this.state,
    });

    factory States.fromJson(Map<String, dynamic> json) => States(
        state: json["State"],
    );

    Map<String, dynamic> toJson() => {
        "State": state,
    };
}
