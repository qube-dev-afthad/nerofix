import 'package:get/get.dart';
import 'package:nerofix/bindings/dasboard_bindings.dart';
import 'package:nerofix/controllers/button_controller.dart';
import 'package:nerofix/controllers/login_controller.dart';
import 'package:nerofix/core/prefs.dart';
import 'package:nerofix/screens/dashboard.dart';
import 'package:nerofix/screens/leader_board.dart';
import 'package:nerofix/screens/login.dart';
import 'package:nerofix/screens/points_history.dart';
import 'package:nerofix/screens/redeem_points.dart';
import 'package:nerofix/screens/scan_screen.dart';
import 'package:nerofix/screens/search_dealer.dart';
import 'package:nerofix/screens/verify_otp.dart';

class Routes {
  static String login = '/login';
  static String verifyOtp = '/verifyOtp';
  static String bioMetric = '/bioMetric';
  static String home = '/home';
  static String pointsHistory = '/pointsHistory';
  static String redeemPoints = '/redeemPoints';
  static String leaderBoard = '/leaderBoard';
  static String searchDealer = '/searchDealer';
  static String delearsList = '/delearsList';
  static String scanCoupon = '/scanCoupon';
}

String intialRoutes = PrefsDb.getMobile == null ? Routes.login : Routes.home;
//String intialRoute = PrefsDb.getToken != null ? Routes.testPage : Routes.login;
final getPages = [
  GetPage(name: Routes.login, page: () => const LoginScreen(), bindings: [
    BindingsBuilder.put(() => LoginController()),
    BindingsBuilder.put(() => ButtonController())
  ]),
  GetPage(name: Routes.verifyOtp, page: () => const VerifyOtp()),
  GetPage(
      name: Routes.home,
      page: () => const Dashboard(),
      bindings: [DashboardBindings()]),
  GetPage(
      name: Routes.pointsHistory,
      page: () => const PointsHistory(),
      bindings: []),
  GetPage(
      name: Routes.redeemPoints,
      page: () => const RedeemPoints(),
      bindings: []),
  GetPage(
      name: Routes.leaderBoard, page: () => const LeaderBoard(), bindings: []),
  GetPage(
      name: Routes.searchDealer,
      page: () => const SearchDealer(),
      bindings: []),
 
  GetPage(
      name: Routes.scanCoupon, page: () => const ScanCoupon(), bindings: []),
];
