import 'package:ark_module_checkout/ark_module_checkout.dart';
import 'package:ark_module_checkout/src/core/failures.dart';
import 'package:ark_module_checkout/src/domain/entities/payment_method_entity.dart';
import 'package:ark_module_checkout/src/domain/entities/waiting_order_entity.dart';
import 'package:dartz/dartz.dart';

class ArkCheckoutUseCase {
  final ArkCheckoutRepository _repository;

  ArkCheckoutUseCase(this._repository);

  Stream<CoinEntity> streamCoin(String id) => _repository.streamCoin(id);

  Stream<List<PaymentMethodEntity>> streamPaymentMethod() =>
      _repository.streamPaymentMehtod();

  Future<Either<Failure, CouponEntity>> checkCoupon(
          String token, String kode) async =>
      _repository.checkCoupon(token, kode);

  Future<Either<Failure, int>> order(
          String token, Map<String, dynamic> body) async =>
      _repository.order(token, body);

  Future<Either<Failure, WaitingOrderEntity>> checkOrderStatus(
          String token, int orderId) async =>
      _repository.checkStatusOrder(token, orderId);
}
