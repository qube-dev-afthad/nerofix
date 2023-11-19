import 'package:get/get.dart';
import 'package:nerofix/controllers/button_controller.dart';
import 'package:nerofix/controllers/dashboard_controller.dart';
import 'package:nerofix/core/prefs.dart';

class OnboardingBindings extends Bindings {
  @override
  void dependencies() async {
    Get.put(ButtonController(), permanent: true);
    if (PrefsDb.getMobile != null) {
      Get.put(DashboardController(), permanent: true);
    }
  }
}
