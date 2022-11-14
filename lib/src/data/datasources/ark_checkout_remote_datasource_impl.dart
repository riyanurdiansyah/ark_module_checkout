import 'package:ark_module_checkout/ark_module_checkout.dart';
import 'package:ark_module_checkout/src/core/exception_handling.dart';
import 'package:ark_module_checkout/src/core/interceptor.dart';
import 'package:ark_module_checkout/utils/app_url.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';

class ArkCheckoutRemoteDataSourceImpl implements ArkCheckoutRemoteDataSource {
  late Dio dio;
  ArkCheckoutRemoteDataSourceImpl({Dio? dio}) {
    this.dio = dio ?? Dio();
  }

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

  @override
  Future<CouponDTO> checkCoupon(String token, String kode) async {
    await dioInterceptor(dio, token);
    final response = await dio.get(checkCouponUrl, queryParameters: {
      "code": kode,
    });
    int code = response.statusCode ?? 500;
    if (code == 200) {
      if (response.data['success']) {
        return CouponDTO.fromJson(response.data);
      }
      return CouponDTO.fromJson({
        "success": false,
        "data": {},
      });
    }
    return ExceptionHandleResponseAPI.execute(
      code,
      response,
      'Error Get User Status... failed connect to server',
    );
  }
}
