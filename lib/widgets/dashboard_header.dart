import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nerofix/constants/app_assets.dart';
import 'package:nerofix/constants/app_colors.dart';
import 'package:nerofix/utils/app_essentials.dart';
import 'package:nerofix/widgets/common_widgets.dart';

class DashboardHeader extends StatelessWidget {
  final VoidCallback? onTap;
  final String points;
  final String name;
  final bool hideTrailing;
  const DashboardHeader(
      {super.key,
      this.onTap,
      required this.name,
      required this.points,
      this.hideTrailing = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 300,
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage(platinumBannerBg),fit: BoxFit.fill)),
         
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Image.asset(
                    platinumBanner,
                    height: 200,
                    width: Get.width - 50,
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 20,
                right: 20,
                child: SizedBox(
                  width: Get.width - 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RegularText(
                        text: 'Hi, Harikrishnan',
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                      Image.asset(
                        logo,
                        height: 80,
                        width: 80,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        _pointCard(),
      ],
    );
  }

  Widget _pointCard() {
    return Container(
      decoration: BoxDecoration(color: AppColors.bannerBlack),
      child: ListTile(
        onTap: onTap,
        minLeadingWidth: 0,
        horizontalTitleGap: 0,
        leading: const SizedBox(
          width: 0,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        title: Row(
          children: [
            RegularText(
              text:AppEssential.parseCurrency(points,withoutLeading: true).toString() ,
              textAlign: TextAlign.start,
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.w700,
            ),
            SizedBox(
              width: 10,
            ),
            RegularText(
              text: 'POINTS \nAVAILABLE',
              color: Colors.white.withOpacity(.7),
              fontSize: 16,
              textAlign: TextAlign.start,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
        trailing: !hideTrailing
            ? RegularText(
                text: 'View points',
                fontWeight: FontWeight.w500,
                fontSize: 10,
                color: Colors.white.withOpacity(.8),
              )
            : SizedBox(),
      ),
    );
  }
  // Row(
  //       children: [
  //         Column(
  //           children: [

  //           ],
  //         )
  //       ],
  //     ),
}
