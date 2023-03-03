library bs_video_player;

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:video_player/video_player.dart';

import 'src/controls_overlay.dart';

class BSVideoPlayer extends StatefulWidget {
  final String videoURl;
  final bool hasPlayBackSpeed;
  final Function? onFinishedVideo;

  const BSVideoPlayer(
      {super.key,
      required this.videoURl,
      required this.hasPlayBackSpeed,
      required this.onFinishedVideo});

  @override
  State<BSVideoPlayer> createState() => _BSVideoPlayerState();
}

class _BSVideoPlayerState extends State<BSVideoPlayer> {
  late VideoPlayerController _controller;
  bool hasFinishedPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      widget.videoURl,
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );

    _controller.addListener(() {
      setState(() {});
      if (_controller.value.duration <= _controller.value.position) {
        setState(() {
          hasFinishedPlaying = true;
          if (widget.onFinishedVideo != null) {
            widget.onFinishedVideo!();
          }
        });
      } else if (_controller.value.isPlaying) {
        hasFinishedPlaying = false;
      }
    });

    _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      color:const Color(0xFF22222B),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: _controller.value.isInitialized
                      ? Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      VideoPlayer(_controller),
                      ControlsOverlay(
                          controller: _controller,
                          hasPlayBackSpeed: widget.hasPlayBackSpeed,
                          finishedPlaying: hasFinishedPlaying),
                      VideoProgressIndicator(
                        _controller,
                        allowScrubbing: true,
                        colors: const VideoProgressColors(
                            bufferedColor: Color(0xFFF5F5F5),
                            playedColor: Color(0xFF253861)),
                      ),
                    ],
                  )
                      : const Center(child: SpinKitCircle(color: Color(0xFF253861))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
