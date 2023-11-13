import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nerofix/constants/app_colors.dart';

class CommonGradient extends StatelessWidget {
  final Widget widget;
  const CommonGradient({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.00, -1.00),
          end: Alignment(0, 1),
          colors: [AppColors.darkGray, Color(0xB7242C34)],
        ),
      ),
      child: widget,
    );
  }
}
