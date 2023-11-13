import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nerofix/constants/app_colors.dart';
import 'package:nerofix/controllers/button_controller.dart';
import 'package:nerofix/widgets/common_widgets.dart';
import 'package:nerofix/widgets/regular_button.dart';

class PrimaryButtonView extends GetView<ButtonController> {
  final Key? key;
  final Function()? onPressed;
  final String name;
  final double? height;
  final bool isDisabled;
  bool isOutlined;
  String animationId;
  Color? buttonColor;
  double? borderRadius;
  Color? textColor;
  Color? borderColor;
  Widget? prefixWidget;
  PrimaryButtonView({
    this.onPressed,
    this.key,
    this.borderColor,
    this.isOutlined = false,
    required this.animationId,
    this.isDisabled = false,
    required this.name,
    this.buttonColor = AppColors.darkGray,
    this.prefixWidget,
    this.borderRadius = 8,
    this.textColor = Colors.white,
    this.height,
  });
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.animatedButtons[animationId] == null ||
              controller.animatedButtons[animationId] == false
          ? Align(
              alignment: Alignment.center,
              child: !isOutlined
                  ? RegularButton(
                      key: key,
                      color: buttonColor,
                      borderWidth: .2,
                      borderRadius: borderRadius!,
                      borderColor: borderColor ?? Colors.transparent,
                      widget: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          prefixWidget != null
                              ? prefixWidget!
                              : SizedBox.shrink(),
                          SizedBox(
                            height: 8,
                          ),
                          RegularText(
                            text: name,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: textColor??Colors.white,
                          )
                        ],
                      ),
                      width: Get.width - 48,
                      height: height ?? 54,
                      isDisabled: isDisabled,
                      onPressed: controller.animatedButtons[animationId] != true
                          ? onPressed
                          : null,
                    )
                  : RegularButton(
                      key: key,
                      borderRadius: borderRadius!,
                      color: Colors.transparent,
                      borderWidth: .5,
                      borderColor: borderColor ?? AppColors.mediumGray,
                      widget: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RegularText(
                            text: name,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                             color: textColor??Colors.white,
                          )
                        ],
                      ),
                      width: Get.width - 48,
                      height: height ?? 54,
                      isDisabled: isDisabled,
                      onPressed: controller.animatedButtons[animationId] != true
                          ? onPressed
                          : null,
                    ),
            )
          : SizedBox(
              height: 54,
              child: Center(
                  child: CircularProgressIndicator(
                color: AppColors.darkGray,
              )),
            ),
    );
  }
}
