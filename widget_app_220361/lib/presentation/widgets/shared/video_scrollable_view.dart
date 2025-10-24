import 'package:flutter/material.dart';
import 'package:widget_app_220361/domain/entites/video_post.dart';
import 'package:widget_app_220361/presentation/widgets/shared/video_buttons.dart';

class VideoScrollableView extends StatelessWidget {
  final List<VideoPost> videos;

  const VideoScrollableView({super.key,required this.videos});

  @override
  Widget build(BuildContext context) {
        return PageView.builder(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      itemCount: videos.length,
      itemBuilder: (context,index){
        final VideoPost videoPost = videos[index];
        return Stack(
          children: [
            // video player + gradient


            // Botones 
            Positioned(
              bottom: 40,
              right: 20,
              child: VideoButtons(video:videoPost)
            )
          ],
        );
      },
    );
  }
}
/**
    return PageView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      children: [
        Container( color: Colors.red),
        Container( color: Colors.black),
        Container( color: Colors.blue),
        Container( color: Colors.white),
        Container( color: Colors.green),
        Container( color: Colors.teal),
        Container( color: Colors.yellow),
        Container( color: Colors.pink),
        Container( color: Colors.purple),

      ],
    );
 */