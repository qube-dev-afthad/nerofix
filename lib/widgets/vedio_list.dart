import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nerofix/constants/app_assets.dart';
import 'package:nerofix/constants/app_colors.dart';
import 'package:nerofix/model/youtube.dart';
import 'package:nerofix/widgets/common_widgets.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoList extends StatefulWidget {
  final List<YoutubeVedios> vedios;
  final String title;
  const VideoList({super.key, required this.vedios, required this.title});

  @override
  State<VideoList> createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  final PageController _pageController = PageController(viewportFraction: 0.5);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 7),
          child: Align(
              alignment: Alignment.topLeft,
              child: RegularText(
                text: widget.title,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: SizedBox(
            height: 208,
            width: Get.width,
            child: PageView.builder(
              pageSnapping: false,
              padEnds: false,
              controller: _pageController,
              // physics: BouncingScrollPhysics(),
              itemCount: widget.vedios.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding:
                    EdgeInsets.only(right: 10, left: index == 0 ? 0 : 0),
                  child: InkWell(
                      onTap: () {
                        showDialog(
                          useSafeArea: true,
                          barrierColor: Colors.transparent,
                          context: context,
                          builder: (BuildContext context) {
                            final _controller =
                                YoutubePlayerController.fromVideoId(
                              videoId:
                                  getVideoId(widget.vedios[index].videoUrl)!,
                              autoPlay: false,
                              params: YoutubePlayerParams(
                                  loop: true, showFullscreenButton: false),
                            );
                            return BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                              child: Dialog(
                                insetAnimationDuration:
                                    Duration(milliseconds: 600),
                                insetAnimationCurve: Curves.easeInToLinear,
                                insetPadding:
                                    EdgeInsets.symmetric(horizontal: 6),
                                child: YoutubePlayer(
                                  backgroundColor: AppColors.darkGray,
                                  controller: _controller,
                                  aspectRatio: 16 / 9,
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  carpenter,
                                ),
                                fit: BoxFit.fill)),
                        padding: EdgeInsets.zero,
                        height: 100,
                        width: 100,
                      
                        // clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Stack(
                                        
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Image.asset(
                                youtube,
                                height: 40,
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              left: 10,
                              child: RegularText(
                                text: widget.vedios[index].videoTitle,
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                      )),
                );
              },
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < widget.vedios.length; i++)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: CircleAvatar(
                    radius: 3.0,
                    backgroundColor: _currentPage == 0
                        ? (i == _currentPage
                            ? AppColors.primaryGreen
                            : AppColors.borderColor)
                        : (_currentPage == i - 1
                            ? AppColors.primaryGreen
                            : AppColors.borderColor)),
              ),
          ],
        ),
      ],
    );
  }
}

String? getVideoId(String url) {
  Uri uri = Uri.parse(url);
  String? videoId = uri.queryParameters['v'];
  String urlWithVideoId = videoId ?? 'cPXta5ct0ns';
  return urlWithVideoId;
}
