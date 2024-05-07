import 'package:video_player/video_player.dart';

abstract interface class IVideoPlayerHandler {
  List<VideoPlayerController?> get videoPlayerControllers;
  VideoPlayerController get controller;

  VideoPlayerController initController(
      {required String videoPath}); 

  void spawnControllers({required int quantity});
  void clearController(VideoPlayerController controller);
  void disposeControllers();

  Future<int?> loadLastWatchedVideoIndex({required String categoryName});
  Future<void> saveWatchedVideoHistory(
      {required String categoryName, required int index});
}
