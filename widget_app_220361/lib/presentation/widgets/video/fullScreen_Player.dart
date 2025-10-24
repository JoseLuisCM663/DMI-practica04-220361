import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:widget_app_220361/presentation/widgets/video/video_background.dart';

class FullScreenPlayer extends StatefulWidget {
  final String videoUrl;
  final String caption;
  final bool isPlaying;
  final bool isMuted;
  final Function(bool)? onPlayPause;
  final Function(bool)? onMuteUnmute;

  const FullScreenPlayer({
    super.key,
    required this.videoUrl,
    required this.caption,
    this.isPlaying = true,
    this.isMuted = false, // Cambiado a false por defecto (con sonido)
    this.onPlayPause,
    this.onMuteUnmute,
  });

  @override
  State<FullScreenPlayer> createState() => _FullScreenPlayerState();
}

class _FullScreenPlayerState extends State<FullScreenPlayer> {
  late VideoPlayerController controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  void _initializeVideo() async {
    controller = VideoPlayerController.asset(widget.videoUrl)
      ..setVolume(widget.isMuted ? 0 : 100)
      ..setLooping(true);

    try {
      await controller.initialize();
      if (widget.isPlaying) {
        controller.play();
      }
      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    } catch (e) {
      print('Error initializing video: $e');
    }
  }

  @override
  void didUpdateWidget(FullScreenPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Solo actualizar si el video está inicializado
    if (_isInitialized) {
      // Actualizar reproducción cuando cambia el estado
      if (widget.isPlaying != oldWidget.isPlaying) {
        if (widget.isPlaying) {
          controller.play();
        } else {
          controller.pause();
        }
      }

      // Actualizar volumen cuando cambia el estado de mute
      if (widget.isMuted != oldWidget.isMuted) {
        controller.setVolume(widget.isMuted ? 0 : 100);
      }
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    final newPlayingState = !widget.isPlaying;
    widget.onPlayPause?.call(newPlayingState);
  }

  void _toggleMute() {
    final newMutedState = !widget.isMuted;
    widget.onMuteUnmute?.call(newMutedState);
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Center(
        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
      );
    }

    return GestureDetector(
      onTap: _togglePlayPause,
      child: AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: Stack(
          children: [
            VideoPlayer(controller),

            // Gradiente
            VideoBackground(stops: const [0.8, 1.0]),

            // Texto
            Positioned(
              bottom: 50,
              left: 20,
              child: _VideoCaption(caption: widget.caption),
            ),

            // Indicador de play/pause en el centro
            if (!widget.isPlaying)
              Center(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(
                    Icons.play_arrow,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _VideoCaption extends StatelessWidget {
  final String caption;

  const _VideoCaption({super.key, required this.caption});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return SizedBox(
      width: size.width * 0.6,
      child: Text(
        caption,
        maxLines: 2,
        style: titleStyle?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
