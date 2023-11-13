// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nerofix/constants/app_colors.dart';
import 'package:nerofix/widgets/common_widgets.dart';

class TransactionHistory extends StatelessWidget {
  final List<TransactionHistoryData> data;
  final bool isAtRedemption;
  const TransactionHistory(
      {super.key, required this.data, this.isAtRedemption = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RegularText(
          text: 'Transaction History',
          fontSize: 18,
        ),
        
        SingleChildScrollView(
          child: DataTable(
            
            
            decoration: BoxDecoration(
              
              border: Border(
                  bottom: BorderSide(color: AppColors.greyText2, width: .2)),
            ),
            columns: [
              
              DataColumn(label: _labelText('Redemption Date')),
              DataColumn(
                label: _labelText('Amount'),
              ),
              DataColumn(label: _labelText('Status')),
            ],
            rows: data
                .map(
                  (transaction) => DataRow(
                    cells: [
                      DataCell(_labelText(
                        transaction.date,
                      )),
                      DataCell(_labelText(
                        transaction.amount,
                      )),
                      DataCell(_labelText(
                        transaction.status,
                      )),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }

  Widget _labelText(String label) {
    return RegularText(
      text: label,
      fontSize: 12,
      color: AppColors.greyText2,
    );
  }
}

class TransactionHistoryData {
  String amount;
  String date;
  String status;
  TransactionHistoryData({
    required this.amount,
    required this.date,
    required this.status,
  });

  TransactionHistoryData copyWith({
    String? amount,
    String? date,
    String? status,
  }) {
    return TransactionHistoryData(
      amount: amount ?? this.amount,
      date: date ?? this.date,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'amount': amount,
      'date': date,
      'status': status,
    };
  }

  factory TransactionHistoryData.fromMap(Map<String, dynamic> map) {
    return TransactionHistoryData(
      amount: map['amount'] as String,
      date: map['date'] as String,
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionHistoryData.fromJson(String source) =>
      TransactionHistoryData.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'TransactionHistoryData(amount: $amount, date: $date, status: $status)';

  @override
  bool operator ==(covariant TransactionHistoryData other) {
    if (identical(this, other)) return true;

    return other.amount == amount &&
        other.date == date &&
        other.status == status;
  }

  @override
  int get hashCode => amount.hashCode ^ date.hashCode ^ status.hashCode;
}

  // ListTile(
  //             title: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text('Amount'),
  //                 Text('Date'),
  //                 Text('Status'),
  //               ],
  //             ),
  //           ),
  //           // Divider
  //           Divider(thickness: 2.0),
  //           // Data
  //           ...transactions.map((transaction) => ListTile(
  //                 title: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Text(transaction.amount),
  //                     Text(transaction.date),
  //                     Text(transaction.status),
  //                   ],
  //                 ),
  //               )),