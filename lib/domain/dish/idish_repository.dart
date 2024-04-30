import 'idishes_data.dart';

abstract interface class IDishRepository{
  Stream<IDishData> dishesDataStream();
}