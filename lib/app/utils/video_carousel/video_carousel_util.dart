import 'dart:developer';
import 'package:cookie/app/utils/caching/cache_util.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:video_player/video_player.dart';

class VideoCarouselUtil {
  final CacheUtil _cacheUtil;
  List<VideoPlayerController> videoPlayerControllers = [];

  VideoCarouselUtil({required CacheUtil cacheUtil}) : _cacheUtil = cacheUtil;


  Future<List<VideoPlayerController>> initializeControllers(
      {required List<dynamic> videoPaths}) async {
    videoPlayerControllers.clear();
    for (String path in videoPaths) {
      FileInfo? fileInfo = await _cacheUtil.getFileFromCache(key: path);
      if (fileInfo != null) {
        VideoPlayerController controller =
            VideoPlayerController.file(fileInfo.file);
        await controller.initialize();
        videoPlayerControllers.add(controller);
      }
    }
    return videoPlayerControllers;
  }

  void disposeControllers() {
    for (VideoPlayerController controller in videoPlayerControllers) {
      controller.dispose();
      log("DISPOSED: ${videoPlayerControllers.indexOf(controller)}");
    }
  }


}
