import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nerofix/constants/app_colors.dart';
import 'package:nerofix/controllers/delears_list_controller.dart';
import 'package:nerofix/routes/app_routes.dart';
import 'package:nerofix/widgets/common_widgets.dart';
import 'package:nerofix/widgets/dealers_card.dart';

class DelearsList extends GetView<DelearsListController> {
  const DelearsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(right: 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () => Row(
                  children: [
                    const RegularText(
                      text: 'Top Dealers ',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    const Icon(
                      size: 14,
                      Icons.location_on_outlined,
                    ),
                    RegularText(
                      text: controller.isLocationLoaded.value
                          ? controller.city!
                          : "Fetching location..",
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    )
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.toNamed(Routes.searchDealer);
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(left: 0),
            child: const DelearsCard(
              address:
                  'Lal Bahadur Shastri Marg, Battipada, Bhandup West, Mumbai, Maharashtra 400078',
              name: 'Kansai Nerolac Paints Ltd.',
            ),
          )
        ],
      ),
    );
  }
}
