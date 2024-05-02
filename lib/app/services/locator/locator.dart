import 'package:get_it/get_it.dart';
import 'package:cookie/data/dishes/dish_repository.dart';
import 'package:cookie/domain/dish/idish_repository.dart';

final locator = GetIt.I;

void initLocator(){
  initRepos();
}

void initRepos(){
  locator.registerFactory<IDishRepository>(() => DishRepository());
}
