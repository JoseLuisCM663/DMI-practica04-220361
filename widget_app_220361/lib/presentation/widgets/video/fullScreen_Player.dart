import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:widget_app_220361/presentation/widgets/video/video_background.dart';

class FullScreenPlayer extends StatefulWidget {
  final String videoURL;
  final String caption;

  const FullScreenPlayer({
    super.key,
    required this.videoURL,
    required this.caption,
  });

  @override
  State<FullScreenPlayer> createState() => _FullScreenPlayerState();
}

class _FullScreenPlayerState extends State<FullScreenPlayer> {
  late VideoPlayerController controller;
  late Future<void> _initializeVideoPlayerFuture;

  bool _showIcon = false;
  IconData _iconData = Icons.play_arrow;

  @override
  void initState() {
    super.initState();

    controller = VideoPlayerController.asset(widget.videoURL)
      ..setVolume(0)
      ..setLooping(true);

    _initializeVideoPlayerFuture = controller.initialize().then((_) {
      controller.play();
      setState(() {
        _iconData = Icons.pause; // inicia reproduciendo
      });
    });
  }

  void _togglePlayPause() {
    setState(() {
      if (controller.value.isPlaying) {
        controller.pause();
        _iconData = Icons.play_arrow;
      } else {
        controller.play();
        _iconData = Icons.pause;
      }
      _showIcon = true;
    });

    // Oculta el ícono después de 800 ms
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _showIcon = false;
        });
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator(strokeWidth: 2));
        }

        if (!controller.value.isInitialized) {
          return const Center(child: Text('Video no inicializado'));
        }

        return GestureDetector(
          onTap: _togglePlayPause,
          child: AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: Stack(
              alignment: Alignment.center,
              children: [
                VideoPlayer(controller),

                // Gradiente inferior
                VideoBackground(stops: const [0.8, 1.0]),

                // Ícono central (animado)
                if (_showIcon)
                  AnimatedOpacity(
                    opacity: _showIcon ? 1 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      _iconData,
                      color: Colors.white70,
                      size: 80,
                    ),
                  ),

                // Texto inferior
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: _VideoCaption(caption: widget.caption),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _VideoCaption extends StatelessWidget {
  final String caption;

  const _VideoCaption({required this.caption});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return SizedBox(
      width: size.width * 0.6,
      child: Text(
        caption,
        maxLines: 2,
        style: titleStyle?.copyWith(color: Colors.white),
      ),
    );
  }
}
