import 'package:ark_module_checkout/ark_module_checkout.dart';
import 'package:ark_module_checkout/src/core/failures.dart';
import 'package:dartz/dartz.dart';

class ArkCheckoutUseCase {
  final ArkCheckoutRepository _repository;

  ArkCheckoutUseCase(this._repository);

  Stream<CoinEntity> streamCoin(String id) => _repository.streamCoin(id);

  Future<Either<Failure, CouponEntity>> checkCoupon(
          String token, String kode) async =>
      _repository.checkCoupon(token, kode);
}
