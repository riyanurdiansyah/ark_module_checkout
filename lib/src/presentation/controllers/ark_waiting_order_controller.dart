import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:ark_module_checkout/ark_module_checkout.dart';
import 'package:ark_module_checkout/src/core/exception_handling.dart';
import 'package:ark_module_checkout/src/domain/entities/payment_method_entity.dart';
import 'package:ark_module_checkout/src/domain/entities/waiting_order_entity.dart';
import 'package:ark_module_checkout/utils/app_dialog.dart';
import 'package:ark_module_checkout/utils/app_empty_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArkWaitingOrderController extends GetxController {
  final _checkoutC = Get.find<ArkCheckoutController>();
  PaymentMethodEntity _selectedPaymentMethod = emptyPaymentMethod;
  PaymentMethodEntity get selectedPaymentMethod => _selectedPaymentMethod;

  final Rx<WaitingOrderEntity> _waitingOrder = emptyWaitingOrder.obs;
  Rx<WaitingOrderEntity> get waitingOrder => _waitingOrder;

  int _orderId = 0;
  int _initialCoins = 0;
  int _maxCoins = 0;

  late Timer _timer;

  final Rx<int> _timerOvo = 65.obs;
  Rx<int> get timerOvo => _timerOvo;

  final Rx<String> _token = ''.obs;
  Rx<String> get token => _token;

  final Rx<String> _userId = ''.obs;
  Rx<String> get userId => _userId;

  late SharedPreferences _prefs;

  late ArkCheckoutUseCase _useCase;
  late ArkCheckoutRepository _repository;
  late ArkCheckoutRemoteDataSource _dataSource;

  final Rx<bool> _isDecreese = false.obs;

  final Rx<bool> _isOvo = false.obs;
  Rx<bool> get isOvo => _isOvo;

  final Rx<bool> _isShowBackBtn = false.obs;
  Rx<bool> get isShowBackBtn => _isShowBackBtn;

  bool _isUsingCoin = false;

  @override
  void onInit() async {
    await _setup();
    super.onInit();
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }

  Future _setup() async {
    _prefs = await SharedPreferences.getInstance();
    _token.value = _prefs.getString('token_access') ?? '';
    _userId.value = _prefs.getString('user_id') ?? '';

    _dataSource = ArkCheckoutRemoteDataSourceImpl();
    _repository = ArkCheckoutRepositoryImpl(_dataSource);
    _useCase = ArkCheckoutUseCase(_repository);

    log("CHECK : ${Get.arguments}");

    if (Get.arguments != null) {
      _orderId = Get.arguments[0];
      _selectedPaymentMethod = Get.arguments[1];
      _isUsingCoin = Get.arguments[2] ?? false;
      _initialCoins = Get.arguments[3] ?? 0;
      _maxCoins = Get.arguments[4] ?? 0;
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerOvo > 0) {
        _timerOvo.value--;
      }
      checkStatusOrder();
    });
  }

  Future checkStatusOrder() async {
    final response = await _useCase.checkOrderStatus(_token.value, _orderId);
    response.fold(
      (fail) => ExceptionHandle.execute(fail),
      (data) async {
        _waitingOrder.value = data;
        _checkoutC.waitingOrder.value = data;
        final status = data.data.status.toLowerCase();
        final mtUrl = data.data.mtPaymentUrl;

        log("STATUS ORDER STATUS ==========> $status");
        log("STATUS ORDER URL ==========> $mtUrl");

        ///IF STATUS PAYMENT == FAILED
        if (status == 'failed') {
          if (_selectedPaymentMethod.title == 'OVO') {
            final ovoUrl = json.decode(mtUrl);
            if (ovoUrl['failure_code'] == "INVALID_ACCOUNT_DETAILS") {
              if (_isDecreese.value && _isUsingCoin) {
                await FirebaseFirestore.instance
                    .collection("coins")
                    .doc(_userId.value)
                    .update({
                  "coins": _initialCoins,
                });
              }
              _timer.cancel();
              Get.back();
              AppDialog.loadingFailed(
                title: 'Nomor anda tidak terdaftar di OVO',
              );
            }
            if (ovoUrl['failure_code'] == "USER_DECLINED_PAYMENT") {
              _timer.cancel();
              Get.back();
              AppDialog.loadingFailed(
                title: 'Waktu pembayaran anda habis',
              );
              Future.delayed(const Duration(seconds: 2), () => Get.back());
            }
          }
        }

        ///IF STATUS PAYMENT == ON HOLD or PENDING
        if (status == 'on-hold' || status == 'pending') {
          ///IF PAYMENT METHOD IS OVO
          if (_selectedPaymentMethod.chanel.contains('xendit-ovo')) {
            //DECREASE COIN IF USE COIN
            if (!_isDecreese.value && _isUsingCoin) {
              await FirebaseFirestore.instance
                  .collection("coins")
                  .doc(_userId.value)
                  .update({
                "coins": _initialCoins - _maxCoins,
              }).whenComplete(() => _isDecreese.value = true);
            }
            if (mtUrl.isNotEmpty) {
              log("STATUS ORDER WITH ==========> OVO");
              Future.delayed(
                const Duration(
                  seconds: 4,
                ),
                () {
                  final ovoUrl = json.decode(mtUrl);
                  if (ovoUrl['failure_code'] == 'success') {
                    _isOvo.value = true;
                    _isShowBackBtn.value = true;
                  }
                },
              );
            }
          }
        }

        ///IF PAYMENT METHOD IS DANA
        if (_selectedPaymentMethod.chanel.contains('xendit-dana')) {
          if (mtUrl.isNotEmpty) {
            final danaUrl = json.decode(mtUrl);
            log("STATUS ORDER WITH ==========> DANA");
            if (_isUsingCoin) {
              await FirebaseFirestore.instance
                  .collection("coins")
                  .doc(_userId.value)
                  .update({
                "coins": _initialCoins - _maxCoins,
              });
            }
            _timer.cancel();
            Get.offNamed("/ark-snap-payment",
                arguments: danaUrl['action']['mobile_web_checkout_url']);
          }
        }

        ///IF PAYMENT METHOD IS BACS
        if (_selectedPaymentMethod.chanel.contains('bacs')) {
          if (mtUrl.isNotEmpty) {
            if (_isUsingCoin) {
              await FirebaseFirestore.instance
                  .collection("coins")
                  .doc(_userId.value)
                  .update({
                "coins": _initialCoins - _maxCoins,
              });
            }

            _timer.cancel();
            Get.offNamed("/ark-snap-payment", arguments: mtUrl);
          }
        }

        ///IF PAYMENT METHOD IS MIDTRANS
        if (_selectedPaymentMethod.chanel.contains('midtrans')) {
          if (mtUrl.isNotEmpty) {
            if (_isUsingCoin) {
              await FirebaseFirestore.instance
                  .collection("coins")
                  .doc(_userId.value)
                  .update({
                "coins": _initialCoins - _maxCoins,
              });
            }

            _timer.cancel();
            Get.offNamed("/ark-snap-payment",
                arguments: "$mtUrl${_selectedPaymentMethod.code}");
          }
        }
      },
    );
  }
}
