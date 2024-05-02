import 'package:cookie/domain/dish/idish.dart';
import 'package:cookie/domain/dish/idishes_data.dart';

class DishData implements IDishData{
  @override
  List<IDish> dishesList;

  DishData({required this.dishesList});
}