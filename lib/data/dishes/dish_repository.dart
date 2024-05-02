import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookie/app/services/networking/endpoints.dart';
import 'package:cookie/data/models/keys.dart';
import 'package:cookie/domain/dish/idish.dart';
import 'package:cookie/domain/dish/idish_repository.dart';
import 'package:cookie/domain/dish/idishes_data.dart';
import 'dart:async';
import 'dish.dart';
import 'dish_data.dart';

class DishRepository implements IDishRepository {
  final StreamController<IDishData> _streamController =
      StreamController.broadcast();

  @override
  Stream<IDishData> dishesDataStream() {
    FirebaseFirestore.instance
        .collection(Endpoints.foodCollectionEndpoint)
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      List<IDish> dishes = [];
      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        dishes.add(Dish.fromJson(data: {
          Keys.keyId: doc.id,
          Keys.keyName: data[Keys.keyName],
          Keys.keyImage: data[Keys.keyImage],
          Keys.keyVideos: data[Keys.keyVideos]
        }));
      }
      _streamController.add(DishData(dishesList: dishes));
    });

    return _streamController.stream;
  }
}
