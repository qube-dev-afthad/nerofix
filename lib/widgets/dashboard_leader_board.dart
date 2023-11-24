import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nerofix/constants/app_assets.dart';
import 'package:nerofix/constants/app_colors.dart';
import 'package:nerofix/controllers/dashboard_controller.dart';
import 'package:nerofix/routes/app_routes.dart';
import 'package:nerofix/utils/app_essentials.dart';
import 'package:nerofix/widgets/common_widgets.dart';

class DashboardLeaderBoard extends GetView<DashboardController> {
  const DashboardLeaderBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 20).copyWith(right: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const RegularText(
                text: 'Leader Board (All India)',
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              TextButton(
                onPressed: () {
                  Get.toNamed(Routes.leaderBoard);
                },
                child: const RegularText(
                  text: 'View All',
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: AppColors.greyText2,
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _crownWidget(
                city: controller.leaderBoard[1].city.toString().capitalize!,
                name: controller.leaderBoard[1].name.toString(),
                points: controller.leaderBoard[1].earningPoint.toString(),
                type: 'silver'),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: _crownWidget(
                  city: controller.leaderBoard[0].city.toString().capitalize!,
                  name: controller.leaderBoard[0].name.toString(),
                  points: controller.leaderBoard[0].earningPoint.toString(),
                  type: 'gold'),
            ),
            _crownWidget(
                city: controller.leaderBoard[2].city.toString().capitalize!,
                name: controller.leaderBoard[2].name.toString(),
                points: controller.leaderBoard[2].earningPoint.toString(),
                type: 'platinum'),
          ],
        )
      ],
    );
  }

  Widget _crownWidget(
      {required String points,
      required String name,
      required String type,
      required String city}) {
    return Container(
      width: 100,
      height:type == 'gold'? 160:150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.leaderBoardCardColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            if(type != 'gold')
            const SizedBox(height: 15),
            if (type == 'gold')
              _imageContainer(gold, name, 'gold'),
            if (type == 'silver')
              _imageContainer(
                  silver, name, 'silver'),
            if (type == 'platinum')
              _imageContainer(
                  platinum, name, 'platinum'),
            RegularText(
              text: points,
              color: AppColors.scoreColorYellow,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
            RegularText(
              text:AppEssential.splitFirstTwoWords(name) ,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
            RegularText(
              text: city.capitalize!,
              fontSize: 8,
              fontWeight: FontWeight.w400,
            ),
          ],
        ),
      ),
    );
  }

  _imageContainer(String image, String text, String type) {
    return Container(
      height:type == 'gold'?80: 60,
      width: 60,
      decoration:
          BoxDecoration(
          
            image: DecorationImage(image: AssetImage(image),)),
      child: Center(
          child: Padding(
        padding: EdgeInsets.only(bottom: type == 'gold' ? 0 : 20),
        child: RegularText(
          text: AppEssential.getFirstLetters(text),
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
      )),
    );
  }
}
