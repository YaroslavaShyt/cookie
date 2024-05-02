import 'package:cookie/app/common/base_change_notifier/base_change_notifier.dart';
import 'package:cookie/domain/dish/idishes_data.dart';
import 'package:cookie/domain/services/ilocal_storage.dart';
import 'package:flutter/material.dart';

class DishesVideoViewModel extends BaseChangeNotifier {
  final ILocalStorage _localStorage;
  final IDishData dishData;

  DishesVideoViewModel(
      {required this.dishData, required ILocalStorage localStorage})
      : _localStorage = localStorage;

  void saveWatchedVideoHistory({required String categoryName, required int index}) async{
    debugPrint("IN $categoryName LAST WAS $index");
    await _localStorage.save(key: categoryName, data: index);
  }

  Future<int?> loadWatchedVideoHistory({required String categoryName}) async{
    return await _localStorage.read(key: categoryName);
  }
  
}
