import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nerofix/constants/app_assets.dart';
import 'package:nerofix/constants/app_colors.dart';
import 'package:nerofix/routes/app_routes.dart';
import 'package:nerofix/widgets/common_widgets.dart';

class DashboardLeaderBoard extends StatelessWidget {
  const DashboardLeaderBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10).copyWith(right: 0),
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
                city: 'Mumbai',
                name: 'Harikrishnan s',
                points: '800',
                type: 'silver'),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: _crownWidget(
                  city: 'Mumbai',
                  name: 'Harikrishnan s',
                  points: '800',
                  type: 'gold'),
            ),
            _crownWidget(
                city: 'Mumbai',
                name: 'Harikrishnan s',
                points: '800',
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

        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: AppColors.leaderBoardCardColor,),
      
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            if (type == 'gold') _imageContainer(gold, 'HK', 'gold'),
            if (type == 'silver') _imageContainer(silver, 'HK', 'silver'),
            if (type == 'platinum') _imageContainer(platinum, 'HK', 'platinum'),
            const RegularText(
              text: '650',
              color: AppColors.scoreColorYellow,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
            const RegularText(
              text: 'Harikrishanan\nAnand',
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
            const RegularText(
              text: 'Mumbai',
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
      height: 60,
      width: 60,
      child: Center(
          child: Padding(
        padding: EdgeInsets.only(bottom: type == 'gold' ? 0 : 20),
        child: RegularText(
          text: text,
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
      )),
      decoration:
          BoxDecoration(image: DecorationImage(image: AssetImage(image))),
    );
  }
}
