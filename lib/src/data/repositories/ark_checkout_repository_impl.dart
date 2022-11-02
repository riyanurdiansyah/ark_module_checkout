import 'package:ark_module_checkout/src/data/datasources/ark_checkout_remote_datasource.dart';
import 'package:ark_module_checkout/src/domain/repositories/ark_checkout_repository.dart';
import 'package:ark_module_setup/ark_module_setup.dart';

class ArkCheckoutRepositoryImpl implements ArkCheckoutRepository {
  final ArkCheckoutRemoteDataSource dataSource;
  ArkCheckoutRepositoryImpl(this.dataSource);

  @override
  Stream<CoinEntity> streamCoin(String id) {
    return dataSource.streamCoin(id).map((event) => event);
  }
}
