import 'dart:developer';
import 'package:cookie/app/screens/dishes_videos/widgets/current_video_indicators.dart';
import 'package:cookie/app/screens/dishes_videos/widgets/main_video_player.dart';
import 'package:cookie/app/utils/video_carousel/video_carousel_util.dart';
import 'package:cookie/domain/dish/idish.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class DishVideoList extends StatefulWidget {
  final VideoCarouselUtil videoCarouselUtil;
  final Function({required String categoryName, required int index})
      saveWatchedVideoHistory;
  final Function({required String categoryName}) loadWatchedVideoHistory;

  final IDish dish;

  const DishVideoList(
      {super.key,
      required this.videoCarouselUtil,
      required this.dish,
      required this.saveWatchedVideoHistory,
      required this.loadWatchedVideoHistory});

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
      log("INDEX $index");
      setState(() {
        if (index != null && lastSavedIndex != widget.dish.videos.length - 1) {
          lastSavedIndex = index;
          currentIndex = lastSavedIndex;
        }
        horizontalPageController =
            PageController(viewportFraction: 0.8, initialPage: lastSavedIndex);
      });
    });

    initOperation = widget.videoCarouselUtil
        .initializeControllers(videoPaths: widget.dish.videos);
  }

  @override
  void dispose() {
    log("DISPOSING VIDEO CONTROLLERS");
    widget.videoCarouselUtil.disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log("DISH VIDEO LIST CATEGORY: ${widget.dish.name}");
    return FutureBuilder<List<VideoPlayerController>>(
        future: initOperation,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    onPageChanged: (index) {
                      setState(() {
                        currentIndex = index;
                      });
                      widget.saveWatchedVideoHistory(
                          categoryName: widget.dish.name, index: index);
                    },
                    controller: horizontalPageController,
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: MainVideoPlayer(
                          controller: snapshot.data![index],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                    height: 50,
                    child: CurrentVideoIndicators(
                        quantity: snapshot.data!.length,
                        selectedIndex: currentIndex)),
              ],
            );
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
