import 'package:get/get.dart';
import 'package:nerofix/constants/api_endpoints.dart';
import 'package:nerofix/core/api.dart';
import 'package:nerofix/core/prefs.dart';
import 'package:nerofix/model/leaderboard.dart';
import 'package:nerofix/model/points.dart';
import 'package:nerofix/model/youtube.dart';

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
  }

  List<YoutubeVedios> youtubeVedios=[];
  Points? points;
  List<LeaderBoard> leaderBoard=[];
  RxBool isYoutubeLoading = false.obs;
  RxBool isUserBalance = false.obs;
  RxBool isLeaderBoardLoading = false.obs;
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
}
