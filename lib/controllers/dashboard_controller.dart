import 'package:get/get.dart';
import 'package:nerofix/constants/api_endpoints.dart';
import 'package:nerofix/core/api.dart';
import 'package:nerofix/core/prefs.dart';
import 'package:nerofix/model/cities.dart';
import 'package:nerofix/model/leaderboard.dart';
import 'package:nerofix/model/points.dart';
import 'package:nerofix/model/states.dart';
import 'package:nerofix/model/total_points.dart';
import 'package:nerofix/model/youtube.dart';

import '../model/transaction_history.dart';

class DashboardController extends GetxController {
  ApiClient apiClient = ApiClient(APIEndpoint.getSubdomain().url);
  String otp = '';
  String mobileNumber = '';
  @override
  onInit() {
    getData();
    super.onInit();
  }

  getData() async {
    await getUserBalance();
    await getYoutubeVideos();
    await getLeaderBoard();
    await gettransactionHistory();
    await getUserTotalPoints();
  }

  List<YoutubeVedios> youtubeVedios = [];
  Points? points;
  List<LeaderBoard> leaderBoard = [];
  RxBool isYoutubeLoading = false.obs;
  RxBool isUserBalance = false.obs;
  RxBool isLeaderBoardLoading = false.obs;
  RxBool isLoadingTotalPoints = false.obs;
  List<Cities> cities = [];
  List<States> states = [];
  List<TotalPoints> totalPoints = [];
  Future<void> getYoutubeVideos() async {
    isYoutubeLoading.value = true;

    try {
      var res =
          await apiClient.postWithFormData(APIEndpoint.getYoutubeVideos, {});

      if (res['status']) {
        List<dynamic> videosData = res['data'];

        youtubeVedios = [];

        for (var videoData in videosData) {
          youtubeVedios?.add(YoutubeVedios.fromJson(videoData));
        }
      }

      isYoutubeLoading.value = false;
      return res['status'];
    } catch (e) {
      isYoutubeLoading.value = false;
    }
  }

  Future<bool> getUserBalance() async {
    isUserBalance.value = true;
    var res = await apiClient.postWithFormData(
        APIEndpoint.getBalance, {"UserName": PrefsDb.getMobile});
    if (res['status']) {
      points = Points.fromJson(res['data']);
    }
    isUserBalance.value = false;
    return res['status'];
  }

  Future<bool> getUserTotalPoints() async {
    isLoadingTotalPoints.value = true;
    var res = await apiClient.postWithFormData(
        APIEndpoint.userTotalPoints, {"UserName": '9980727906'});
    if (res['status']) {
      totalPoints = totalPointsFromJson(res['data']);
    }
    isLoadingTotalPoints.value = false;
    return res['status'];
  }

  Future<void> getLeaderBoard() async {
    isLeaderBoardLoading.value = true;

    try {
      var res =
          await apiClient.postWithFormData(APIEndpoint.getLeaderboard, {});

      if (res['status']) {
        List<dynamic> leaderboardData = res['data'];

        leaderBoard = [];

        for (var data in leaderboardData) {
          leaderBoard.add(LeaderBoard.fromJson(data));
        }
      }

      isLeaderBoardLoading.value = false;
    } catch (e) {
      isLeaderBoardLoading.value = false;
    }
  }

  List<TransactionHistory> transactionHistory = [];
  RxBool transactionHistoryLoading = false.obs;
  Future<void> gettransactionHistory() async {
    transactionHistoryLoading.value = true;

    try {
      var res = await apiClient.postWithFormData(
          APIEndpoint.transactionHistory, {"UserName": PrefsDb.getMobile});

      if (res['status']) {
        List<dynamic> transactionHistoryData = res['data'];

        transactionHistory = [];

        for (var data in transactionHistoryData) {
          transactionHistory.add(TransactionHistory.fromJson(data));
        }
      }

      transactionHistoryLoading.value = false;
    } catch (e) {
      transactionHistoryLoading.value = false;
    }
  }

  Future<void> getCitiesByState(String state) async {
    try {
      var res = await apiClient
          .postWithFormData(APIEndpoint.getCityByStates, {"state": state});

      if (res['status']) {
        cities = citiesFromJson(res['data']);
      }
    } catch (e) {
      Get.snackbar('Something went wrong ', 'Please try after sometime');
    }
  }
  
  Future<void> getStates() async {
    try {
      var res = await apiClient.postWithFormData(APIEndpoint.getStates, {});

      if (res['status']) {
        states = statesFromJson(res['data']);
      }
    } catch (e) {
      Get.snackbar('Something went wrong ', 'Please try after sometime');
    }
  }
}
