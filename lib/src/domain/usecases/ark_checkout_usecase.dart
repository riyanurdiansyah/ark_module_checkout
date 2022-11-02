import 'package:ark_module_checkout/src/domain/repositories/ark_checkout_repository.dart';
import 'package:ark_module_setup/ark_module_setup.dart';

class ArkCheckoutUseCase {
  final ArkCheckoutRepository repository;

  ArkCheckoutUseCase(this.repository);

  Stream<CoinEntity> streamCoin(String id) => repository.streamCoin(id);
}
