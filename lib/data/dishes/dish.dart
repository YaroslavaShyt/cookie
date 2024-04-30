import 'package:test_pr/domain/dish/idish.dart';
import 'package:test_pr/data/models/keys.dart';

class Dish implements IDish{
  @override
  final String name;
  @override
  final List<dynamic> videos;

  Dish({required this.name, required this.videos});

  @override
  factory Dish.fromJson({required Map<String, dynamic> data}){
    return Dish(name: data[Keys.keyName], videos: data[Keys.keyVideos]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {Keys.keyName: name, Keys.keyVideos: videos};
  }
}