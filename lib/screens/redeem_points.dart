import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nerofix/constants/app_colors.dart';
import 'package:nerofix/constants/decorations.dart';
import 'package:nerofix/widgets/common_gradient.dart';
import 'package:nerofix/widgets/common_widgets.dart';
import 'package:nerofix/widgets/congrats_dialog.dart';
import 'package:nerofix/widgets/primary_button.dart';
import 'package:nerofix/widgets/transaction_history.dart';

class RedeemPoints extends StatefulWidget {
  const RedeemPoints({super.key});

  @override
  State<RedeemPoints> createState() => _RedeemPointsState();
}

class _RedeemPointsState extends State<RedeemPoints> {
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
                      child: TransactionHistory(
                        data: [
                          TransactionHistoryData(
                              amount: '100',
                              date: '2023-01-01',
                              status: 'Completed'),
                          TransactionHistoryData(
                              amount: '50',
                              date: '2023-02-01',
                              status: 'Pending'),
                          TransactionHistoryData(
                              amount: '75',
                              date: '2023-03-01',
                              status: 'Completed'),
                          TransactionHistoryData(
                              amount: '30',
                              date: '2023-04-01',
                              status: 'Pending'),
                        ],
                        isAtRedemption: false,
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
