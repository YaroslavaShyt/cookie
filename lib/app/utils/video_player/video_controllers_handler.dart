import 'dart:developer';
import 'package:cookie/domain/services/ilocal_storage.dart';
import 'package:cookie/app/utils/video_player/ivideo_controllers_handler.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoControllersHandler implements IVideoControllersHandler {
  final ILocalStorage _localStorage;
  List<VideoPlayerController> _videoPlayerControllers = [];

  VideoControllersHandler({required ILocalStorage localStorage})
      : _localStorage = localStorage;

  @override
  void spawnControllers({required int quantity}) {
    _videoPlayerControllers =
        List.generate(quantity, (index) => VideoPlayerController.network(''));
  }

  @override
  VideoPlayerController? initController({required String videoPath}) {
    int index = _videoPlayerControllers
        .indexWhere(((element) => element.dataSource == ""));
    if (index >= 0) {
      _videoPlayerControllers[index] =
          VideoPlayerController.contentUri(Uri.parse(videoPath));
      return _videoPlayerControllers[index];
    }
    return null;
  }

  @override
  VideoPlayerController get controller => _videoPlayerControllers
      .firstWhere((element) => element.dataSource.isNotEmpty);

  @override
  void clearController(VideoPlayerController controller) {
    int index = _videoPlayerControllers
        .indexWhere(((element) => element.dataSource == controller.dataSource));
    if (index >= 0) {
      _videoPlayerControllers[index] = VideoPlayerController.network('');
      log("CONTROLLER CLEARED ${controller.dataSource}");
    }
  }

  @override
  List<VideoPlayerController?> get videoPlayerControllers =>
      _videoPlayerControllers;

  @override
  void disposeControllers() {
    for (VideoPlayerController controller in _videoPlayerControllers) {
      controller.dispose();
    }
  }

  @override
  Future<int?> loadLastWatchedVideoIndex({required String categoryName}) async {
    return await _localStorage.read(key: categoryName);
  }

  @override
  Future<void> saveWatchedVideoHistory(
      {required String categoryName, required int index}) async {
    debugPrint("IN $categoryName LAST WAS $index");
    await _localStorage.save(key: categoryName, data: index);
    log("NEW INDEX SAVED");
  }
}
