import 'package:widget_app_220361/domain/entites/video_post.dart';

class LocalVideoModel {
  final String name;
  final String videoURL;
  final int likes;
  final int views;

  LocalVideoModel({
    required this.name,
    required this.videoURL,
    this.likes = 0,
    this.views = 0,
  });
  factory LocalVideoModel.fromJson(Map<String, dynamic> json) =>
      LocalVideoModel(
        name: json['name'] ?? 'no name',
        videoURL: json['videoURL'] ?? 'not fount url',
        likes: json['likes'] ?? 0,
        views: json['views'] ?? 0,
      );

  VideoPost toVideoPostEntity() => VideoPost(caption: name, videoURL: videoURL, likes: likes, views: views);
  
}
