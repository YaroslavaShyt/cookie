import 'package:flutter/material.dart';
import 'package:test_pr/app/screens/dishes_videos/dishes_videos_view_model.dart';
import 'package:test_pr/app/screens/dishes_videos/widgets/vertical_page_view.dart';

class DishesVideosScreen extends StatelessWidget {
  final DishesVideoViewModel viewModel;
  const DishesVideosScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VerticalPageView(
        data: viewModel.dishData,
      ),
    );
  }
}
