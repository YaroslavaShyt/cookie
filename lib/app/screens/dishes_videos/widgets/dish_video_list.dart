import 'package:cookie/app/screens/dishes_videos/widgets/current_video_indicators.dart';
import 'package:cookie/app/screens/dishes_videos/widgets/main_video_player.dart';
import 'package:cookie/app/screens/dishes_videos/widgets/thumbnail.dart';
import 'package:cookie/data/models/keys.dart';
import 'package:cookie/domain/dish/idish.dart';
import 'package:cookie/app/utils/video_player/ivideo_controllers_handler.dart';
import 'package:flutter/material.dart';

class DishVideoList extends StatefulWidget {
  final IVideoControllersHandler videoControllerHandler;
  final IDish dish;
  final bool isCurrent;

  const DishVideoList({
    super.key,
    required this.dish,
    required this.videoControllerHandler,
    required this.isCurrent,
  });

  @override
  State<DishVideoList> createState() => _DishVideoListState();
}

class _DishVideoListState extends State<DishVideoList> {
  int? _currentIndex;
  bool _isIndexSet = false;
  PageController? _horizontalPageController;

  @override
  void initState() {
    super.initState();
    _loadLastIndex();
  }

  @override
  void dispose() {
    _horizontalPageController?.dispose();
    super.dispose();
  }

  Future<void> _onHorizontalIndexChanged(int index) async {
    setState(() {
      _currentIndex = index;
    });
    if (widget.isCurrent) {
      await widget.videoControllerHandler.saveWatchedVideoHistory(
          categoryName: widget.dish.name, index: index);
    }
  }

  void _loadLastIndex() {
    widget.videoControllerHandler
        .loadLastWatchedVideoIndex(categoryName: widget.dish.name)
        .then((value) {
      WidgetsBinding.instance.addPostFrameCallback((timestamp) {
        setState(() {
          final savedIndex = value ?? 1;
          _currentIndex = savedIndex;
          _horizontalPageController = PageController(
              viewportFraction: 0.8, initialPage: _currentIndex!);
          _isIndexSet = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isIndexSet) {
      return Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _horizontalPageController,
              onPageChanged: _onHorizontalIndexChanged,
              scrollDirection: Axis.horizontal,
              itemCount: widget.dish.videos.length,
              itemBuilder: (context, index) {
                return _buildVideoFrameOrEmptyBox(index);
              },
            ),
          ),
          SizedBox(
            height: 50,
            child: CurrentVideoIndicators(
              quantity: widget.dish.videos.length,
              selectedIndex: _currentIndex!,
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

  Widget _buildVideoFrameOrEmptyBox(int index) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: _currentIndex == index || widget.isCurrent
            ? MainVideoPlayer(
                isCurrent: _currentIndex == index && widget.isCurrent,
                videoUrl: widget.dish.videos[index][Keys.keyVideo],
                videoControllerHandler: widget.videoControllerHandler,
              )
            : Thumbnail(
                imageUrl: widget.dish.videos[index][Keys.keyThumbnail]));
  }
}
