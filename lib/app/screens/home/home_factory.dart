import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_pr/app/routing/navigation_util/inavigation_util.dart';
import 'package:test_pr/app/screens/home/home_screen.dart';
import 'package:test_pr/app/screens/home/home_view_model.dart';
import 'package:test_pr/app/services/locator/locator.dart';
import 'package:test_pr/domain/dish/idish_repository.dart';

class HomeFactory {
  static Widget build() {
    return ChangeNotifierProvider(
        create: (context) => HomeViewModel(
            navigationUtil: context.read<INavigationUtil>(),
            dishRepository: locator.get<IDishRepository>()),
        child: Consumer<HomeViewModel>(builder: (context, model, child) {
          return HomeScreen(
            viewModel: model,
          );
        }));
  }
}
