import 'dart:developer';

import 'package:cookie/domain/services/ilocal_storage.dart';
import 'package:cookie/domain/services/ivideo_player_service.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerService implements IVideoPlayerService {
  final ILocalStorage _localStorage;
  List<VideoPlayerController> _videoPlayerControllers = [];

  VideoPlayerService({required ILocalStorage localStorage})
      : _localStorage = localStorage;

  @override
  void spawnControllers({required int quantity}) {
    _videoPlayerControllers =
        List.generate(quantity, (index) => VideoPlayerController.network(''));
  }

  @override
  VideoPlayerController initController({required String videoPath}) {
    VideoPlayerController controller = _videoPlayerControllers
        .firstWhere((element) => element.dataSource == "");
    controller = VideoPlayerController.contentUri(Uri.parse(videoPath));
    return controller;
  }

  @override
  VideoPlayerController get controller => _videoPlayerControllers
      .firstWhere((element) => element.dataSource.isNotEmpty);

  @override
  void clearController(VideoPlayerController controller) {
    controller = VideoPlayerController.network('');
    log("CONTROLLER CLEARED");
    print("----------------------------");
    for (var i in _videoPlayerControllers) {
      log("${i.dataSource}");
    }
    print("----------------------------");
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
