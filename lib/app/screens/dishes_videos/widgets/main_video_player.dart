import 'dart:developer';
import 'package:cookie/domain/services/ivideo_player_service.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class MainVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final bool isCurrent;

  final IVideoPlayerService videoPlayerService;

  const MainVideoPlayer({
    super.key,
    required this.videoUrl,
    required this.isCurrent,
    required this.videoPlayerService,
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
    _controller =
        widget.videoPlayerService.initController(videoPath: widget.videoUrl);
    if (_controller != null) {
      _controller!.initialize().then((_) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          setState(() {
            _isInitialized = true;
            if (widget.isCurrent) {
              _controller!.play();
              _isVideoPlaying = true;
            }
          });
        });
      });
    }

    //_initializeVideoPlayer();
    log("VIDEO PLAYER INITED");
  }

  @override
  void didUpdateWidget(MainVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isCurrent) {
      setState(() {
        _isVideoPlaying = true;
        _controller?.play();
      });
    }
  }

  @override
  void dispose() {
    if (_controller != null) {
      widget.videoPlayerService.clearController(_controller!);
    }
    _controller?.dispose();
    log("VIDEO PLAYER DISPOSED");
    super.dispose();
  }

  // Future<void> _initializeVideoPlayer() async {
  //   try {
  //     _controller = await initializeController(path: widget.videoUrl);
  //     if (_controller != null) {
  //       if (_controller!.value.isInitialized) {
  //         if (widget.isCurrent) {
  //           _controller!.play();
  //         }

  //         setState(() {
  //           _isInitialized = true;
  //           _isVideoPlaying = true;
  //         });
  //         _controller!.addListener(() {
  //           if (!_controller!.value.isPlaying &&
  //               _controller!.value.isInitialized &&
  //               _controller!.value.duration == _controller!.value.position) {
  //             setState(() {
  //               _isVideoPlaying = false;
  //             });
  //           }
  //         });
  //       }
  //     }
  //   } catch (error) {
  //     log("Error initializing video player: $error");
  //   }
  // }

  void _playOrPauseVideo() {
    setState(() {
      _isVideoPlaying ? _controller!.pause() : _controller!.play();
      _isVideoPlaying = !_isVideoPlaying;
    });
  }

  Future<VideoPlayerController?> initializeController(
      {required String path}) async {
    VideoPlayerController controller = VideoPlayerController.network(path);
    await controller.initialize();
    return controller;
  }

  @override
  Widget build(BuildContext context) {
    return _isInitialized &&
            _controller != null &&
            _controller!.value.isInitialized
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
