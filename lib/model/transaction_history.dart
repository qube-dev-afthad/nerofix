// To parse this JSON data, do
//
//     final transactionHistory = transactionHistoryFromJson(jsonString);

import 'dart:convert';

List<TransactionHistory> transactionHistoryFromJson(String str) => List<TransactionHistory>.from(json.decode(str).map((x) => TransactionHistory.fromJson(x)));

String transactionHistoryToJson(List<TransactionHistory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TransactionHistory {
    DateTime redemptionDate;
    int amount;
    String status;

    TransactionHistory({
        required this.redemptionDate,
        required this.amount,
        required this.status,
    });

    factory TransactionHistory.fromJson(Map<String, dynamic> json) => TransactionHistory(
        redemptionDate: DateTime.parse(json["Redemption_Date"]),
        amount: json["Amount"],
        status: json["Status"],
    );

    Map<String, dynamic> toJson() => {
        "Redemption_Date": redemptionDate.toIso8601String(),
        "Amount": amount,
        "Status": statusValues.reverse[status],
    };
}

enum Status {
    IN_PROGRESS,
    VERIFIED
}

final statusValues = EnumValues({
    "In-progress": Status.IN_PROGRESS,
    "Verified": Status.VERIFIED
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
