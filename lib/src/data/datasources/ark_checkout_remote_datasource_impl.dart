import 'package:ark_module_setup/ark_module_setup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'ark_checkout_remote_datasource.dart';

class ArkCheckoutRemoteDataSourceImpl implements ArkCheckoutRemoteDataSource {
  @override
  Stream<CoinDTO> streamCoin(String userId) {
    Stream<DocumentSnapshot<Map<String, dynamic>>> stream =
        FirebaseFirestore.instance.collection("coins").doc(userId).snapshots();
    return stream.map(
      (event) {
        if (event.data() != null) {
          if (event.exists) {
            return CoinDTO.fromJson(event.data()!);
          } else {
            return CoinDTO(
              coins: 0,
              isCompleted: false,
              createdAt: Timestamp.now(),
              updatedAt: Timestamp.now(),
              isOldUser: false,
            );
          }
        } else {
          return CoinDTO(
            coins: 0,
            isCompleted: false,
            createdAt: Timestamp.now(),
            updatedAt: Timestamp.now(),
            isOldUser: false,
          );
        }
      },
    );
  }
}
