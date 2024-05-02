import 'package:flutter/material.dart';
import 'package:cookie/app/screens/dishes_videos/widgets/dish_video_list.dart';
import 'package:cookie/domain/dish/idishes_data.dart';
import 'package:video_player/video_player.dart';

class DishCategoriesList extends StatefulWidget {
  final IDishData data;
  final bool isCurrentVideoPlaying;
  final Function(int) playOrPause;
  final Function(List<dynamic>) initControllers;
  final Function() disposeControllers;
  final List<VideoPlayerController> videoPlayerControllers;

  const DishCategoriesList(
      {super.key,
      required this.data,
      required this.isCurrentVideoPlaying,
      required this.playOrPause,
      required this.initControllers,
      required this.videoPlayerControllers,
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
              videoPlayerControllers: widget.videoPlayerControllers,
              isCurrentVideoPlaying: widget.isCurrentVideoPlaying,
              playOrPause: widget.playOrPause);
        });
  }
}
