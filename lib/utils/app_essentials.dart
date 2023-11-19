import 'dart:async';
import 'dart:developer' as dev;
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nerofix/constants/api_endpoints.dart';
import 'package:nerofix/core/prefs.dart';
import 'package:nerofix/widgets/common_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/app_colors.dart';

class AnsiColors {
  static String get lightBlue => '\x1b[94m';
  static String get lightRed => '\x1b[91m';
  static String get lightGreen => '\x1b[92m';
}

String formatDate(String date) {
  final df = new DateFormat('dd-MM-yyyy');
  DateTime dateString = DateTime.parse(date);
  return df.format(dateString);
}

class AppEssential {
  static final Set _registeredLoaders = {};
  static final Set _registeredScreens = {};
  static String formatDateForMonth(String date) {
    final df = new DateFormat('dd MMMM yyyy');
    DateTime dateString = DateTime.parse(date);
    return df.format(dateString);
  }

  static String formatDate(String date) {
    final df = new DateFormat('MM/dd/yyyy');
    DateTime dateString = DateTime.parse(date);
    return df.format(dateString);
  }

  static void showOverlay(Widget widget) {
    if (!Get.isOverlaysOpen) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.dialog(
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SizedBox(
                child: Column(
                  children: [
                    SizedBox(height: Get.height * .3),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                        child: widget,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
        // executes after build
      });
    }
  }

  static void showLoading(
      {String name = 'default',
      String message = 'Please Wait',
      Color backgroundColor = Colors.white}) {
    if (!Get.isOverlaysOpen) {
      _registeredLoaders.clear();
      _registeredLoaders.add(name);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.dialog(
            WillPopScope(
              onWillPop: () {
                return Future.value(false);
              },
              child: Scaffold(
                backgroundColor: backgroundColor,
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        color: AppColors.darkGray,
                      ),
                    ),
                    SizedBox(height: 20),
                    RegularText(text: 'text')
                  ],
                ),
              ),
            ),
            barrierDismissible: false,
            useSafeArea: false);
        // executes after build
      });
    }
  }

  static void showPopup() {
    Get.dialog(
      // barrierColor: AppColors.transparent,
      barrierDismissible: false,
      WillPopScope(
        onWillPop: () async {
          // PrefsDb.getToken != null ? Get.offAllNamed(Routes.home) : Get.back();
          return false;
        },
        child: AlertDialog(
          // backgroundColor: AppColors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [],
          ),
        ),
      ),
    );
  }

  static String getTimeString(int value) {
    final int hour = value ~/ 60;
    final int minutes = value % 60;
    return '${hour.toString().padLeft(2, "0")}:${minutes.toString().padLeft(2, "0")}';
  }

  static String getTimeStringWithTag(int value) {
    final int hour = value ~/ 60;
    final int minutes = value % 60;
    return '${hour.toString().padLeft(2, "0")} Hours : ${minutes.toString().padLeft(2, "0")} Minutes';
  }

  static void showNoInternetOverlay() {
    if (!Get.isOverlaysOpen) {
      Get.dialog(Container(), barrierDismissible: false, useSafeArea: false);
    }
  }

  static void hideLoading([String name = 'default']) {
    _registeredLoaders.remove(name);
    if (_registeredLoaders.length > 1) {
      return;
    }

    if (Get.isOverlaysOpen) {
      Get.back();
    }
  }

  static String? parseCurrency(dynamic d, {bool withoutLeading = false}) {
    if (d == null ||
        d.toString().isEmpty ||
        !RegExp(r'^-?[0-9]+(\.[0-9]+)?$').hasMatch(d.toString()))
      return d.toString();
    String prefix = withoutLeading ? '' : '₹';
    String suffix = '';
    if (d.toString().contains('.')) {
      suffix = '.' + d.toString().split('.').last;
      d = d.toString().split('.').first;
      if (int.parse(d.toString()) == 0 && !d.toString().contains('-')) {
        return '${prefix}0$suffix';
      }
    }
    return prefix +
        NumberFormat('##,##,##,##,###').format(int.tryParse(d.toString())) +
        suffix;
  }

  static String formatIndianCurrency(dynamic number) {
    if (number == null || number.toString().isEmpty) return '0';
    double? num = double.tryParse(number.toString());
    if (num == null) return '0';
    bool isNegative = num < 0;

    num = num.abs();
    if (num < 100000) {
      return isNegative
          ? '-' + parseCurrency(num, withoutLeading: true)!.split('.0').first
          : '' + parseCurrency(num, withoutLeading: true)!.split('.0').first;
    }

    if (num < 10000000) {
      num = num / 100000;
      if (num == 1) {
        return num.toStringAsFixed(0) + ' lac';
      }
      if (num.toStringAsFixed(2).contains('.00')) {
        return num.toStringAsFixed(0) + ' lacs';
      }
      return isNegative
          ? '-' + num.toStringAsFixed(2) + ' lacs'
          : '' + num.toStringAsFixed(2) + ' lacs';
    }
    // if (num < 100000000000) {
    num = num / 10000000;
    return isNegative
        ? '-' + num.toStringAsFixed(2) + ' cr'
        : '' + num.toStringAsFixed(2) + ' cr';
  }

  static bool isEmailValid(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  static bool isIfscValid(String ifsc) {
    return RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$').hasMatch(ifsc);
  }

  static bool gstNumberCheck(String a) {
    return RegExp(r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$')
        .hasMatch(a);
  }

  static bool isbankAccountNumber(String a) {
    return RegExp(r'^[0-9]{9,18}$').hasMatch(a) && int.parse(a) > 0;
  }

  static bool isMobileValid(String number) {
    String pattern = r'^[6789]\d{9}$';
    return RegExp(pattern).hasMatch(number);
  }

  static bool isMobileValidLogin(String number) {
    String pattern = r'^\91[6789]\d{9}$';
    return RegExp(pattern).hasMatch(number);
  }

  // static Future<String> getAppInfo() async {
  //   //  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //   //String deviceVersionName = packageInfo.version;
  //   //return deviceVersionName;
  // }
  // static bool isNameValid(String name) {
  //   return RegExp(r"^[A-Za-z\s]{1,}[\.]{0,1}[A-Za-z\s]{0,}$").hasMatch(name);
  // }

  static bool isNameValid(String name) {
    return RegExp(r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$",
            caseSensitive: false, unicode: true, dotAll: true)
        .hasMatch(name.trim());
  }

  // bool isValidAddress(String address) {
  //   String pattern = r'^\d+\s[A-z]+\s[A-z]+';
  //   RegExp regex = new RegExp(pattern);
  //   return regex.hasMatch(address);
  // }

  static bool isAddressValid(String address) {
    return RegExp(r'^(?!\s*$)[a-zA-Z0-9\-"/@&#().,\\ :]*$')
        .hasMatch(address.trim());
  }

  static bool isPinValid(String pin) {
    return RegExp(r'^\d{6}$').hasMatch(pin);
  }

  static void showNoInternetConnection(
      {String name = 'default', Color backgroundColor = Colors.white}) {
    if (!Get.isOverlaysOpen) {
      _registeredScreens.clear();
      _registeredScreens.add(name);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        //  Get.dialog(NoInternetScreen());
        // executes after build
      });
    }
  }

  static String capitalize(String text) {
    List<String> words = text.split(' ');
    List<String> capitalizedWords = [];

    for (String word in words) {
      if (word.isNotEmpty) {
        String capitalizedWord =
            word[0].toUpperCase() + word.substring(1).toLowerCase();
        capitalizedWords.add(capitalizedWord);
      }
    }

    return capitalizedWords.join(' ');
  }

  static void hideNoInternetConnection([String name = 'default']) {
    _registeredScreens.remove(name);
    if (_registeredScreens.length > 1) {
      return;
    }
    if (Get.isOverlaysOpen) {
      Get.back();
    }
  }

  static Color generateRandomLightColor() {
    Random random = Random();
    int red =
        random.nextInt(128) + 128; // Red component in the range [128, 255]
    int green =
        random.nextInt(128) + 128; // Green component in the range [128, 255]
    int blue =
        random.nextInt(128) + 128; // Blue component in the range [128, 255]

    return Color.fromARGB(255, red, green, blue);
  }

  static Color generateRandomColor() {
    final Random random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1.0,
    );
  }

  static Color generateRandomBlueColor() {
    Random random = Random();
    return Color.fromRGBO(
      0, // Red component (set to 0 for shades of blue)
      0, // Green component (set to 0 for shades of blue)
      random.nextInt(256), // Random Blue component
      1.0,
    );
  }

  static getFirstLetters(String input) {
    List<String> words = input.split(' '); // Split the input string by spaces

    if (words.length == 1) {
      return words[0]
          .substring(0, 1); // Return the first letter of the single word
    } else if (words.length == 2) {
      // Return the first letters of both words for two words
      return words[0].substring(0, 1) + words[1].substring(0, 1);
    } else {
      // Return the first letters of the first two words for more than two words
      return words[0].substring(0, 1) + words[1].substring(0, 1);
    }
  }

  static String splitFirstTwoWords(String input) {
    List<String> words = input.split(' ');

    if (words.length == 1) {
      return words[0]; // Return the single word if only one word is present
    } else if (words.length >= 2) {
      // Take the first two words and split them by adding a newline character
      return '${words[0]}\n${words[1]}';
    } else {
      return ''; // Return an empty string for an empty input or no words
    }
  }

  static void errorLog(dynamic msg, [String name = '']) =>
      log(msg, name, AnsiColors.lightRed);
  static void successLog(dynamic msg, [String name = '']) =>
      log(msg, name, AnsiColors.lightGreen);

  static void log(
    dynamic msg, [
    String name = '',
    String ansiColor = '',
  ]) {
    var x = msg;
    if (kDebugMode) {
      dev.log('\x1b[0m\x1b\x1b[92m$ansiColor[+] $name: ${x.toString()}\x1b[0m',
          name: APIEndpoint.buildMode + ' MODE-QUBE-APP', time: DateTime.now());
    }
  }

  // static Future<bool> isOnline() async {
  //   ConnectivityResult connectivityResult =
  //       await Connectivity().checkConnectivity();
  //   return connectivityResult != ConnectivityResult.none;
  // }

  static Future<void> makePhoneCall(String url) async {
    try {
      await canLaunch(url)
          ? await launch(url)
          : throw Exception('Could not launch $url');
    } on Exception {}
  }

  static void logOut() {
    PrefsDb.prefsBox.clear();
    Get.until((route) => route.isFirst);
  }

  static Future<void> launchStoreUrl() async {
    // PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // if (Platform.isAndroid || Platform.isIOS) {
    //   final appId = Platform.isAndroid ? packageInfo.packageName : '1659360783';
    //   final url = Uri.parse(
    //     Platform.isAndroid
    //         ? "market://details?id=$appId"
    //         : "https://apps.apple.com/app/id$appId",
    //   );
    //   launchUrl(
    //     url,
    //     mode: LaunchMode.externalApplication,
    //   );
    // }
  }

  static String getFormattedTimeString(int value) {
    final int hour = value ~/ 60;
    final int minutes = value % 60;
    return '${hour.toString().padLeft(2, "0")}:${minutes.toString().padLeft(2, "0")}';
  }

  static bool isValidAadharNumber(List array) {
    // Use this for Validating adhaar at frontend
    var d = [
      [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
      [1, 2, 3, 4, 0, 6, 7, 8, 9, 5],
      [2, 3, 4, 0, 1, 7, 8, 9, 5, 6],
      [3, 4, 0, 1, 2, 8, 9, 5, 6, 7],
      [4, 0, 1, 2, 3, 9, 5, 6, 7, 8],
      [5, 9, 8, 7, 6, 0, 4, 3, 2, 1],
      [6, 5, 9, 8, 7, 1, 0, 4, 3, 2],
      [7, 6, 5, 9, 8, 2, 1, 0, 4, 3],
      [8, 7, 6, 5, 9, 3, 2, 1, 0, 4],
      [9, 8, 7, 6, 5, 4, 3, 2, 1, 0]
    ];

    // permutation table p
    var p = [
      [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
      [1, 5, 7, 6, 2, 8, 3, 0, 9, 4],
      [5, 8, 0, 3, 7, 9, 6, 1, 4, 2],
      [8, 9, 1, 6, 0, 4, 3, 5, 2, 7],
      [9, 4, 5, 3, 1, 2, 6, 8, 7, 0],
      [4, 2, 8, 6, 5, 7, 3, 9, 0, 1],
      [2, 7, 9, 3, 8, 0, 6, 4, 1, 5],
      [7, 0, 4, 6, 9, 1, 3, 2, 5, 8]
    ];

    var c = 0;
    List<int> numList = [];
    for (var i in array) {
      int? value = int.tryParse(i);
      numList.add(value!);
    }
    List invertedArray = numList.reversed.toList();
    if (invertedArray.isNotEmpty) {
      for (var i = 0; i < invertedArray.length; i++) {
        c = d[c][p[(i % 8)][invertedArray[i]]];
      }
      return (c == 0);
    }
    return false;
  }

  static String getSimpleDateFormat(DateTime inputDate) {
    DateFormat outputdateFormat = DateFormat("ddMMMyyyy");
    String dob = outputdateFormat.format(inputDate);
    return dob;
  }

  static String getFormattedAmount(String amount) {
    return "\u20B9" +
        amount.replaceAllMapped(
            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
  }

  String creditScoreSnippet(int creditScore) {
    if (creditScore >= 800) {
      return "Great Score!";
    } else if (creditScore >= 740 && creditScore <= 799) {
      return "Very Good Score!";
    } else if (creditScore >= 670 && creditScore <= 739) {
      return "Good Score";
    } else if (creditScore >= 580 && creditScore <= 669) {
      return "Fair Score";
    } else if (creditScore <= 579) {
      return "Poor Score";
    } else {
      return "Unknown Score";
    }
  }

  double convertValue(int value) {
    double x = value.toDouble();
    double x1 = 300.0;
    double x2 = 900.0;
    double y1 = 0.0;
    double y2 = 150.0;
    double y = ((x - x1) / (x2 - x1)) * (y2 - y1) + y1;
    return y;
  }
}
