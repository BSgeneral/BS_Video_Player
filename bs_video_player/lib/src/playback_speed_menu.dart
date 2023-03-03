import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../data/player_constants.dart';

class PlaybackSpeedMenu extends StatelessWidget {
  final VideoPlayerController controller;
  final double playbackFontSize;
  final double playbackIconSize;
  final Color iconColor;

  const PlaybackSpeedMenu({
    super.key,
    required this.controller,
    this.playbackFontSize = 10.0,
    this.playbackIconSize = 100.0,
    this.iconColor = Colors.black26,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Align(
        alignment: Alignment.topLeft,
        child: PopupMenuButton<double>(
          initialValue: controller.value.playbackSpeed,
          tooltip: 'Playback speed',
          onSelected: (double speed) {
            controller.setPlaybackSpeed(speed);
          },
          itemBuilder: (BuildContext context) {
            return <PopupMenuItem<double>>[
              for (final double speed in PlayerConstants.playbackSpeeds)
                PopupMenuItem<double>(
                  value: speed,
                  child: Text(
                    '${speed}x',
                    style:
                        TextStyle(fontSize: playbackFontSize, color: iconColor),
                  ),
                )
            ];
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              // Using less vertical padding as the text is also longer
              // horizontally, so it feels like it would need more spacing
              // horizontally (matching the aspect ratio of the video).
              vertical: 12,
              horizontal: 16,
            ),
            child: Text('${controller.value.playbackSpeed}x',
                style: TextStyle(fontSize: playbackFontSize, color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
