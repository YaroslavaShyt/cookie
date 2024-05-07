import 'dart:async';
import 'dart:developer';
import 'package:cookie/app/services/video_player/video_playe_servicer.dart';
import 'package:cookie/domain/services/ivideo_player_service.dart';
import 'package:flutter/material.dart';
import 'package:cookie/app/screens/dishes_videos/widgets/dish_video_list.dart';
import 'package:cookie/domain/dish/idishes_data.dart';

class DishCategoriesList extends StatefulWidget {
  final IVideoPlayerService videoPlayerService;
  final IDishData data;

  const DishCategoriesList({
    super.key,
    required this.data,
    required this.videoPlayerService,
  });

  @override
  State<DishCategoriesList> createState() => _DishCategoriesListState();
}

class _DishCategoriesListState extends State<DishCategoriesList> {
  PageController? verticalPageController;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    verticalPageController = PageController(viewportFraction: 0.9);
    widget.videoPlayerService.spawnControllers(quantity: 5);
  }

  @override
  void dispose() {
    if (verticalPageController != null) {
      verticalPageController!.dispose();
    }
    widget.videoPlayerService.disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        onPageChanged: (index) async {
          setState(() {
            currentIndex = index;
          });
        },
        controller: verticalPageController,
        itemCount: widget.data.dishesList.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          log("CATEGORY NAME: ${widget.data.dishesList[index].name}");
          return DishVideoList(
            isCurrent: currentIndex == index,
            dish: widget.data.dishesList[index],
            videoPlayerService: widget.videoPlayerService,
          );
        });
  }
}
