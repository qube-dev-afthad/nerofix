import 'package:get/get.dart';

class ButtonController extends GetxController {
  static ButtonController get access => Get.put(ButtonController());
  RxMap animatedButtons = {}.obs;
  void startAnimation(String? id) => animatedButtons[id] = true;

  void stopAnimation(String? id) => animatedButtons[id] = false;
}
