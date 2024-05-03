import 'dart:developer';
import 'package:cookie/app/screens/dishes_videos/widgets/current_video_indicators.dart';
import 'package:cookie/app/screens/dishes_videos/widgets/main_video_player.dart';
import 'package:cookie/domain/dish/idish.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class DishVideoList extends StatefulWidget {
  final Function({required String categoryName, required int index})
      saveWatchedVideoHistory;
  final Function({required String categoryName}) loadWatchedVideoHistory;

  final IDish dish;
  final bool isCurrent;
  const DishVideoList(
      {super.key,
      required this.dish,
      required this.saveWatchedVideoHistory,
      required this.loadWatchedVideoHistory,
      required this.isCurrent});

  @override
  State<DishVideoList> createState() => _DishVideoListState();
}

class _DishVideoListState extends State<DishVideoList> {
  PageController? horizontalPageController;
  late Future<List<VideoPlayerController>> initOperation;
  int currentIndex = 0;
  int lastSavedIndex = 0;

  @override
  void initState() {
    super.initState();
    widget
        .loadWatchedVideoHistory(categoryName: widget.dish.name)
        .then((index) {
      log("SAVED INDEX $index");
      setState(() {
        lastSavedIndex = index ?? 0;
        currentIndex = widget.isCurrent ? lastSavedIndex : 0;
        
      });
      horizontalPageController = PageController(
        viewportFraction: 0.8,
        initialPage: currentIndex,
      );
    });
  }

  @override
  void dispose() {
    if (horizontalPageController != null) {
      horizontalPageController!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log("DISH VIDEO LIST CATEGORY: ${widget.dish.name}");
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            onPageChanged: (index) async {
              setState(() {
                currentIndex = index;
              });
              widget.saveWatchedVideoHistory(
                  categoryName: widget.dish.name, index: index);
            },
            controller: horizontalPageController,
            scrollDirection: Axis.horizontal,
            itemCount: widget.isCurrent ? widget.dish.videos.length : 1,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: MainVideoPlayer(videoUrl: widget.dish.videos[index]),
              );
            },
          ),
        ),
        SizedBox(
            height: 50,
            child: CurrentVideoIndicators(
                quantity: widget.dish.videos.length,
                selectedIndex: currentIndex)),
      ],
    );
  }
}
