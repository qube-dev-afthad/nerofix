import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nerofix/constants/app_assets.dart';
import 'package:nerofix/constants/decorations.dart';
import 'package:nerofix/widgets/common_widgets.dart';
import 'package:nerofix/widgets/congrats_dialog.dart';
import 'package:nerofix/widgets/primary_button.dart';

class AddNewUser extends StatefulWidget {
  const AddNewUser({super.key});

  @override
  State<AddNewUser> createState() => _AddNewUserState();
}

class _AddNewUserState extends State<AddNewUser> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            addUser,
            height: 122,
            width: 78,
          ),
          const SizedBox(
            height: 16,
          ),
          const RegularText(
            text: 'Welcome!',
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
          const SizedBox(
            height: 16,
          ),
          TextFormField(decoration: Decorations.normalTextField(isValid: true)),
          const SizedBox(height: 16),
          PrimaryButtonView(
            animationId: 'animationId',
            name: 'Submit',
            onPressed: () {
              Get.back();
              Get.dialog(const CongratsDialog(
                  title: 'Done!',
                  subtitle:
                      'Humare Customer Care Executive aapko call karenge'));
            },
          )
        ],
      ),
    );
  }
}
