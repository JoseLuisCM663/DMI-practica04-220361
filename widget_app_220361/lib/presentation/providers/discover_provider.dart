import 'package:flutter/material.dart';
import 'package:widget_app_220361/domain/entites/video_post.dart';

class DiscoverProvider extends ChangeNotifier {
  bool initialLoding = true;
  List<VideoPost> videos = [];

  Future<void> loadNextPage() async {
    notifyListeners();
  }
}
