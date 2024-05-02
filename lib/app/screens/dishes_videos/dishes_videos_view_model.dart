import 'package:cookie/app/common/base_change_notifier/base_change_notifier.dart';
import 'package:cookie/domain/dish/idishes_data.dart';

class DishesVideoViewModel extends BaseChangeNotifier {
  final IDishData dishData;
 
  DishesVideoViewModel(
      {required this.dishData});


}
