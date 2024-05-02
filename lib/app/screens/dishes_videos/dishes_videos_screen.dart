import 'package:flutter/material.dart';
import 'package:cookie/app/screens/dishes_videos/dishes_videos_view_model.dart';
import 'package:cookie/app/screens/dishes_videos/widgets/dish_categories_list.dart';

class DishesVideosScreen extends StatelessWidget {
  final DishesVideoViewModel viewModel;
  const DishesVideosScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DishCategoriesList(
       
        data: viewModel.dishData,
      ),
    );
  }
}
