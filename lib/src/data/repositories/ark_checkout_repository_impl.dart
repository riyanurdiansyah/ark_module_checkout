import 'dart:developer';
import 'package:ark_module_checkout/ark_module_checkout.dart';
import 'package:ark_module_checkout/src/core/exception_handling.dart';
import 'package:ark_module_checkout/src/domain/entities/payment_method_entity.dart';
import 'package:ark_module_checkout/src/domain/entities/waiting_order_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:ark_module_checkout/src/core/failures.dart';

class ArkCheckoutRepositoryImpl implements ArkCheckoutRepository {
  final ArkCheckoutRemoteDataSource dataSource;
  ArkCheckoutRepositoryImpl(this.dataSource);

  @override
  Stream<CoinEntity> streamCoin(String id) {
    return dataSource.streamCoin(id).map((event) => event);
  }

  @override
  Future<Either<Failure, CouponEntity>> checkCoupon(
      String token, String kode) async {
    try {
      final coupon = await dataSource.checkCoupon(token, kode);
      return Right(coupon);
    } catch (e) {
      log("ERROR CHECKOUT REPO CHECK COUPON: ${e.toString()}");
      return ExceptionHandleResponse.execute(e);
    }
  }

  @override
  Stream<List<PaymentMethodEntity>> streamPaymentMehtod() {
    return dataSource.streamPaymentMethod();
  }

  @override
  Future<Either<Failure, int>> order(
      String token, Map<String, dynamic> body) async {
    try {
      final order = await dataSource.order(token, body);
      return Right(order);
    } catch (e) {
      log("ERROR CHECKOUT REPO ORDER : ${e.toString()}");
      return ExceptionHandleResponse.execute(e);
    }
  }

  @override
  Future<Either<Failure, WaitingOrderEntity>> checkStatusOrder(
      String token, int orderId) async {
    try {
      final status = await dataSource.checkStatusOrder(token, orderId);
      return Right(status);
    } catch (e) {
      log("ERROR CHECKOUT REPO CHECK STATUS : ${e.toString()}");
      return ExceptionHandleResponse.execute(e);
    }
  }
}
