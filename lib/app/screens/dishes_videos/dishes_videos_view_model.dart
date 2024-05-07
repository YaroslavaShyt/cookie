import 'package:cookie/app/common/base_change_notifier/base_change_notifier.dart';
import 'package:cookie/app/utils/video_player/ivideo_player_handler.dart';
import 'package:cookie/domain/dish/idishes_data.dart';

class DishesVideoViewModel extends BaseChangeNotifier {
  final IVideoPlayerHandler videoPlayerHandler;
  final IDishData dishData;

  DishesVideoViewModel(
      {required this.dishData, required this.videoPlayerHandler});
}
