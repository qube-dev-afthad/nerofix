// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nerofix/constants/api_endpoints.dart';
import 'package:nerofix/constants/decorations.dart';
import 'package:nerofix/core/api.dart';
import 'package:nerofix/model/dealers.dart';
import 'package:nerofix/utils/app_essentials.dart';
import 'package:nerofix/widgets/common_widgets.dart';

class DealersListScreen extends StatefulWidget {
  final String city;
  final String state;
  const DealersListScreen({
    Key? key,
    required this.city,
    required this.state,
  }) : super(key: key);

  @override
  DealersListScreenState createState() => DealersListScreenState();
}

class DealersListScreenState extends State<DealersListScreen> {
  List<Dealers> filteredDealers = [];

  @override
  void initState() {
    getDelears();

    super.initState();
  }

  ApiClient apiClient = ApiClient(APIEndpoint.getSubdomain().url);
  List<Dealers> allDealers = [];
  getDelears() async {
    isLoading = true;
    try {
      var res = await apiClient.postWithFormData(APIEndpoint.dealerSearch,
          {"state": widget.state, "city": widget.city});

      if (res['status']) {
        allDealers.assignAll(dealersFromJson(res['data']));

        filteredDealers.addAll(allDealers);
      }
    } catch (e) {
      Get.snackbar('Something went wrong ', 'Please try after sometime');
    }

    isLoading = false;
    setState(() {});
  }

  bool isLoading = true;
  void filterDealers(String query) {
    setState(() {
      filteredDealers = allDealers
          .where((dealer) =>
              dealer.dealerName.toLowerCase().contains(query.toLowerCase()) ||
              dealer.address.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !isLoading
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: SafeArea(
                child: Column(
                  children: [
                    const RegularText(
                      text: 'View Dealer',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      onChanged: filterDealers,
                      decoration: Decorations.searchTextField(
                          hintText: 'Enter Your Dealers Name',
                          isValid: true,
                          suffix: const Icon(
                            Icons.search,
                            color: Colors.black,
                          )),
                    ),
                    SizedBox(height: 20),
                    if(filteredDealers.isEmpty)
                    RegularText(text: 'No Dealers found'),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: filteredDealers.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: CircleAvatar(
                                backgroundColor:
                                    AppEssential.generateRandomColor(),
                                child: RegularText(
                                    text: filteredDealers[index]
                                        .dealerName
                                        .split('')
                                        .first)),
                            title: RegularText(
                              textAlign: TextAlign.start,
                              text: filteredDealers[index]
                                  .dealerName
                                  .toUpperCase(),
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: RegularText(
                                textAlign: TextAlign.start,
                                text: filteredDealers[index].address,
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class Dealer {
  final String name;
  final String address;

  Dealer({required this.name, required this.address});
}
