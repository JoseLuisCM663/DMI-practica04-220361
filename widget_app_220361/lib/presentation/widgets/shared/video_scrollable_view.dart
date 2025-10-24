// lib/presentation/widgets/shared/video_scrollable_view.dart
import 'package:flutter/material.dart';
import 'package:widget_app_220361/domain/entites/video_post.dart';
import 'package:widget_app_220361/presentation/widgets/shared/video_buttons.dart';
import 'package:widget_app_220361/presentation/widgets/video/fullscreen_player.dart';

class VideoScrollableView extends StatefulWidget {
  final List<VideoPost> videos;

  const VideoScrollableView({super.key, required this.videos});

  @override
  State<VideoScrollableView> createState() => _VideoScrollableViewState();
}

class _VideoScrollableViewState extends State<VideoScrollableView> {
  late PageController _pageController;
  final Map<int, bool> _videoPlayStates = {};
  final Map<int, bool> _videoMuteStates = {};

  // Estado global para mute (compartido entre todos los videos)
  bool _globalMuted = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    // Inicializar estados para cada video
    for (int i = 0; i < widget.videos.length; i++) {
      _videoPlayStates[i] = true; // Todos comienzan reproduciéndose
      _videoMuteStates[i] = _globalMuted; // Todos usan el estado global
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPlayPauseChanged(int videoIndex, bool isPlaying) {
    setState(() {
      _videoPlayStates[videoIndex] = isPlaying;
    });
  }

  void _onMuteChanged(int videoIndex, bool isMuted) {
    setState(() {
      _globalMuted = isMuted; // Actualizar estado global
      // Actualizar TODOS los videos con el nuevo estado de mute
      for (int i = 0; i < widget.videos.length; i++) {
        _videoMuteStates[i] = _globalMuted;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      itemCount: widget.videos.length,
      itemBuilder: (context, index) {
        final VideoPost videoPost = widget.videos[index];
        final bool isPlaying = _videoPlayStates[index] ?? true;
        final bool isMuted = _videoMuteStates[index] ?? _globalMuted;

        return Stack(
          children: [
            // Video Player + gradiente
            SizedBox.expand(
              child: FullScreenPlayer(
                caption: videoPost.caption,
                videoUrl: videoPost.videoURL,
                isPlaying: isPlaying,
                isMuted: isMuted,
                onPlayPause: (playing) => _onPlayPauseChanged(index, playing),
                onMuteUnmute: (muted) => _onMuteChanged(index, muted),
              ),
            ),

            // Botones
            Positioned(
              bottom: 40,
              right: 20,
              child: VideoButtons(
                video: videoPost,
                onPlayPause: (playing) => _onPlayPauseChanged(index, playing),
                onMuteUnmute: (muted) => _onMuteChanged(index, muted),
                isPlaying: isPlaying,
                isMuted: isMuted,
              ),
            ),
          ],
        );
      },
    );
  }
}
