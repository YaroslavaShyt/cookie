import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_pr/app/screens/home/home_screen.dart';
import 'package:test_pr/app/screens/home/home_view_model.dart';

class HomeFactory {
  static Widget build() {
    return ChangeNotifierProvider(
        create: (_) => HomeViewModel(),
        child: Consumer<HomeViewModel>(builder: (context, model, child) {
          return const HomeScreen();
        }));
  }
}
