import 'package:video_player/video_player.dart';

abstract interface class IVideoControllersHandler {
  List<VideoPlayerController?> get videoPlayerControllers;

  VideoPlayerController? initController(
      {required String videoPath}); 

  void spawnControllers({required int quantity});
  void clearController(VideoPlayerController controller);
  void disposeControllers();

  Future<int?> loadLastWatchedVideoIndex({required String categoryName});
  Future<void> saveWatchedVideoHistory(
      {required String categoryName, required int index});
}
