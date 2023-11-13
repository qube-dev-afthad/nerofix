// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class RegularButton extends StatelessWidget {
  final Function()? onPressed;
  final double? height;
  final double? width;
  final Color? color;
  final Widget? widget;
  final bool isDisabled;
  final double borderWidth;
  final Color borderColor;
  final double borderRadius;
  const RegularButton({
    Key? key,
    this.height,
    this.width,
    this.widget,
    this.borderRadius = 8,
    this.borderWidth = 0,
    this.borderColor = AppColors.darkGray,
    this.isDisabled = false,
    this.color,
    required this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(borderRadius),
      color: !isDisabled ? (color ?? AppColors.darkGray) : AppColors.mediumGray,
      child: MaterialButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              side: BorderSide(color: borderColor, width: borderWidth)),
          child: widget,
          onPressed: !isDisabled ? onPressed : null,
          minWidth: width,
          height: height ?? 45),
    );
  }
}
