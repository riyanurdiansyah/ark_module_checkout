import 'package:ark_module_setup/ark_module_setup.dart';

abstract class ArkCheckoutRemoteDataSource {
  Stream<CoinDTO> streamCoin(String id);
}
