import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nerofix/constants/api_endpoints.dart';
import 'package:nerofix/core/api.dart';

class LoginController extends GetxController {
  ApiClient apiClient = ApiClient(APIEndpoint.getSubdomain().url);
  String otp = '';
  String mobileNumber = '';

  Future<bool> getOtp(String number) async {
    var res = await apiClient
        .postWithFormData(APIEndpoint.checkLogin, {"UserName": number});
    if (res['status']) {
      otp = res['data']['LoginDetails'][0]['otp'];
      mobileNumber = res['data']['LoginDetails'][0]['mobile'];
    }
    return res['status'];
  }

  Future<bool> verifyOtp(String number) async {
    var res = await apiClient
        .postWithFormData(APIEndpoint.otpForLogin, {"otp": number});

    return res['status'];
  }
}
