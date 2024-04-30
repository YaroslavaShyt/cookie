import 'package:test_pr/domain/dish/idish.dart';
import 'package:test_pr/domain/dish/idishes_data.dart';

class DishData implements IDishData{
  @override
  List<IDish> dishesList;

  DishData({required this.dishesList});
}