import 'package:ark_module_checkout/ark_module_checkout.dart';
import 'package:ark_module_checkout/src/core/failures.dart';
import 'package:ark_module_checkout/src/domain/entities/payment_method_entity.dart';
import 'package:ark_module_checkout/src/domain/entities/waiting_order_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ArkCheckoutRepository {
  Stream<CoinEntity> streamCoin(String id);

  Stream<List<PaymentMethodEntity>> streamPaymentMehtod();

  Future<Either<Failure, CouponEntity>> checkCoupon(String token, String kode);

  Future<Either<Failure, int>> order(String token, Map<String, dynamic> body);

  Future<Either<Failure, WaitingOrderEntity>> checkStatusOrder(
      String token, int orderId);
}
