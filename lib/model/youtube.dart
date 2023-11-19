// To parse this JSON data, do
//
//     final youtubeVedios = youtubeVediosFromJson(jsonString);

import 'dart:convert';

List<YoutubeVedios> youtubeVediosFromJson(String str) => List<YoutubeVedios>.from(json.decode(str).map((x) => YoutubeVedios.fromJson(x)));

String youtubeVediosToJson(List<YoutubeVedios> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class YoutubeVedios {
    String videoTitle;
    String videoUrl;

    YoutubeVedios({
        required this.videoTitle,
        required this.videoUrl,
    });

    factory YoutubeVedios.fromJson(Map<String, dynamic> json) => YoutubeVedios(
        videoTitle: json["video_title"],
        videoUrl: json["video_url"],
    );

    Map<String, dynamic> toJson() => {
        "video_title": videoTitle,
        "video_url": videoUrl,
    };
}
