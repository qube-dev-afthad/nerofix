import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nerofix/constants/app_colors.dart';
import 'package:nerofix/constants/decorations.dart';
import 'package:nerofix/controllers/dashboard_controller.dart';
import 'package:nerofix/widgets/common_gradient.dart';
import 'package:nerofix/widgets/common_widgets.dart';
import 'package:nerofix/widgets/congrats_dialog.dart';
import 'package:nerofix/widgets/primary_button.dart';
import 'package:nerofix/widgets/transaction_history.dart';

class RedeemPoints extends GetView<DashboardController> {
  const RedeemPoints({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CommonGradient(
            widget: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                RegularText(
                  text: 'Redeem Points',
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10)
                    ],
                    keyboardType: TextInputType.number,
                    decoration: Decorations.normalTextField(
                        isValid: true, hintText: 'Enter Redemption Amount'),
                  ),
                ),
                SizedBox(height: 32),
                PrimaryButtonView(
                    onPressed: () {
                      Get.dialog(CongratsDialog(
                        title: 'Congratulations',
                        subtitle:
                            'Aapka Redemption Request Submit ho chuka hai aur Verification Process mein hai.',
                      ));
                    },
                    height: 50,
                    buttonColor: AppColors.primaryGreen,
                    animationId: 'animationId',
                    textColor: AppColors.darkGray,
                    name: 'Submit'),
                SizedBox(height: 50),
                Container(),
                Expanded(
                  child: Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      color: AppColors.greyBackground.withOpacity(.9),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TransactionHistory(
                              data: [
                                if (controller.transactionHistory.isNotEmpty)
                                  for (int i = 0;
                                      i < controller.transactionHistory.length;
                                      i++)
                                    TransactionHistoryData(
                                        amount: controller
                                            .transactionHistory[i].amount
                                            .toString(),
                                        date: DateFormat('dd-MM-yyyy').format(
                                            controller.transactionHistory[i]
                                                .redemptionDate),
                                        status: controller
                                            .transactionHistory[i].status
                                            .toString()),
                              ],
                              isAtRedemption: false,
                            ),
                            if(controller.transactionHistory.isEmpty)
                           RegularText(text: 'No data found',fontWeight: FontWeight.w300,)
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
