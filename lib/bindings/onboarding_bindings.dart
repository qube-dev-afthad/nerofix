import 'package:get/get.dart';
import 'package:nerofix/controllers/button_controller.dart';


class OnboardingBindings extends Bindings {
  @override
  void dependencies() async{
    Get.put(ButtonController(), permanent: true);
  
  }
}
