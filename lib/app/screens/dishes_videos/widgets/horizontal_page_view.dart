import 'package:flutter/material.dart';
import 'package:test_pr/app/screens/dishes_videos/widgets/main_video_player.dart';
import 'package:test_pr/domain/dish/idishes_data.dart';

class HorizontalPageView extends StatelessWidget {
  final List<dynamic> data;
  const HorizontalPageView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: data.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index){
        return MainVideoPlayer(videoUrl: data[index],);
    });
  }
}
