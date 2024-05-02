import 'package:cookie/app/utils/caching/cache_util.dart';
import 'package:cookie/app/utils/video_carousel/video_carousel_util.dart';
import 'package:get_it/get_it.dart';
import 'package:cookie/data/dishes/dish_repository.dart';
import 'package:cookie/domain/dish/idish_repository.dart';

final locator = GetIt.I;

void initLocator() {
  initRepos();
  initUtils();
}

void initRepos() {
  locator.registerFactory<IDishRepository>(() => DishRepository());
}

void initUtils() {
  locator.registerFactory<CacheUtil>(() => CacheUtil());
  locator.registerFactory<VideoCarouselUtil>(
      () => VideoCarouselUtil(cacheUtil: locator.get<CacheUtil>()));
}
