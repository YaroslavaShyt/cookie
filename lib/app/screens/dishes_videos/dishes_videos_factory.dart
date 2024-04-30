import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:test_pr/app/screens/dishes_videos/dishes_videos_screen.dart';
import 'package:test_pr/app/screens/dishes_videos/dishes_videos_view_model.dart';
import 'package:test_pr/domain/dish/idishes_data.dart';

class DishesVideosFactory {
  static Widget build({required IDishData dishData}) {
    return ChangeNotifierProvider(
        create: (_) => DishesVideoViewModel(
          dishData: dishData
        ),
        child: Consumer<DishesVideoViewModel>(
          builder: (context, model, child) {
            return DishesVideosScreen(viewModel: model);
          },
        ));
  }
}
