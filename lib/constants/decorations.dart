import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nerofix/constants/app_colors.dart';

class Decorations {
  static InputDecoration loginTextFeild(
      {String? label,
      required bool isValid,
      BoxConstraints? constraints,
      Widget? suffix,
      Widget? prefix,
      EdgeInsets? edgeInsets,
      String? hintText}) {
    // Define the border here, for example, using OutlineInputBorder
    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      // Adjust the border radius as needed
      borderSide: BorderSide(
        color: Colors.black, // Border color
        width: 1.0, // Border width
      ),
    );

    return InputDecoration(
        prefixIcon: prefix,
        hintText: hintText,
        suffixIcon: suffix,
        alignLabelWithHint: true,
        hintStyle: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontFamily: 'DM Sans',
          fontWeight: FontWeight.w400,
          height: 0.09,
        ),

        // labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        contentPadding: edgeInsets != null
            ? EdgeInsets.symmetric(horizontal: 0)
            : edgeInsets,
        // Set the border property to the custom outlineInputBorder
        border: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        disabledBorder: outlineInputBorder,
        errorBorder: outlineInputBorder,
        focusedErrorBorder: outlineInputBorder);
  }

  static InputDecoration normalTextField(
      {String? label,
      required bool isValid,
      BoxConstraints? constraints,
      Widget? suffix,
      Widget? prefix,
      EdgeInsets? edgeInsets,
      String? hintText}) {
    // Define the border here, for example, using OutlineInputBorder
    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      // Adjust the border radius as needed
      borderSide: BorderSide(
        color: Colors.black, // Border color
        width: 1.0, // Border width
      ),
    );

    return InputDecoration(
        prefixIcon: prefix,
        hintText: hintText,
        suffixIcon: suffix,
        fillColor: Colors.white,
        filled: true,
        alignLabelWithHint: true,
        hintStyle: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontFamily: 'DM Sans',
          fontWeight: FontWeight.w400,
          height: 0.09,
        ),
        constraints: BoxConstraints.tight(Size(Get.width, 50)),
        // labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        contentPadding: edgeInsets != null
            ? EdgeInsets.symmetric(horizontal: 0)
            : edgeInsets,
        // Set the border property to the custom outlineInputBorder
        border: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        disabledBorder: outlineInputBorder,
        errorBorder: outlineInputBorder,
        focusedErrorBorder: outlineInputBorder);
  }
   static InputDecoration searchTextField(
      {String? label,
      required bool isValid,
      BoxConstraints? constraints,
      Widget? suffix,
      Widget? prefix,
      EdgeInsets? edgeInsets,
      String? hintText}) {
    // Define the border here, for example, using OutlineInputBorder
    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      // Adjust the border radius as needed
      borderSide: BorderSide(
        color: AppColors.greyBackground, // Border color
        width: 0.0, // Border width
      ),
    );

    return InputDecoration(
        prefixIcon: prefix,
        hintText: hintText,
        suffixIcon: suffix,
        fillColor: AppColors.greyBackground,
        filled: true,
        alignLabelWithHint: true,
        hintStyle: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontFamily: 'DM Sans',
          fontWeight: FontWeight.w400,
          height: 0.09,
        ),
        constraints: BoxConstraints.tight(Size(Get.width, 50)),
        // labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        contentPadding: edgeInsets != null
            ? EdgeInsets.symmetric(horizontal: 0)
            : edgeInsets,
        // Set the border property to the custom outlineInputBorder
        border: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        disabledBorder: outlineInputBorder,
        errorBorder: outlineInputBorder,
        focusedErrorBorder: outlineInputBorder);
  }
}
