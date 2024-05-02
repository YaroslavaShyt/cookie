import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class MainVideoPlayer extends StatefulWidget {
  final VideoPlayerController controller;

  const MainVideoPlayer({
    super.key,
    required this.controller,
  });

  @override
  State<MainVideoPlayer> createState() => _MainVideoPlayerState();
}

class _MainVideoPlayerState extends State<MainVideoPlayer> {
  bool _isVideoPlaying = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if (!widget.controller.value.isPlaying &&
          widget.controller.value.isInitialized &&
          widget.controller.value.duration ==
              widget.controller.value.position) {
        setState(() {
          _isVideoPlaying = false;
        });
      }
    });
  }

  void playOrPauseVideo() {
    _isVideoPlaying ? widget.controller.pause() : widget.controller.play();
    setState(() {
      _isVideoPlaying = !_isVideoPlaying;
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
              onTap: playOrPauseVideo,
              child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  VideoPlayer(widget.controller),
                  if (!_isVideoPlaying) ...[
                    const Center(
                      child: Icon(
                        Icons.play_arrow,
                        size: 50.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
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
