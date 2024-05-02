import 'package:flutter/material.dart';
import 'package:cookie/app/screens/error/error_factory.dart';
import 'package:cookie/app/screens/home/home_view_model.dart';
import 'package:cookie/app/screens/home/widgets/dish_card.dart';
import 'package:cookie/domain/dish/idishes_data.dart';

class HomeScreen extends StatelessWidget {
  final HomeViewModel viewModel;
  const HomeScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<IDishData>(
            stream: viewModel.dishesDataStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                ErrorFactory.build();
              }
              if (snapshot.hasData) {
                IDishData dishData = snapshot.data!;
                return ListView.builder(
                    itemCount: dishData.dishesList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () => viewModel.navigateToVideos(data: dishData),
                          child: DishCard(dish: dishData.dishesList[index]));
                    });
              }
              return const CircularProgressIndicator();
            }),
      ),
    );
  }
}
