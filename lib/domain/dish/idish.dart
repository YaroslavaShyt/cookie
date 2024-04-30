import 'package:test_pr/domain/models/ibase_model.dart';

abstract interface class IDish implements IBaseModel{
  final String name;
  final List<dynamic> videos;

  IDish({required this.name, required this.videos});
}