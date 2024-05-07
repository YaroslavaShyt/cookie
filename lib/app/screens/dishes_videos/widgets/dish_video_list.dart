import 'dart:developer';
import 'package:cookie/app/screens/dishes_videos/widgets/current_video_indicators.dart';
import 'package:cookie/app/screens/dishes_videos/widgets/main_video_player.dart';
import 'package:cookie/domain/dish/idish.dart';
import 'package:cookie/domain/services/ivideo_player_service.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/foundation.dart';

class DishVideoList extends StatefulWidget {
  final IVideoPlayerService videoPlayerService;
  final IDish dish;
  final bool isCurrent;

  const DishVideoList({
    Key? key,
    required this.dish,
    required this.videoPlayerService,
    required this.isCurrent,
  }) : super(key: key);

  @override
  State<DishVideoList> createState() => _DishVideoListState();
}

class _DishVideoListState extends State<DishVideoList> {
  late Future<int?> initOperation;
  int? currentIndex;
  bool indexSet = false;

  @override
  void initState() {
    super.initState();

    initOperation = widget.videoPlayerService
        .loadLastWatchedVideoIndex(categoryName: widget.dish.name);
    initOperation.then((value) {
      WidgetsBinding.instance.addPostFrameCallback((timestamp) {
        setState(() {
          final savedIndex = value ?? 1;
          currentIndex = savedIndex;
          indexSet = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (indexSet) {
      log(currentIndex.toString());
      PageController horizontalPageController =
          PageController(viewportFraction: 0.8, initialPage: currentIndex!);
      return Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: horizontalPageController,
              onPageChanged: (index) async {
                setState(() {
                  currentIndex = index;
                });
                widget.isCurrent
                    ? await widget.videoPlayerService.saveWatchedVideoHistory(
                        categoryName: widget.dish.name, index: index)
                    : null;
              },
              scrollDirection: Axis.horizontal,
              itemCount: widget.dish.videos.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: currentIndex == index || widget.isCurrent
                        ? Container(
                            color: Colors.amber,
                            height: 500,
                            width: 500,
                            child: Center(child: Text("data")),
                          )
                        : SizedBox());
              },
            ),
          ),
          SizedBox(
            height: 50,
            child: CurrentVideoIndicators(
              quantity: widget.dish.videos.length,
              selectedIndex: currentIndex!,
            ),
          ),
        ],
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
