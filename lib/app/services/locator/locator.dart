import 'package:cookie/app/services/local_storage/local_storage.dart';
import 'package:cookie/app/utils/video_player/video_controllers_handler.dart';
import 'package:cookie/app/utils/caching/cache_util.dart';
import 'package:cookie/domain/services/ilocal_storage.dart';
import 'package:cookie/app/utils/video_player/ivideo_controllers_handler.dart';
import 'package:get_it/get_it.dart';
import 'package:cookie/data/dishes/dish_repository.dart';
import 'package:cookie/domain/dish/idish_repository.dart';

final locator = GetIt.I;

void initLocator() {
  initRepos();
  initUtils();
  initServices();
}

void initRepos() {
  locator.registerFactory<IDishRepository>(() => DishRepository());
}

void initUtils() {
  locator.registerFactory<CacheUtil>(() => CacheUtil());
}

void initServices() {
  locator.registerFactory<ILocalStorage>(() => LocalStorage());
  locator.registerFactory<IVideoControllersHandler>(
      () => VideoControllersHandler(localStorage: locator.get<ILocalStorage>()));
}
