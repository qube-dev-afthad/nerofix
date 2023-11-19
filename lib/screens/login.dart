import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nerofix/constants/app_assets.dart';
import 'package:nerofix/constants/app_colors.dart';
import 'package:nerofix/controllers/button_controller.dart';
import 'package:nerofix/controllers/login_controller.dart';
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
  LoginController controller = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();
  String? number;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (() => Future.value(false)),
      child: Scaffold(
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
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
                              if (s!.isNotEmpty) {
                                number = s;
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        SizedBox(
                          width: Get.width,
                          child: PrimaryButtonView(
                            animationId: 'login',
                            height: 50,
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                ButtonController.access.startAnimation('login');
                                var res = await controller.getOtp(number!);
                                ButtonController.access.stopAnimation('login');
                                if (res) {
                                  Get.snackbar('OTP send Successfully',
                                      'Please check the otp in your registered phone');
                                  Get.toNamed(Routes.verifyOtp);
                                } else {
                                  Get.snackbar('Something went wrong',
                                      'Please try again later');
                                }
                                //Get.toNamed(Routes.verifyOtp);
                              }
                            },
                            name: 'Send OTP',
                          ),
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
      ),
    );
  }
}
