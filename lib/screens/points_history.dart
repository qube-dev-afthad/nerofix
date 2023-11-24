import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nerofix/constants/app_assets.dart';
import 'package:nerofix/constants/app_colors.dart';
import 'package:nerofix/controllers/dashboard_controller.dart';
import 'package:nerofix/widgets/common_widgets.dart';
import 'package:nerofix/widgets/dashboard_header.dart';
import 'package:nerofix/widgets/shimmer.dart';
import 'package:nerofix/widgets/transaction_history.dart';

class PointsHistory extends GetView<DashboardController> {
  const PointsHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            DashboardHeader(
              memberType: controller.points!.memberType,
              name: controller.points!.name,
              points: controller.points!.balancePts,
              hideTrailing: true,
            ),
            Column(
              children: [
                SizedBox(
                  height: 24,
                ),
                Obx(
                  () => 
!controller.isLoadingTotalPoints.value?
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _pointsBriefCard(
                            url: pills,
                            points: controller.totalPoints.first.totalPointsEarned.toString(),
                            label: 'Total Points \nEarned'),
                        _pointsBriefCard(
                            url: gift,
                            points: controller.totalPoints.first.totalPointsRedeemed.toString(),
                            label: 'Total Points Redeemed'),
                      ],
                    ),
                  ):ShimmerWidget.textShimmer(Get.width-40,100),
                ),
                SizedBox(
                  height: 24,
                ),
                TransactionHistory(
                  data: [
                    if (controller.transactionHistory.isNotEmpty)
                      for (int i = 0;
                          i < controller.transactionHistory.length;
                          i++)
                        TransactionHistoryData(
                            amount: controller.transactionHistory[i].amount
                                .toString(),
                            date: DateFormat('dd-MM-yyyy').format(controller
                                .transactionHistory[i].redemptionDate),
                            status: controller.transactionHistory[i].status
                                .toString()),
                  ],
                  isAtRedemption: false,
                ),
                 if(controller.transactionHistory.isEmpty)
                            RegularText(text: 'No data found',fontWeight: FontWeight.w300,)
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
      width: Get.width/2.3,
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
