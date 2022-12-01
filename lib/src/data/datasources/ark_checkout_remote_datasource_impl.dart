import 'dart:convert';
import 'dart:developer';

import 'package:ark_module_checkout/ark_module_checkout.dart';
import 'package:ark_module_checkout/src/core/exception_handling.dart';
import 'package:ark_module_checkout/src/core/interceptor.dart';
import 'package:ark_module_checkout/src/data/dto/payment_method_dto.dart';
import 'package:ark_module_checkout/src/data/dto/waiting_order_dto.dart';
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
    final response = await dio.get(
      checkCouponUrl,
      queryParameters: {
        "code": kode,
      },
      options: dioOptions(),
    );
    log("CHECK COUP : ${response.statusCode}");
    int code = response.statusCode ?? 500;
    if (code == 200) {
      if (response.data['success'] == true) {
        return CouponDTO.fromJson(response.data);
      }
      return CouponDTO.fromJson({
        "success": false,
        "data": {},
      });
    }
    if (code == 400) {
      return CouponDTO.fromJson({
        "success": false,
        "data": {},
      });
    }
    return ExceptionHandleResponseAPI.execute(
      code,
      response,
      'Error Check Coupon... failed connect to server',
    );
  }

  @override
  Stream<List<PaymentMethodDTO>> streamPaymentMethod() {
    Stream<QuerySnapshot<Map<String, dynamic>>> stream = FirebaseFirestore
        .instance
        .collection("payment_method")
        .orderBy('id')
        .snapshots();
    return stream.map((val) => val.docs).map((ev) {
      return paymentFromJson(json.encode(ev.map((e) => e.data()).toList()));
    });
  }

  @override
  Future<int> order(String token, Map<String, dynamic> body) async {
    await dioInterceptor(dio, token);
    final response = await dio.post(
      createOrderUrl,
      data: body,
      options: dioOptions(),
    );
    int code = response.statusCode ?? 500;
    if (code == 200) {
      if (response.data['success']) {
        return response.data['order_id'];
      }
    }
    return ExceptionHandleResponseAPI.execute(
      code,
      response,
      'Error Create Order... failed connect to server',
    );
  }

  @override
  Future<WaitingOrderDTO> checkStatusOrder(String token, int orderId) async {
    await dioInterceptor(dio, token);
    final response = await dio.get(
      "$checkStatusOrderUrl/$orderId",
      options: dioOptions(),
    );
    log("CHECK RES : ${response.data}");
    int code = response.statusCode ?? 500;
    if (code == 200) {
      return WaitingOrderDTO.fromJson(response.data);
    }
    return ExceptionHandleResponseAPI.execute(
      code,
      response,
      'Error Check Status Order... failed connect to server',
    );
  }
}
