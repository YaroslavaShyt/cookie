import 'package:flutter/material.dart';
import 'package:cookie/app/screens/dishes_videos/widgets/main_video_player.dart';

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
