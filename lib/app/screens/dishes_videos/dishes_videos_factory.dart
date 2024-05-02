import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:cookie/app/screens/dishes_videos/dishes_videos_screen.dart';
import 'package:cookie/app/screens/dishes_videos/dishes_videos_view_model.dart';
import 'package:cookie/domain/dish/idishes_data.dart';

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
