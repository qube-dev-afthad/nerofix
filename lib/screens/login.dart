import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nerofix/constants/app_assets.dart';
import 'package:nerofix/constants/app_colors.dart';
import 'package:nerofix/routes/app_routes.dart';
import 'package:nerofix/utils/app_essentials.dart';
import 'package:nerofix/widgets/add_new_user.dart';
import 'package:nerofix/widgets/common_widgets.dart';
import 'package:nerofix/widgets/primary_button.dart';

import '../constants/decorations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset(banner),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const RegularText(
                        text: 'Mobile Number',
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      const RegularText(
                        text:
                            'Please enter your phone number. We will send you 4-digit code to verify your account.',
                        fontSize: 16,
                        color: Color(0xCC1C1939),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      TextFormField(
                        cursorColor: Colors.black,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w400,
                        ),
                        textCapitalization: TextCapitalization.none,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: Decorations.loginTextFeild(
                            isValid: false,
                            hintText: 'Mobile Number Enter Kijiye'),
                        keyboardType: TextInputType.number,
                        autovalidateMode: AutovalidateMode.disabled,
                        onChanged: (value) {},
                        validator: (value) {
                          if (value == null || value == '') {
                            return 'Enter valid mobile';
                          }
                          if (!AppEssential.isMobileValid(value)) {
                            return 'Enter valid mobile';
                          }
                        },
                        onSaved: (s) {
                          if (s!.isNotEmpty) {}
                        },
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      PrimaryButtonView(
                        animationId: '',
                        height: 50,
                      
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Get.toNamed(Routes.verifyOtp);
                          }
                        },
                      
                          name: 'Send OTP',
                        
                        ),
                      
                      TextButton(
                        onPressed: () {
                          Get.dialog(AddNewUser());
                        },
                        child: const RegularText(
                          text: 'New User',
                          isUnderlined: true,
                          color: AppColors.darkGray,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
