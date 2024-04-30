import 'package:flutter/cupertino.dart';

class BaseChangeNotifier extends ChangeNotifier{
  bool _isDataLoaded = false;

  bool get isDataLoaded => _isDataLoaded;

  void setIsDataLoaded({required isLoaded}){
    _isDataLoaded = isLoaded;
  }
}