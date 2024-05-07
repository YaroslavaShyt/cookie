import 'package:video_player/video_player.dart';

abstract interface class IVideoPlayerService {
  List<VideoPlayerController?> get videoPlayerControllers;

  void spawnControllers({required int quantity}); // spawn 5 empty controllers

  VideoPlayerController initController(
      {required String videoPath}); // init empty controller -> non-empty

  VideoPlayerController get controller;

  void clearController(VideoPlayerController controller);
  void disposeControllers();

  Future<int?> loadLastWatchedVideoIndex({required String categoryName});
  Future<void> saveWatchedVideoHistory(
      {required String categoryName, required int index});
}
