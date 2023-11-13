import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nerofix/constants/app_assets.dart';
import 'package:nerofix/routes/app_routes.dart';
import 'package:nerofix/widgets/rich_text.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../constants/app_colors.dart';
import '../widgets/common_widgets.dart';

class VerifyOtp extends StatefulWidget {
  const VerifyOtp({super.key});

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Image.asset(banner),
          const SizedBox(
            height: 30,
          ),
          const RegularText(
            text: 'Verify Account!',
            fontSize: 40,
            fontWeight: FontWeight.w700,
          ),
          SizedBox(
            height: 24,
          ),
          const RichTextWidget(
            alignment: TextAlign.center,
            texts: [
              TextModel(
                  text: 'Enter 4-digit Code code we have sent to\nat ',
                  style: TextStyle(
                    color: Color(0xCC1C1939),
                    fontSize: 16,
                    // fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w400,
                  )),
              TextModel(
                text: '+0000000000',
                style: TextStyle(
                  color: Color(0xFF0063F7),
                  fontSize: 16,
                  // fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.underline,
                ),
              )
            ],
            maxLines: 10,
          ),
          SizedBox(
            height: 34,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: PinCodeTextField(
              length: 6,
              obscureText: false,
              pinTheme: PinTheme(
                  activeColor: AppColors.lightBlue,
                  inactiveColor: AppColors.lightBlue),

              keyboardType: TextInputType.number,
              animationType: AnimationType.fade,
              textStyle: TextStyle(color: AppColors.greyText),
              animationDuration: Duration(milliseconds: 300),
              // errorAnimationController: errorController, // Pass it here
              onChanged: (value) {
                if (value.length == 6) {
                  Get.toNamed(Routes.home);
                }
              },

              appContext: context,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          const RegularText(
            text: 'Didn’t received the code?',
            color: AppColors.darkGray,
            fontSize: 16,
          ),
          const SizedBox(
            height: 15,
          ),
          TextButton(
            onPressed: () {},
            child: const RegularText(
              text: 'Resend OTP',
              isUnderlined: true,
              color: AppColors.darkGray,
              fontSize: 16,
            ),
          )
        ],
      ),
    ));
  }
}
