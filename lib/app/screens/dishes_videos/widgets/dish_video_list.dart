import 'dart:developer';

import 'package:cookie/app/screens/dishes_videos/widgets/current_video_indicators.dart';
import 'package:cookie/app/screens/dishes_videos/widgets/main_video_player.dart';
import 'package:cookie/domain/dish/idish.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

class DishVideoList extends StatefulWidget {
  final List<VideoPlayerController> videoPlayerControllers;
  final bool isCurrentVideoPlaying;
  final Function(int) playOrPause;
  final Function(List<dynamic>) initControllers;
  final Function() disposeControllers;
  final IDish dish;

  const DishVideoList(
      {super.key,
      required this.videoPlayerControllers,
      required this.isCurrentVideoPlaying,
      required this.playOrPause,
      required this.initControllers,
      required this.disposeControllers,
      required this.dish});

  @override
  State<DishVideoList> createState() => _DishVideoListState();
}

class _DishVideoListState extends State<DishVideoList> {
  PageController? horizontalPageController;
  late Future<List<VideoPlayerController>> initOperation;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    horizontalPageController = PageController(viewportFraction: 0.9);
    initOperation = widget.initControllers(widget.dish.videos);
  }

  @override
  void dispose() {
    log("DISPOSING VIDEO CONTROLLERS");
    widget.disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<VideoPlayerController>>(
        future: initOperation,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(children: [
              PageView.builder(
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.videoPlayerControllers.length,
                  itemBuilder: (context, index) {
                    return MainVideoPlayer(
                        index: index,
                        isVideoPlaying: widget.isCurrentVideoPlaying,
                        controller: snapshot.data![index],
                        playOrPause: widget.playOrPause);
                  }),
              Positioned(
                left: 0,
                right: 0,
                bottom: 20,
                child: CurrentVideoIndicators(
                    quantity: snapshot.data!.length,
                    selectedIndex: currentIndex),
              )
            ]);
          } else if (snapshot.hasError) {
            return Center(
              child:
                  Text("Не вдалось завантажити: ${snapshot.error.toString()}"),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
