import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nerofix/constants/app_colors.dart';
import 'package:nerofix/utils/app_essentials.dart';
import 'package:nerofix/widgets/common_widgets.dart';

class DelearsCard extends StatelessWidget {
  final String name;
  final String address;
  const DelearsCard({super.key, required this.address, required this.name});

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.only(right: 0),
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(
            color:AppEssential.  generateRandomBlueColor(), borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: AppColors.delearsYellow),
                child: const Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: RegularText(
                    text: 'Top Dealers',
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              RegularText(
                text: name.toUpperCase(),
                fontSize: 24,
                textAlign: TextAlign.start,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              const SizedBox(
                height: 14,
              ),
              RegularText(
                text: address.toUpperCase(),
                textAlign: TextAlign.start,
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
