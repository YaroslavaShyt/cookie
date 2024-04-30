import 'package:flutter/material.dart';
import 'package:test_pr/app/screens/dishes_videos/widgets/horizontal_page_view.dart';
import 'package:test_pr/domain/dish/idishes_data.dart';

class VerticalPageView extends StatelessWidget {
  final IDishData data;
  const VerticalPageView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        itemCount: data.dishesList.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index){
        return HorizontalPageView(data: data.dishesList[index].videos);
    });
  }
}
