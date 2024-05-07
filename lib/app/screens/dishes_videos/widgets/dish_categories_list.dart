import 'package:cookie/app/utils/video_player/ivideo_player_handler.dart';
import 'package:flutter/material.dart';
import 'package:cookie/app/screens/dishes_videos/widgets/dish_video_list.dart';
import 'package:cookie/domain/dish/idishes_data.dart';

class DishCategoriesList extends StatefulWidget {
  final IVideoPlayerHandler videoPlayerService;
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
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    verticalPageController = PageController(viewportFraction: 0.9);
    widget.videoPlayerService.spawnControllers(quantity: 6);
  }

  @override
  void dispose() {
    verticalPageController?.dispose();
    widget.videoPlayerService.disposeControllers();
    super.dispose();
  }

  void _onVerticalIndexChanged(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        onPageChanged: _onVerticalIndexChanged,
        controller: verticalPageController,
        itemCount: widget.data.dishesList.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return DishVideoList(
            isCurrent: _currentIndex == index,
            dish: widget.data.dishesList[index],
            videoPlayerService: widget.videoPlayerService,
          );
        });
  }
}
