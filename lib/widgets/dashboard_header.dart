// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nerofix/constants/app_assets.dart';
import 'package:nerofix/utils/app_essentials.dart';
import 'package:nerofix/widgets/common_widgets.dart';

class DashboardHeader extends StatelessWidget {
  final VoidCallback? onTap;
  final String points;
  final String name;
  final String memberType;
  final bool hideTrailing;
  const DashboardHeader(
      {super.key,
      this.onTap,
      required this.memberType,
      required this.name,
      required this.points,
      this.hideTrailing = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 300,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    getMemberConfig(memberType).backGroundImage,
                  ),
                  fit: BoxFit.fill)
              //     gradient: LinearGradient(
              //   begin: Alignment(0.00, -1.00),
              //   end: Alignment(0, 1),
              //   colors: getMemberConfig(memberType).gradients,
              // )

              ),
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Image.asset(
                    getMemberConfig(memberType).memberBanner,
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
    return ListTile(
      tileColor: getMemberConfig(memberType).bottomColor,
      onTap: onTap,
      minLeadingWidth: 0,
      horizontalTitleGap: 0,
      leading: const SizedBox(
        width: 0,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal:20, vertical: 14).copyWith(right: 16),
      title: Row(
        children: [
          RegularText(
            text: AppEssential.parseCurrency(points, withoutLeading: true)
                .toString(),
            textAlign: TextAlign.start,
            color:  getMemberConfig(memberType).bottomTextColor,
            fontSize: 40,
            fontWeight: FontWeight.w700,
          ),
          SizedBox(
            width: 10,
          ),
          RegularText(
            text: 'POINTS \nAVAILABLE',
            color: getMemberConfig(memberType).bottomTextColor,
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
              color:getMemberConfig(memberType).bottomTextColor,
            )
          : SizedBox(),
    );
  }

  MemberType getMemberConfig(String memberType) {
    switch (memberType.toLowerCase()) {
      case 'bronze':
        return MemberType(
          bottomTextColor: Colors.white,
            bottomColor: Color(0xFF7A5529),
            backGroundImage: bronzeBackgound,
            memberBanner: bronzeBanner,
            gradients: [Colors.yellow, Colors.amber]);
      case 'platinum':
        return MemberType(
            bottomTextColor: Colors.white,
            bottomColor: Color(0xFF212121),
            backGroundImage: platinumBannerBg,
            memberBanner: platinumBanner,
            gradients: [Colors.yellow, Colors.amber]);
      case 'gold':
        return MemberType(
            bottomTextColor: Colors.white,
            bottomColor: Color(0xFFBD9233),
            backGroundImage: goldBackgound,
            memberBanner: goldBanner,
            gradients: [
              Color(0xFF818181),
              Color(0xFFF3E7FD),
              Color(0x00CCCCCC)
            ]);
      case 'silver':
        return MemberType(
          bottomTextColor: Colors.black,
            bottomColor: Color(0xFFDADADA),
            backGroundImage: silverBackgound,
            memberBanner: silverBanner,
            gradients: [Colors.yellow, Colors.amber]);

      default:
        return MemberType(
           bottomTextColor: Colors.black,
            bottomColor: Color(0xFFDADADA),
            backGroundImage: silverBackgound,
            memberBanner: silverBanner,
            gradients: [Colors.yellow, Colors.amber]);
    }
  }
}

class MemberType {
  String memberBanner;
  Color bottomColor;
  List<Color> gradients;
  String backGroundImage;
  Color bottomTextColor;
  MemberType({
    required this.memberBanner,
    required this.gradients,
    required this.bottomTextColor,
    required this.bottomColor,
    required this.backGroundImage,
  });

  @override
  String toString() =>
      'MemberType(memberBanner: $memberBanner, gradients: $gradients)';

  @override
  bool operator ==(covariant MemberType other) {
    if (identical(this, other)) return true;

    return other.memberBanner == memberBanner &&
        listEquals(other.gradients, gradients);
  }

  @override
  int get hashCode => memberBanner.hashCode ^ gradients.hashCode;
}
