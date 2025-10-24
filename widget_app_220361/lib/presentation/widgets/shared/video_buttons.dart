import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:widget_app_220361/config/helpers/human_formants.dart';
import 'package:widget_app_220361/domain/entites/video_post.dart';

class VideoButtons extends StatefulWidget {
  final VideoPost video;
  final Function(bool) onPlayPause;
  final Function(bool) onMuteUnmute;
  final bool isPlaying;
  final bool isMuted;

  const VideoButtons({
    super.key,
    required this.video,
    required this.onPlayPause,
    required this.onMuteUnmute,
    required this.isPlaying,
    required this.isMuted,
  });

  @override
  State<VideoButtons> createState() => _VideoButtonsState();
}

class _VideoButtonsState extends State<VideoButtons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _CustomIconButton(
          value: widget.video.likes,
          iconColor: Colors.red,
          iconData: Icons.favorite,
          onPressed: () {},
        ),
        const SizedBox(height: 20),
        _CustomIconButton(
          value: widget.video.views,
          iconData: Icons.remove_red_eye_outlined,
          onPressed: () {},
        ),
        const SizedBox(height: 20),
        _CustomIconButton(
          value: widget.video.comments,
          iconData: Icons.comment,
          onPressed: () {},
        ),
        const SizedBox(height: 20),
        _CustomIconButton(
          value: 0,
          iconData: Icons.share_outlined,
          onPressed: () {},
        ),
        const SizedBox(height: 20),
        // Botón de Mute/Unmute
        _MuteButton(
          isMuted: widget.isMuted,
          onPressed: () {
            widget.onMuteUnmute(!widget.isMuted);
          },
        ),
        const SizedBox(height: 20),
        // Botón de Play/Pause
        _PlayPauseButton(
          isPlaying: widget.isPlaying,
          onPressed: () {
            widget.onPlayPause(!widget.isPlaying);
          },
        ),
      ],
    );
  }
}

class _PlayPauseButton extends StatelessWidget {
  final bool isPlaying;
  final VoidCallback onPressed;
  final double size;

  const _PlayPauseButton({
    super.key,
    required this.isPlaying,
    required this.onPressed,
    this.size = 30,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        isPlaying ? Icons.pause : Icons.play_arrow,
        size: size,
        color: Colors.white,
      ),
    );
  }
}

class _MuteButton extends StatelessWidget {
  final bool isMuted;
  final VoidCallback onPressed;
  final double size;

  const _MuteButton({
    super.key,
    required this.isMuted,
    required this.onPressed,
    this.size = 30,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        isMuted ? Icons.volume_off : Icons.volume_up,
        size: size,
        color: Colors.white,
      ),
    );
  }
}

class _CustomIconButton extends StatelessWidget {
  final int value;
  final IconData iconData;
  final Color? color;
  final double size;
  final VoidCallback onPressed;

  const _CustomIconButton({
    super.key,
    required this.value,
    required this.iconData,
    required this.onPressed,
    iconColor,
    this.size = 30,
  }) : color = iconColor ?? Colors.white;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(iconData, color: color, size: size),
        ),
        if (value > 0)
          Text(
            HumanFormants.humanReadbleNumber(value.toDouble()),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
      ],
    );
  }
}
