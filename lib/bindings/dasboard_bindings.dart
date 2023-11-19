import 'package:get/get.dart';
import 'package:nerofix/controllers/button_controller.dart';
import 'package:nerofix/controllers/delears_list_controller.dart';

class DashboardBindings extends Bindings {
  @override
  void dependencies() async {
    Get.put(DelearsListController(), permanent: true);
    Get.put(ButtonController());
  }
}
