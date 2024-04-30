import 'package:test_pr/app/common/base_change_notifier/base_change_notifier.dart';
import 'package:test_pr/domain/dish/idishes_data.dart';

class DishesVideoViewModel extends BaseChangeNotifier{
  final IDishData dishData;
  DishesVideoViewModel({required this.dishData});
}