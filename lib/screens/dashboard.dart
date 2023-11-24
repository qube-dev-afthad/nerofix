import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nerofix/constants/app_assets.dart';
import 'package:nerofix/constants/app_colors.dart';
import 'package:nerofix/controllers/dashboard_controller.dart';
import 'package:nerofix/routes/app_routes.dart';
import 'package:nerofix/widgets/dashboard_header.dart';
import 'package:nerofix/widgets/dashboard_leader_board.dart';
import 'package:nerofix/widgets/dealers_list_widget.dart';
import 'package:nerofix/widgets/primary_button.dart';
import 'package:nerofix/widgets/shimmer.dart';
import 'package:nerofix/widgets/vedio_list.dart';

class Dashboard extends GetView<DashboardController> {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              controller.onInit();
            },
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => !controller.isUserBalance.value
                        ? DashboardHeader(
                            memberType: (controller.points?.memberType ?? '')
                                .toString(),
                            name: controller.points?.name ?? 'NA',
                            points: controller.points?.balancePts ?? '0',
                            onTap: () {
                              Get.toNamed(Routes.pointsHistory);
                            },
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: ShimmerWidget.textShimmer(Get.width, 300),
                          ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // PrimaryButtonView(
                  //     onPressed: () {
                  //       AppEssential.logOut();
                  //     },
                  //     animationId: 'animationId',
                  //     name: 'LOGOTU'),
                  Obx(
                    () => !controller.isUserBalance.value
                        ? PrimaryButtonView(
                            onPressed: () {
                              Get.toNamed(Routes.redeemPoints);
                            },
                            animationId: 'animationId',
                            name: 'Redeem Points')
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: ShimmerWidget.textShimmer(Get.width, 50),
                          ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 24,
                      ),
                      Obx(() => !controller.isLeaderBoardLoading.value
                          ? controller.leaderBoard.isNotEmpty
                              ? const DashboardLeaderBoard()
                              : SizedBox()
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: ShimmerWidget.textShimmer(Get.width, 150),
                            )),
                      SizedBox(
                        height: 24,
                      ),
                      DelearsList(),
                      SizedBox(
                        height: 24,
                      ),
                      Obx(() => !controller.isYoutubeLoading.value
                          ? VideoList(
                              vedios: controller.youtubeVedios,
                              title: 'Questions? Watch Videos',
                            )
                          : SizedBox())
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              backgroundColor: AppColors.darkGray,
              onPressed: () {
                Get.toNamed(Routes.scanCoupon);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(qr),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            onTap: ((value) {
              if (value == 1) {}
            }),
            unselectedFontSize: 12,
            selectedFontSize: 12,
            selectedItemColor: Colors.black,
            unselectedItemColor: AppColors.darkGray,
            selectedLabelStyle:
                const TextStyle(fontSize: 12, color: Colors.black),
            unselectedLabelStyle:
                const TextStyle(fontSize: 12, color: Colors.black),
            currentIndex: 1,
            items: [
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(iButton), label: 'Info'),
              const BottomNavigationBarItem(
                icon: SizedBox(
                  height: 30,
                ),
                label: 'QR SCAN',
              ),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.call), label: 'Call'),
            ]));
  }
}

// BottomAppBar(
//         child: SizedBox(
//           height: 60,
//           child: Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Row(
//               //children inside bottom appbar
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: <Widget>[
//                 Column(
//                   children: [
//                     SvgPicture.asset(iButton),
//                     RegularText(
//                       text: 'Info',
//                       fontSize: 11,
//                     )
//                   ],
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Icon(
//                       Icons.call,
//                     ),
//                     RegularText(
//                       text: '   Call',
//                       fontSize: 11,
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),