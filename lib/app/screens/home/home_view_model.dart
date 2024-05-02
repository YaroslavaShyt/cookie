import 'package:cookie/app/common/base_change_notifier/base_change_notifier.dart';
import 'package:cookie/app/routing/navigation_util/inavigation_util.dart';
import 'package:cookie/app/routing/router/routes.dart';
import 'package:cookie/domain/dish/idish_repository.dart';
import 'package:cookie/domain/dish/idishes_data.dart';

class HomeViewModel extends BaseChangeNotifier {
  final IDishRepository _dishRepository;
  final INavigationUtil _navigationUtil;

  HomeViewModel(
      {required IDishRepository dishRepository,
      required INavigationUtil navigationUtil})
      : _dishRepository = dishRepository,
        _navigationUtil = navigationUtil;

  Stream<IDishData> get dishesDataStream => _dishRepository.dishesDataStream();
  
  void navigateToVideos({required IDishData data}){
    _navigationUtil.navigateTo(Routes.videosRoute, data: data);
  }
}
