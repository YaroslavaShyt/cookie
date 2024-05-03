import 'dart:developer';
import 'package:cookie/app/utils/video_carousel/video_carousel_util.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class MainVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final VideoCarouselUtil videoCarouselUtil;
  const MainVideoPlayer({
    super.key,
    required this.videoUrl,
    required this.videoCarouselUtil,
  });

  @override
  State<MainVideoPlayer> createState() => _MainVideoPlayerState();
}

class _MainVideoPlayerState extends State<MainVideoPlayer> {
  bool _isVideoPlaying = false;
  bool _isInitialized = false;
  late VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    log("VIDEO PLAYER INITED");
    _initializeVideoPlayer();
  }

  Future<void> _initializeVideoPlayer() async {
    try {
      _controller = await widget.videoCarouselUtil
          .initializeController(path: widget.videoUrl);
      if (_controller != null && _controller!.value.isInitialized) {
        setState(() {
          _isInitialized = true;
        });
      }
    } catch (error) {
      log("Error initializing video player: $error");
    }
  }

  @override
  void dispose() {
    if (_controller != null && mounted) {
     // _controller!.dispose();
    }

    log("VIDEO PLAYER DISPOSED");
    super.dispose();
  }

  void _playOrPauseVideo() {
    setState(() {
      _isVideoPlaying ? _controller!.pause() : _controller!.play();
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
                      VideoPlayer(_controller!),
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
                        _controller!,
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
