import 'package:cookie/domain/dish/idish.dart';
import 'package:cookie/data/models/keys.dart';

class Dish implements IDish {
  @override
  final String id;

  @override
  final String name;

  @override
  final String image;

  @override
  final List<dynamic> videos;

  Dish(
      {required this.name,
      required this.videos,
      required this.image,
      required this.id});

  @override
  factory Dish.fromJson({required Map<String, dynamic> data}) {
    return Dish(
        id: data[Keys.keyId],
        name: data[Keys.keyName],
        videos: data[Keys.keyVideos], // [{"thumbnail" : "/https", "video": "/https"}, {"thumbnail": "/https", "video": "/https"}]
        image: data[Keys.keyImage]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      Keys.keyName: name,
      Keys.keyVideos: videos,
      Keys.keyImage: image,
      Keys.keyId: id
    };
  }
}
