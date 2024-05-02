import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookie/data/models/base_response.dart';
import 'package:cookie/domain/models/ibase_response.dart';
import 'package:cookie/data/models/keys.dart';
import 'package:cookie/domain/services/inetwork_service.dart';

class FirestoreService implements INetworkService {
  final FirebaseFirestore _firestore;

  FirestoreService({required FirebaseFirestore firestore})
      : _firestore = firestore;

  @override
  Future<void> create(
      {required String endpoint, required Map<String, dynamic> data}) async {
    await _firestore.collection(endpoint).add(data);
  }

  @override
  Future<IBaseResponse> read(
      {required String endpoint, required String id}) async {
    DocumentSnapshot documentSnapshot =
        await _firestore.collection(endpoint).doc(id).get();
    if (documentSnapshot.exists) {
      return BaseResponse(code: 200, success: true, data: {
        Keys.keyId: documentSnapshot.id,
        Keys.keyData: documentSnapshot.data()
      });
    } else {
      return BaseResponse(code: 404, success: false);
    }
  }

  @override
  Future<void> update(
      {required String endpoint,
      required String id,
      required Map<String, dynamic> data}) async {
    await _firestore.collection(endpoint).doc(id).update(data);
  }

  @override
  Future<void> delete({required String endpoint, required String id}) async {
    await _firestore.collection(endpoint).doc(id).delete();
  }
}
