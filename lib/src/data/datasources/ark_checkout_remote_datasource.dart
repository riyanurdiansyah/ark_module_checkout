import 'package:ark_module_checkout/ark_module_checkout.dart';

abstract class ArkCheckoutRemoteDataSource {
  Stream<CoinDTO> streamCoin(String id);

  Future<CouponDTO> checkCoupon(String token, String kode);
}
