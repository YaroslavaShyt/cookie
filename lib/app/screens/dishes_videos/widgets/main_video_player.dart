import 'dart:developer';
import 'package:cookie/app/utils/caching/cache_util.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class MainVideoPlayer extends StatefulWidget {
  final String videoUrl;
  const MainVideoPlayer({
    super.key,
    required this.videoUrl,
  });

  @override
  State<MainVideoPlayer> createState() => _MainVideoPlayerState();
}

class _MainVideoPlayerState extends State<MainVideoPlayer> {
  bool _isVideoPlaying = false;
  bool _isInitialized = false;
  VideoPlayerController? _controller;
  final CacheUtil _cacheUtil = CacheUtil();

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
    log("VIDEO PLAYER INITED");
  }

  @override
  void dispose() {
    if (_controller != null ) {
      _controller!.dispose();
    }
    log("VIDEO PLAYER DISPOSED");
    super.dispose();
  }

  Future<void> _initializeVideoPlayer() async {
    try {
      _controller = await initializeController(path: widget.videoUrl);
      if (_controller != null && _controller!.value.isInitialized) {
        setState(() {
          _isInitialized = true;
        });
        _controller!.addListener(() {
          if (!_controller!.value.isPlaying &&
              _controller!.value.isInitialized &&
              _controller!.value.duration == _controller!.value.position) {
            setState(() {
              _isVideoPlaying = false;
            });
          }
        });
      }
    } catch (error) {
      log("Error initializing video player: $error");
    }
  }

  void _playOrPauseVideo() {
    setState(() {
      _isVideoPlaying ? _controller!.pause() : _controller!.play();
      _isVideoPlaying = !_isVideoPlaying;
    });
  }

  Future<VideoPlayerController?> initializeController(
      {required String path}) async {
    FileInfo? fileInfo = await _cacheUtil.getFileFromCache(key: path);
    if (fileInfo != null) {
      VideoPlayerController controller =
          VideoPlayerController.file(fileInfo.file);
      await controller.initialize();
      return controller;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return _isInitialized && _controller != null && _controller!.value.isInitialized
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
