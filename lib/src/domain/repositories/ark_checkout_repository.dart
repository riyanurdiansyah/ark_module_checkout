import 'package:ark_module_checkout/ark_module_checkout.dart';
import 'package:ark_module_checkout/src/core/failures.dart';
import 'package:dartz/dartz.dart';

abstract class ArkCheckoutRepository {
  Stream<CoinEntity> streamCoin(String id);

  Future<Either<Failure, CouponEntity>> checkCoupon(String token, String kode);
}
