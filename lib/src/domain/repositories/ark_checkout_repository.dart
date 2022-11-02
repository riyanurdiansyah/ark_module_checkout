import 'package:ark_module_setup/ark_module_setup.dart';

abstract class ArkCheckoutRepository {
  Stream<CoinEntity> streamCoin(String id);
}
