import 'package:cookie/app/common/base_change_notifier/base_change_notifier.dart';
import 'package:cookie/app/utils/video_carousel/video_carousel_util.dart';
import 'package:cookie/domain/dish/idishes_data.dart';
import 'package:video_player/video_player.dart';

class DishesVideoViewModel extends BaseChangeNotifier {
  final IDishData dishData;
  final VideoCarouselUtil _videoCarouselUtil;
  DishesVideoViewModel(
      {required this.dishData, required VideoCarouselUtil videoCarouselUtil})
      : _videoCarouselUtil = videoCarouselUtil;

  void playOrPauseVideo(int index) {
    _videoCarouselUtil.playOrPauseVideo(index: index);
    notifyListeners();
  }

  bool get isCurrentVideoPlaying => _videoCarouselUtil.isCurrentVideoPlaying;

  Future<List<VideoPlayerController>> initControllers(
      List<dynamic> videoPaths) async {
    return await _videoCarouselUtil.initializeControllers(
        videoPaths: videoPaths);
  }

  Function() get disposeControllers => _videoCarouselUtil.disposeControllers;
}
