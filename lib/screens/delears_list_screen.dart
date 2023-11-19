import 'package:flutter/material.dart';
import 'package:nerofix/constants/decorations.dart';
import 'package:nerofix/utils/app_essentials.dart';
import 'package:nerofix/widgets/common_widgets.dart';

class DealersListScreen extends StatefulWidget {
  const DealersListScreen({super.key});

  @override
  DealersListScreenState createState() => DealersListScreenState();
}

class DealersListScreenState extends State<DealersListScreen> {
  List<Dealer> allDealers = [
    Dealer(
        name: 'Kansai Nerolac Paints Ltd.',
        address:
            'Address: 5W2P+7WQ, Lal Bahadur Shastri Marg,Battipada, Bhandup West, Mumbai, Maharashtra400078'),
    Dealer(
        name: 'Kansai Nerolac Paints Ltd.',
        address:
            'Address: 5W2P+7WQ, Lal Bahadur Shastri Marg,Battipada, Bhandup West, Mumbai, Maharashtra400078'),
    Dealer(
        name: 'Kansai Nerolac Paints Ltd.',
        address:
            'Address: 5W2P+7WQ, Lal Bahadur Shastri Marg,Battipada, Bhandup West, Mumbai, Maharashtra400078'),
    // Add more dealers as needed
  ];

  List<Dealer> filteredDealers = [];

  @override
  void initState() {
    super.initState();
    filteredDealers.addAll(allDealers);
  }

  void filterDealers(String query) {
    setState(() {
      filteredDealers = allDealers
          .where((dealer) =>
              dealer.name.toLowerCase().contains(query.toLowerCase()) ||
              dealer.address.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            const RegularText(
              text: 'View Dealer',
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
            const SizedBox(height: 10),
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
            Expanded(
              child: ListView.builder(
                itemCount: filteredDealers.length,
                itemBuilder: (context, index) {
                  return ListTile(

                    leading: CircleAvatar(
                        backgroundColor: AppEssential.generateRandomColor(),
                        child: RegularText(
                            text: filteredDealers[index].name.split('').first)),
                    title: RegularText(
                      textAlign: TextAlign.start,
                      text: filteredDealers[index].name.toUpperCase(),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),

                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: RegularText(
                            textAlign: TextAlign.start,
                        text: filteredDealers[index].address.toUpperCase(),
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
    );
  }
}

class Dealer {
  final String name;
  final String address;

  Dealer({required this.name, required this.address});
}
