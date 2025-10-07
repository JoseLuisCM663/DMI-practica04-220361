import 'package:flutter/material.dart';
import 'package:widget_app_220361/domain/entites/video_post.dart';
import 'package:widget_app_220361/infrastructure/models/local_video_model.dart';
import 'package:widget_app_220361/shared/data/local_video_post.dart';

class DiscoverProvider extends ChangeNotifier {
  bool initialLoding = true;
  List<VideoPost> videos = [];

  Future<void> loadNextPage() async {
    await Future.delayed(const Duration(seconds: 2));

    final List<VideoPost> newVideos = videoPost
        .map((video) => LocalVideoModel.fromJson(video).toVideoPostEntity())
        .toList();
    videos.addAll(newVideos);
    initialLoding = false;
    notifyListeners();
  }
}
