import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nerofix/constants/app_colors.dart';
import 'package:nerofix/controllers/dashboard_controller.dart';
import 'package:nerofix/screens/delears_list_screen.dart';
import 'package:nerofix/widgets/common_widgets.dart';
import 'package:nerofix/widgets/dealers_card.dart';
import 'package:nerofix/widgets/primary_button.dart';

class SearchDealer extends StatefulWidget {
  const SearchDealer({super.key});

  @override
  State<SearchDealer> createState() => _SearchDealerState();
}

class _SearchDealerState extends State<SearchDealer> {
  final List<Widget> dealers = [
    const DelearsCard(
      address:
          'Address: 5W2P+7WQ, Lal Bahadur Shastri Marg, Battipada, Bhandup West, Mumbai, Maharashtra 400078',
      name: 'Kansai Nerolac Paints Ltd.',
    ),
    const DelearsCard(
      address:
          'Address: 5W2P+7WQ, Lal Bahadur Shastri Marg, Battipada, Bhandup West, Mumbai, Maharashtra 400078',
      name: 'Kansai Nerolac Paints Ltd.',
    ),
    // Add more DealersCard instances as needed
  ];
  String selectedCity = '';
  String selectedState = '';

  List<String> cities = [];
  @override
  void initState() {
    controller.getStates();
    super.initState();
  }

  DashboardController controller = Get.find<DashboardController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 50,
          ),
          CarouselSlider(
            options: CarouselOptions(
              enlargeCenterPage: false,
              autoPlay: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
              aspectRatio: 2.0,
            ),
            items: dealers.map((dealer) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: dealer,
                  );
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              dealers.length,
              (index) => buildDotIndicator(index),
            ),
          ),
          const SizedBox(height: 20),
          const RegularText(
            text: 'Search Your Dealer',
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
          const SizedBox(height: 20),
          CupertinoFormRow(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: _showStatePicker,
              child: Container(
                width: Get.width - 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.greyBackground,
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedState.isNotEmpty ? selectedState : 'Select State',
                    ),
                    const RotatedBox(
                      quarterTurns: 1,
                      child: Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 14,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          // City Dropdown
          CupertinoFormRow(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                if (selectedState.isNotEmpty) {
                  _showCityPicker();
                }
              },
              child: Container(
                width: Get.width - 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.greyBackground,
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedCity.isNotEmpty ? selectedCity : 'Select City',
                    ),
                    const RotatedBox(
                      quarterTurns: 1,
                      child: Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 14,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          PrimaryButtonView(
            animationId: 'animationId',
            onPressed: () {
              if (selectedCity.isNotEmpty && selectedState.isNotEmpty) {
                Get.to(DealersListScreen(
                    city: selectedCity, state: selectedState));
              } else {
                Get.snackbar('Try again', 'Select city and state ');
              }
            },
            name: 'Submit',
            textColor: Colors.black,
            buttonColor: AppColors.primaryGreen,
          )
        ],
      ),
    );
  }

  int _currentIndex = 0;

  Widget buildDotIndicator(int index) {
    return Container(
      width: 8.0,
      height: 8.0,
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentIndex == index
            ? AppColors.carouselGrey
            : AppColors.carouselGrey2, // Change color based on your design
      ),
    );
  }

  void _showStatePicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: CupertinoPicker(
            itemExtent: 32,
            onSelectedItemChanged: (int index) {
              setState(() {
                selectedState = controller.states[index].state;
                controller.getCitiesByState(selectedState);
                // cities = indianCities[selectedState]!;
                // selectedCity = cities[0];
              });
            },
            children: controller.states.map((s) {
              return Center(
                child: Text(s.state),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void _showCityPicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: CupertinoPicker(
            itemExtent: 32,
            onSelectedItemChanged: (int index) {
              setState(() {
                selectedCity = controller.cities[index].city;
              });
            },
            children: controller.cities.map((city) {
              return Center(
                child: Text(city.city),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
