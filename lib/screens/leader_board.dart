// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nerofix/constants/app_assets.dart';
import 'package:nerofix/constants/app_colors.dart';
import 'package:nerofix/controllers/dashboard_controller.dart';
import 'package:nerofix/utils/app_essentials.dart';
import 'package:nerofix/widgets/common_gradient.dart';
import 'package:nerofix/widgets/common_widgets.dart';

class LeaderBoard extends GetView<DashboardController> {
  const LeaderBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommonGradient(
          widget: Column(
        children: [
          SizedBox(height: 64),
          RegularText(
            text: 'Leaderboard',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _crownWidget(
                  city: controller.leaderBoard[1].city.toString(),
                  name: controller.leaderBoard[1].name.toString(),
                  points: controller.leaderBoard[1].earningPoint.toString(),
                  type: 'silver'),
              Padding(
                padding: const EdgeInsets.only(bottom: 100.0),
                child: _crownWidget(
                    city: controller.leaderBoard[0].city.toString(),
                    name: controller.leaderBoard[0].name.toString(),
                    points: controller.leaderBoard[0].earningPoint.toString(),
                    type: 'gold'),
              ),
              _crownWidget(
                  city: controller.leaderBoard[2].city.toString(),
                  name: controller.leaderBoard[2].name.toString(),
                  points: controller.leaderBoard[2].earningPoint.toString(),
                  type: 'platinum'),
            ],
          ),
          Expanded(
            child: Container(
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                color: AppColors.greyBackground.withOpacity(.9),
              ),
              child: Column(
                children: [
                  ListView(
                    shrinkWrap: true,
                    children: controller.leaderBoard
                        .map((userScore) => _detailsTile(
                            name: userScore.name,
                            points: userScore.earningPoint))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }

  Widget _crownWidget(
      {required String points,
      required String name,
      required String type,
      required String city}) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Column(
        children: [
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
            color: AppColors.primaryGreen,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
          RegularText(
            text: AppEssential.splitFirstTwoWords(name),
            color: AppColors.lightGray,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
          RegularText(
            color: AppColors.lightGray,
            text: city,
            fontSize: 8,
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    );
  }

  _imageContainer(String image, String text, String type) {
    return Container(
      height: type == 'gold' ? 120 : 84,
      width: type == 'gold' ? 120 : 84,
      decoration:
          BoxDecoration(image: DecorationImage(image: AssetImage(image))),
      child: Center(
          child: Padding(
        padding: EdgeInsets.only(bottom: type == 'gold' ? 0 : 20),
        child: RegularText(
          text:AppEssential.getFirstLetters(text) ,
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
      )),
    );
  }

  Widget _detailsTile({required String name, required String points}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 26,
                    width: 26,
                    decoration: BoxDecoration(
                        color: AppEssential.generateRandomLightColor(),
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.borderColor)),
                    child: Center(
                        child: RegularText(
                      text: 'HR',
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  RegularText(
                    text: name,
                    textAlign: TextAlign.start,
                    fontSize: 12,
                  ),
                ],
              ),
              RegularText(
                text: points,
                fontSize: 12,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class UserScores {
  String name;
  String score;
  UserScores({
    required this.name,
    required this.score,
  });

  UserScores copyWith({
    String? name,
    String? score,
  }) {
    return UserScores(
      name: name ?? this.name,
      score: score ?? this.score,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'score': score,
    };
  }

  factory UserScores.fromMap(Map<String, dynamic> map) {
    return UserScores(
      name: map['name'] as String,
      score: map['score'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserScores.fromJson(String source) =>
      UserScores.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserScores(name: $name, score: $score)';

  @override
  bool operator ==(covariant UserScores other) {
    if (identical(this, other)) return true;

    return other.name == name && other.score == score;
  }

  @override
  int get hashCode => name.hashCode ^ score.hashCode;
}

List<UserScores> userScoresList = [
  UserScores(name: 'John', score: '100'),
  UserScores(name: 'Alice', score: '75'),
  UserScores(name: 'Bob', score: '90'),
  // Add more instances as needed
];
