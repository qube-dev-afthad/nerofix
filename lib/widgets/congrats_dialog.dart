// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nerofix/constants/app_assets.dart';
import 'package:nerofix/widgets/common_widgets.dart';

class CongratsDialog extends StatelessWidget {
 final String title;
 final String subtitle;
  const CongratsDialog({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        Image.asset(congrats),
        SizedBox(
          height: 20,
        ),
        RegularText(
            text: title, fontSize: 24, fontWeight: FontWeight.w700),
        SizedBox(
          height: 16,
        ),
        RegularText(
          text:
              subtitle,
          fontSize: 16,
        ),
        SizedBox(
          height: 35,
        ),
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: RegularText(
            text: 'Ok, Thank You',
            isUnderlined: true,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        )
      ]),
    );
  }
}
