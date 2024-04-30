import 'package:flutter/material.dart';

abstract interface class INavigationUtil{
  GlobalKey<NavigatorState> get navigatorKey;

  Future<dynamic> navigateTo<T extends Object?>(String routeName,
      {bool allowBackNavigation = true, dynamic data});

  Future<dynamic> navigateToAndMakeRoot<T extends Object?>(String routeName,
      {dynamic data, bool allowBackNavigation = true,});

  Future<dynamic> navigateToAndReplace<T extends Object?>(String routeName,
      {dynamic data});

  void navigateBack({dynamic data, int pagesNum = 1});

  void navigateBackUntilNamed(String named);

  bool get canPop;

  void navigateBackToStart();
}