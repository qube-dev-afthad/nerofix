import 'package:flutter/material.dart';
import 'package:nerofix/constants/app_assets.dart';
import 'package:nerofix/constants/app_colors.dart';
import 'package:nerofix/widgets/common_widgets.dart';
import 'package:nerofix/widgets/dashboard_header.dart';
import 'package:nerofix/widgets/transaction_history.dart';

class PointsHistory extends StatelessWidget {
  const PointsHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            DashboardHeader(
              name: 'name',
              points: '666',
              hideTrailing: true,
            ),
            Column(
              children: [
                SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _pointsBriefCard(
                          url: pills, points: '333', label: 'Total Points \nEarned'),
                      _pointsBriefCard(
                          url: gift, points: '333', label: 'Total Points Redeemed'),
                    ],
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                TransactionHistory(
                  data: [
                    TransactionHistoryData(
                        amount: '100', date: '2023-01-01', status: 'Completed'),
                    TransactionHistoryData(
                        amount: '50', date: '2023-02-01', status: 'Pending'),
                    TransactionHistoryData(
                        amount: '75', date: '2023-03-01', status: 'Completed'),
                    TransactionHistoryData(
                        amount: '30', date: '2023-04-01', status: 'Pending'),
                  ],
                  isAtRedemption: false,
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }

  Widget _pointsBriefCard(
      {required String url, required String points, required String label}) {
    return Container(
      width: 155,
      decoration: BoxDecoration(
          color: AppColors.lightGray, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
                radius: 30,
                backgroundColor: AppColors.primaryGreen,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(url),
                )),
            SizedBox(
              height: 8,
            ),
            RegularText(
              text: points,
              fontSize: 32,
              fontWeight: FontWeight.w700,
            ),
            SizedBox(
              height: 8,
            ),
            RegularText(
              text: label,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }
}
