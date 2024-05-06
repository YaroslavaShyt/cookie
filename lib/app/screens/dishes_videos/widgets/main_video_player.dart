import 'dart:developer';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class MainVideoPlayer extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final Function(VideoPlayerController) clearController;

  const MainVideoPlayer({
    super.key,
    required this.videoPlayerController,
    required this.clearController,
  });

  @override
  State<MainVideoPlayer> createState() => _MainVideoPlayerState();
}

class _MainVideoPlayerState extends State<MainVideoPlayer> {
  bool _isVideoPlaying = false;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    log("videoPlayerController ${widget.videoPlayerController.dataSource}");
    widget.videoPlayerController.initialize().then((value) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {
          //   if (widget.videoPlayerController.value.isInitialized) {
          _isInitialized = true;
          //   }
        });
      });
    });
  }

  @override
  void didChangeDependencies() {
    widget.videoPlayerController.pause();
    log("VIDEO PLAYER DID CHANGE DEPENDENCIES");
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    widget.clearController(widget.videoPlayerController);
    log("VIDEO PLAYER CLEARED CONTROLLER");
    super.dispose();
  }

  void _playOrPauseVideo() {
    setState(() {
      _isVideoPlaying
          ? widget.videoPlayerController.pause()
          : widget.videoPlayerController.play();
      _isVideoPlaying = !_isVideoPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isInitialized
        ? SafeArea(
            top: false,
            left: false,
            right: false,
            child: Stack(
              children: [
                GestureDetector(
                  onTap: _playOrPauseVideo,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      VideoPlayer(widget.videoPlayerController),
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
                        widget.videoPlayerController,
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
            ),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
