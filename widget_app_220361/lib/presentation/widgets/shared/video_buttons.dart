import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:widget_app_220361/config/helpers/human_formants.dart';
import 'package:widget_app_220361/domain/entites/video_post.dart';

class VideoButtons extends StatefulWidget  {
  final VideoPost video;

  const VideoButtons({super.key, required this.video});
   @override
  State<VideoButtons> createState() => _VideoButtonsState();
}

class _VideoButtonsState extends State<VideoButtons> {
  bool isMuted = true; // control del audio

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ❤️ Likes
        _CustomIconButton(
          value: widget.video.likes,
          iconColor: Colors.red,
          iconData: Icons.favorite,
        ),
        const SizedBox(height: 20),

        // 👁️ Vistas
        _CustomIconButton(
          value: widget.video.views,
          iconData: Icons.remove_red_eye_sharp,
        ),

        const SizedBox(height: 20,),
        // 💬 Comentarios
        _CustomIconButton(
          value: widget.video.comments,
          iconData: Icons.comment,
          iconColor: Colors.black87,
        ),

        const SizedBox(height: 20),
        SpinPerfect(
          infinite:true,
          duration: const Duration(seconds: 5),
                    child: const _CustomIconButton(
            value: 0,
            iconData: Icons.play_circle_outline,
          ),
        ),
        const SizedBox(height: 20),

        // 🔊 Botón de audio on/off
        GestureDetector(
          onTap: () {
            setState(() {
              isMuted = !isMuted;
            });
          },
          child: Pulse(
            infinite: false,
            duration: const Duration(milliseconds: 600),
            child: Icon(
              isMuted ? Icons.volume_off : Icons.volume_up,
              color: isMuted ? Colors.grey : Colors.greenAccent,
              size: 35,
            ),
          ),
        ),
      ],
    );
  }
}

class _CustomIconButton extends StatelessWidget {
  final int value;
  final IconData iconData;
  final Color? color;

  const _CustomIconButton({
    required this.value,
    required this.iconData,
    iconColor,
  }) : color = iconColor ?? Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(iconData, color:color, size: 30),
        ),
        if(value > 0)
        Text(HumanFormants.humanReadbleNumber(value.toDouble())),
      ],
    );
  }
}
