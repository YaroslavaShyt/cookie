import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_pr/app/screens/error/error_screen.dart';
import 'package:test_pr/app/screens/error/error_view_model.dart';

class ErrorFactory {
  static Widget build() {
    return ChangeNotifierProvider(
        create: (_) => ErrorViewModel(),
        child: Consumer<ErrorViewModel>(
          builder: (context, model, child) {
            return const ErrorScreen();
          },
        ));
  }
}
