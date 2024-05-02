import 'package:cookie/app/utils/caching/cache_util.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:video_player/video_player.dart';

class VideoCarouselUtil {
  final CacheUtil _cacheUtil;
  bool _isCurrentVideoPlaying = false;
  bool _isControllersInitialized = false;
  List<VideoPlayerController> videoPlayerControllers = [];

  VideoCarouselUtil({required CacheUtil cacheUtil}) : _cacheUtil = cacheUtil;

  bool get isCurrentVideoPlaying => _isCurrentVideoPlaying;

  bool get isControllersInitialized => _isControllersInitialized;

  Future<void> initializeControllers({required List<String> videoPaths}) async {
    for (String path in videoPaths) {
      FileInfo? fileInfo = await _cacheUtil.getFileFromCache(key: path);
      if (fileInfo != null) {
        VideoPlayerController controller =
            VideoPlayerController.file(fileInfo.file);
        await controller.initialize();
        videoPlayerControllers.add(controller);
      }
    }
    if (videoPlayerControllers.isNotEmpty) {
      _isControllersInitialized = true;
    }
  }

  void disposeControllers() {
    for (VideoPlayerController controller in videoPlayerControllers) {
      controller.dispose();
    }
  }

  void playOrPauseVideo({required int index}) {
    _isCurrentVideoPlaying
        ? videoPlayerControllers[index].pause()
        : videoPlayerControllers[index].play();
    _isCurrentVideoPlaying = !_isCurrentVideoPlaying;
  }
}
