import 'package:bs_video_player/src/playback_speed_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:video_player/video_player.dart';

class ControlsOverlay extends StatelessWidget {
  const ControlsOverlay({
    Key? key,
    required this.controller,
    required this.hasPlayBackSpeed,
    required this.finishedPlaying,
    this.playbackFontSize = 10.0,
    this.playbackIconSize = 100.0,
    this.iconContainerColor = Colors.black26,
    this.iconColor = Colors.white,
  }) : super(key: key);

  final VideoPlayerController controller;
  final bool hasPlayBackSpeed;
  final bool finishedPlaying;
  final double playbackFontSize;
  final double playbackIconSize;
  final Color iconContainerColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          reverseDuration: const Duration(milliseconds: 200),
          child: finishedPlaying
              ? Container(
                  color: iconContainerColor,
                  child: Center(
                    child: Icon(
                      Icons.replay,
                      color: iconColor,
                      size: playbackIconSize,
                      semanticLabel: 'Re-play',
                    ),
                  ),
                )
              : controller.value.isBuffering
                  ? Container(
                      color: iconContainerColor,
                      child: Center(
                        child: SpinKitCircle(color: iconColor),
                      ),
                    )
                  : controller.value.isPlaying
                      ? const SizedBox.shrink()
                      : Container(
                          color: iconContainerColor,
                          child: Center(
                            child: Icon(
                              Icons.play_arrow,
                              color: iconColor,
                              size: playbackIconSize,
                              semanticLabel: 'Play',
                            ),
                          ),
                        ),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
        ),
        hasPlayBackSpeed ? PlaybackSpeedMenu(controller: controller,playbackFontSize: 20,) : const SizedBox(),
      ],
    );
  }
}
