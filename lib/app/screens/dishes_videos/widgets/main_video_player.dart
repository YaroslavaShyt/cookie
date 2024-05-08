import 'dart:async';
import 'dart:developer';
import 'package:cookie/app/utils/video_player/ivideo_controllers_handler.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class MainVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final bool isCurrent;

  final IVideoControllersHandler videoControllerHandler;

  const MainVideoPlayer({
    super.key,
    required this.videoUrl,
    required this.isCurrent,
    required this.videoControllerHandler,
  });

  @override
  State<MainVideoPlayer> createState() => _MainVideoPlayerState();
}

class _MainVideoPlayerState extends State<MainVideoPlayer> {
  bool _isVideoPlaying = false;
  bool _isInitialized = false;
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  @override
  void didUpdateWidget(MainVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isCurrent) {
      setState(() {
        _isVideoPlaying = true;
      });
      _controller?.play();
      log("IS PLAYING: $_isVideoPlaying");
    }
  }

  @override
  void dispose() {
    if (_controller != null) {
      _controller!.removeListener(_onVideoStateChanged);
      widget.videoControllerHandler.clearController(_controller!);
    }
    _controller?.dispose();
    log("VIDEO PLAYER DISPOSED");
    super.dispose();
  }

  Future<void> _initializeVideoPlayer() async {
    try {
      _controller = widget.videoControllerHandler
          .initController(videoPath: widget.videoUrl);
      if (_controller != null) {
        _controller!.initialize().then((_) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            if (_controller!.value.isInitialized) {
              setState(() {
                _controller!.addListener(_onVideoStateChanged);
                _isInitialized = true;
                if (widget.isCurrent) {
                  _isVideoPlaying = true;
                  _controller!.play();
                }
              });
            }
          });
        });
      }
    } catch (error) {
      log("Error initializing video player: $error");
    }
  }

  void _onVideoStateChanged() {
    if (!_controller!.value.isPlaying &&
        _controller!.value.isInitialized &&
        _controller!.value.duration == _controller!.value.position) {
      setState(() {
        _isVideoPlaying = false;
      });
    } else {
      setState(() {
        _isVideoPlaying = true;
      });
    }
  }

  void _playOrPauseVideo() {
    setState(() {
      _isVideoPlaying ? _controller!.pause() : _controller!.play();
      _isVideoPlaying = !_isVideoPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isInitialized) {
      return SafeArea(
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
                  Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.orange, width: 5.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: VideoPlayer(_controller!))),
                  if (!_isVideoPlaying)
                    const Center(
                      child: Icon(
                        Icons.play_arrow,
                        size: 50.0,
                        color: Colors.white,
                      ),
                    ),
                  Positioned(
                    bottom: 35.0,
                    left: 20,
                    right: 20,
                    child: SizedBox(
                      width: 280,
                      child: VideoProgressIndicator(
                        _controller!,
                        allowScrubbing: true,
                        colors: const VideoProgressColors(
                          playedColor: Colors.orange,
                          bufferedColor: Colors.grey,
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
