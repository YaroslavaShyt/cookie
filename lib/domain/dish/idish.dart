import 'package:test_pr/domain/models/ibase_model.dart';

abstract interface class IDish implements IBaseModel {
  final String id;
  final String name;
  final String image;
  final List<dynamic> videos;

  IDish(
      {required this.name,
      required this.videos,
      required this.image,
      required this.id});
}
