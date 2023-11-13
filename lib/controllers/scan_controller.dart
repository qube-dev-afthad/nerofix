import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanController extends GetxController {
  //scan to pay
  static ScanController get access =>
      Get.put(ScanController(), permanent: true);
  RxBool isLoading = true.obs;
  RxString data = "".obs;

  @override
  void onInit() {
    super.onInit();
  }

  // toggleFlash() {
  //   qrViewController!.toggleFlash();
  //   isFlashOn.value = !isFlashOn.value;
  // }

  QRViewController? qrViewController;
  Future<void> extractData() async {
    if (data.value.isNotEmpty) {
      Uri uri = Uri.parse(data.value);

      isLoading.value = false;
    }
  }
}
