import 'package:flutter/material.dart';
import 'package:cookie/app/screens/dishes_videos/widgets/dish_video_list.dart';
import 'package:cookie/domain/dish/idishes_data.dart';

class DishCategoriesList extends StatefulWidget {
  final IDishData data;
  final bool isCurrentVideoPlaying;
  final Function(int) playOrPause;
  final Function(List<dynamic>) initControllers;
  final Function() disposeControllers;

  const DishCategoriesList(
      {super.key,
      required this.data,
      required this.isCurrentVideoPlaying,
      required this.playOrPause,
      required this.initControllers,
      required this.disposeControllers,
     });

  @override
  State<DishCategoriesList> createState() => _DishCategoriesListState();
}

class _DishCategoriesListState extends State<DishCategoriesList> {
  PageController? verticalPageController;

  @override
  void initState() {
    super.initState();
    verticalPageController = PageController(viewportFraction: 0.9);
  }

  @override
  void dispose() {
    if (verticalPageController != null) {
      verticalPageController!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        controller: verticalPageController,
        itemCount: widget.data.dishesList.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return DishVideoList(
              initControllers: widget.initControllers,
              disposeControllers: widget.disposeControllers,
              dish: widget.data.dishesList[index],
              isCurrentVideoPlaying: widget.isCurrentVideoPlaying,
              playOrPause: widget.playOrPause);
        });
  }
}
