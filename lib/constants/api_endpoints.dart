class ApiDomainDTO {
  String url;
  //just temporary

  ApiDomainDTO({
    required this.url,
  });
  factory ApiDomainDTO.fromJson(Map<String, dynamic> json) =>
      ApiDomainDTO(url: json['url']);
}

///DONT CHANGE ANYTHING HERE...
class APIEndpoint {
  static const String buildMode =
      String.fromEnvironment('BUILD_MODE', defaultValue: 'UAT');
  //tempurl
  static String? apiUrl;

  static ApiDomainDTO getSubdomain() {
    switch (buildMode) {
      case 'RELEASE':
        return ApiDomainDTO(
          url: 'https://app.qubehealth.com/api/',
        );
      //Staging
      case 'UAT':
        return ApiDomainDTO(
          url:
              'https://digitalrepublik.in/Nerofix-ECRM/NewEnrollmentService.asmx',
        );

      default:
        return ApiDomainDTO(
          url:
              'https://digitalrepublik.in/Nerofix-ECRM/NewEnrollmentService.asmx',
        );
    }
  }

  //LOGIN
  static const String checkLogin = 'CheckLogin';
  static const String otpForLogin = 'OtpForLogin';
  static const String getBalance = 'GetBalance';
  static const String getLeaderboard = 'GetTopTenEarningPoint';
  static const String dealerSearch = 'DealerSearch';
  static const String getYoutubeVideos = 'GetYoutubevideos';
  static const String registrationRequest = 'RegistrationRequest';
  static const String getStates = 'GetStates';
  static const String getCityByStates = 'GetCityBystates';
  static const String checkCoupons = 'CheckCoupons';
  static const String redemptionRequest = 'RedemptionRequest';
  static const String transactionHistory= 'Transaction_history';
    static const String userTotalPoints= 'UserTotalPoints';
    
  
  
}
