import 'package:ark_module_checkout/ark_module_checkout.dart';
import 'package:ark_module_checkout/src/data/dto/payment_method_dto.dart';
import 'package:ark_module_checkout/src/data/dto/waiting_order_dto.dart';

abstract class ArkCheckoutRemoteDataSource {
  Stream<CoinDTO> streamCoin(String id);

  Stream<List<PaymentMethodDTO>> streamPaymentMethod();

  Future<CouponDTO> checkCoupon(String token, String kode);

  Future<int> order(String token, Map<String, dynamic> body);

  Future<WaitingOrderDTO> checkStatusOrder(String token, int orderId);
}
