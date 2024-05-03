import 'dart:developer';

import 'package:cookie/app/services/locator/locator.dart';
import 'package:cookie/app/utils/caching/cache_util.dart';
import 'package:cookie/app/utils/video_carousel/video_carousel_util.dart';
import 'package:flutter/material.dart';
import 'package:cookie/app/screens/dishes_videos/widgets/dish_video_list.dart';
import 'package:cookie/domain/dish/idishes_data.dart';

class DishCategoriesList extends StatefulWidget {
  final Function({required String categoryName, required int index})
      saveWatchedVideoHistory;
  final Function({required String categoryName}) loadWatchedVideoHistory;
  final IDishData data;

  const DishCategoriesList({
    super.key,
    required this.data,
    required this.saveWatchedVideoHistory,
    required this.loadWatchedVideoHistory,
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
      onPageChanged: (index){
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
              isCurrent: currentIndex == index ,
              dish: widget.data.dishesList[index],
              saveWatchedVideoHistory: widget.saveWatchedVideoHistory,
              loadWatchedVideoHistory: widget.loadWatchedVideoHistory);
        });
  }
}
