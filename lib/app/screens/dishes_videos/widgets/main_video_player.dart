import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class MainVideoPlayer extends StatefulWidget {
  final bool isVideoPlaying;
  final VideoPlayerController controller;
  final Function(int) playOrPause;
  final int index;

  const MainVideoPlayer(
      {super.key,
      required this.isVideoPlaying,
      required this.controller,
      required this.playOrPause,
      required this.index});

  @override
  State<MainVideoPlayer> createState() => _MainVideoPlayerState();
}

class _MainVideoPlayerState extends State<MainVideoPlayer> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if (widget.controller.value.isPlaying && !widget.isVideoPlaying) {
        widget.playOrPause(widget.index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        left: false,
        right: false,
        child: Stack(
          children: [
            GestureDetector(
              onTap: () => widget.playOrPause(widget.index),
              child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  VideoPlayer(widget.controller),
                  if (!widget.isVideoPlaying)
                    const Center(
                      child: Icon(
                        Icons.play_arrow,
                        size: 50.0,
                        color: Colors.white,
                      ),
                    ),
                  VideoProgressIndicator(
                    widget.controller,
                    allowScrubbing: true,
                    colors: const VideoProgressColors(
                      playedColor: Colors.orange,
                      bufferedColor: Colors.grey,
                      backgroundColor: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
