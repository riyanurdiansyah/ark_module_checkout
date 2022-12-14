import 'dart:developer';
import 'dart:math' as math;

import 'package:ark_module_checkout/ark_module_checkout.dart';
import 'package:ark_module_checkout/src/core/exception_handling.dart';
import 'package:ark_module_checkout/src/domain/entities/payment_method_entity.dart';
import 'package:ark_module_checkout/src/domain/entities/waiting_order_entity.dart';
import 'package:ark_module_checkout/utils/app_dialog.dart';
import 'package:ark_module_checkout/utils/app_empty_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArkCheckoutController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final Rx<CourseDataEntity> _detailCourse = courseEmpty.obs;
  Rx<CourseDataEntity> get detailCourse => _detailCourse;

  final Rx<CoinEntity> _coin = coinEmpty.obs;
  Rx<CoinEntity> get coin => _coin;

  final Rx<String> _userId = ''.obs;
  Rx<String> get userId => _userId;

  final Rx<String> _userName = ''.obs;
  Rx<String> get userName => _userName;

  final Rx<String> _userEmail = ''.obs;
  Rx<String> get userEmail => _userEmail;

  final Rx<String> _userHp = ''.obs;
  Rx<String> get userHp => _userHp;

  final Rx<String> _token = ''.obs;
  Rx<String> get token => _token;

  final Rx<String> _version = ''.obs;
  Rx<String> get version => _version;

  final Rx<String> _errorMsgCoupon = ''.obs;
  Rx<String> get errorMsgCoupon => _errorMsgCoupon;

  final Rx<bool> _isUsingCoin = false.obs;
  Rx<bool> get isUsingCoin => _isUsingCoin;

  final Rx<bool> _isEditedTextField = false.obs;
  Rx<bool> get isEditedTextField => _isEditedTextField;

  final Rx<bool> _isUsingCoupon = false.obs;
  Rx<bool> get isUsingCoupon => _isUsingCoupon;

  final Rx<bool> _isHaveQueryCoupon = false.obs;
  Rx<bool> get isHaveQueryCoupon => _isHaveQueryCoupon;

  final Rx<bool> _isLoading = true.obs;
  Rx<bool> get isLoading => _isLoading;

  final Rx<bool> _isLoadingCoupon = false.obs;
  Rx<bool> get isLoadingCoupon => _isLoadingCoupon;

  final Rx<int> _initialCoin = 0.obs;
  Rx<int> get initialCoin => _initialCoin;

  final Rx<int> _maxCoin = 0.obs;
  Rx<int> get maxCoin => _maxCoin;

  final Rx<int> _price = 0.obs;
  Rx<int> get price => _price;

  final Rx<int> _randomNumber = 0.obs;
  Rx<int> get randomNumber => _randomNumber;

  final math.Random _random = math.Random();

  final Rx<CouponEntity> _couponDetail = emptyCoupon.obs;
  Rx<CouponEntity> get couponDetail => _couponDetail;

  final Rx<PaymentMethodEntity> _selectedPaymentMethod = emptyPaymentMethod.obs;
  Rx<PaymentMethodEntity> get selectedPaymentMethod => _selectedPaymentMethod;

  final RxList<PaymentMethodEntity> _paymentMethod =
      <PaymentMethodEntity>[].obs;
  RxList<PaymentMethodEntity> get paymentMethod => _paymentMethod;

  final RxList<String> _paymentMethodTitle = <String>[].obs;
  RxList<String> get paymentMethodTitle => _paymentMethodTitle;

  final TextEditingController _tcCoupon = TextEditingController();
  TextEditingController get tcCoupon => _tcCoupon;

  final TextEditingController _tcName = TextEditingController();
  TextEditingController get tcName => _tcName;

  final TextEditingController _tcEmail = TextEditingController();
  TextEditingController get tcEmail => _tcEmail;

  final TextEditingController _tcHp = TextEditingController();
  TextEditingController get tcHp => _tcHp;

  final Rx<WaitingOrderEntity> _waitingOrder = emptyWaitingOrder.obs;
  Rx<WaitingOrderEntity> get waitingOrder => _waitingOrder;

  final Rx<int> _orderId = 0.obs;
  Rx<int> get orderId => _orderId;

  late SharedPreferences _prefs;

  late ArkCheckoutUseCase _useCase;
  late ArkCheckoutRepository _repository;
  late ArkCheckoutRemoteDataSource _dataSource;

  @override
  void onInit() async {
    await _setup();
    await _changeLoading(false);
    super.onInit();
  }

  Future getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _version.value = packageInfo.version;
  }

  Future _changeLoading(bool val) async {
    _isLoading.value = val;
  }

  Future _changeLoadingCoupon(bool val) async {
    _isLoadingCoupon.value = val;
  }

  Future _setup() async {
    _dataSource = ArkCheckoutRemoteDataSourceImpl();
    _repository = ArkCheckoutRepositoryImpl(_dataSource);
    _useCase = ArkCheckoutUseCase(_repository);

    _generateRandomNumber();

    _prefs = await SharedPreferences.getInstance();
    _userId.value = _prefs.getString('user_id') ?? '';
    _token.value = _prefs.getString('token_access') ?? '';
    _userName.value = _prefs.getString('user_name') ?? '';
    _userHp.value = _prefs.getString('user_hp') ?? '';
    _userEmail.value = _prefs.getString('user_email') ?? '';

    _tcName.text = _userName.value;
    _tcEmail.text = _userEmail.value;
    _tcHp.text = _userHp.value;

    if (Get.arguments is Map<String, dynamic>) {
      _detailCourse.value = CourseDataDTO.fromJson(Get.arguments);
      _price.value = getPrice;
    }
    await getVersion();
  }

  Stream<CoinEntity> streamCoin() {
    return _useCase.streamCoin(_userId.value).map((event) {
      _coin.value = event;
      return _coin.value;
    });
  }

  Stream<List<PaymentMethodEntity>> streamPaymentMethod() {
    return _useCase.streamPaymentMethod().map((data) {
      _paymentMethod.value = data;
      _paymentMethodTitle.value = data.map((e) => e.titleType).toSet().toList();

      if (_paymentMethod[_paymentMethod.indexWhere((e) => e.chanel == "bacs")]
          .status) {
        _selectedPaymentMethod.value = _paymentMethod[
            _paymentMethod.indexWhere((e) => e.chanel == 'bacs')];
      }

      return _paymentMethod;
    });
  }

  void _generateRandomNumber() {
    _randomNumber.value = _random.nextInt(899) + 100;
  }

  void onChangeTextFieldCoupon(String query) {
    if (query.isEmpty) {
      _isHaveQueryCoupon.value = false;
      _couponDetail.value = emptyCoupon;
    } else {
      _isHaveQueryCoupon.value = true;
    }
  }

  Future checkCoupon() async {
    _changeLoadingCoupon(true);
    AppDialog.loadingDialog();
    final response = await _useCase.checkCoupon(_token.value, _tcCoupon.text);

    response.fold(

        ///IF RESPONSE IS ERROR
        (fail) {
      Get.back();
      ExceptionHandle.execute(fail);
      AppDialog.loadingFailed(title: "Gagal... silahkan coba lagi");
      Future.delayed(const Duration(milliseconds: 1500), () {
        Get.back();
      });
    },

        ///IF RESPONSE SUCCESS
        (data) {
      _couponDetail.value = data;
      Get.back();
      if (data.success) {
        _validasiCoupon();
      }
      if (!data.success) {
        _errorMsgCoupon.value = "Kupon salah";
      }
    });
    await _changeLoadingCoupon(true);
  }

  void removeCoupon() {
    _couponDetail.value = emptyCoupon;
    _isHaveQueryCoupon.value = false;
    _isUsingCoupon.value = false;
    _tcCoupon.clear();
  }

  void _validasiCoupon() {
    bool expired = false;
    DateTime? dateExpire;
    int usageLimit = int.parse(_couponDetail.value.data.usageLimit);
    int usageCount = int.parse(_couponDetail.value.data.usageCount);

    if (_couponDetail.value.data.dateExpires.contains("-")) {
      dateExpire =
          DateFormat('d-MMM-yy').parse(_couponDetail.value.data.dateExpires);
      expired = dateExpire.isBefore(DateTime.now());
    } else if (_couponDetail.value.data.dateExpires.isNotEmpty) {
      dateExpire = Timestamp.fromMillisecondsSinceEpoch(
              int.parse(_couponDetail.value.data.dateExpires) * 1000)
          .toDate();
      expired = dateExpire.isBefore(DateTime.now());
    }

    if (expired == true) {
      _errorMsgCoupon.value = "Kupon Kadaluarsa";
      AppDialog.loadingFailed(title: _errorMsgCoupon.value);
    } else if (usageLimit <= usageCount) {
      _errorMsgCoupon.value = "Kupon sudah habis digunakan";
      AppDialog.loadingFailed(title: _errorMsgCoupon.value);
    } else if (_couponDetail.value.data.usedBy.contains(_userId.value)) {
      _errorMsgCoupon.value = "Kupon sudah pernah digunakan";
      AppDialog.loadingFailed(title: _errorMsgCoupon.value);
    } else if (_couponDetail.value.data.productIds is String) {
      _errorMsgCoupon.value = "Kupon tidak bisa digunakan pada kelas ini";
      AppDialog.loadingFailed(title: _errorMsgCoupon.value);
    } else {
      _errorMsgCoupon.value = "";
      _isUsingCoupon.value = true;
      _isUsingCoin.value = false;
      AppDialog.loadingSuccess(title: "Kupon terverifikasi");
    }
    Future.delayed(const Duration(seconds: 2), () {
      Get.back();
    });
  }

  int get getPrice => int.parse(
        _detailCourse.value.salePrice == '0'
            ? _detailCourse.value.regularPrice
            : _detailCourse.value.salePrice,
      );

  void onSelectPayment(PaymentMethodEntity method) {
    _selectedPaymentMethod.value = method;
  }

  void fnChangeEdit() {
    isEditedTextField.value = !isEditedTextField.value;
  }

  void onSwitchCoin() {
    log(_detailCourse.value.coin.coinFlag);
    if (_detailCourse.value.coin.coinFlag == "1") {
      if (_coin.value.coins == 0) {
      } else if (isUsingCoupon.value) {
        ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(
          SnackBar(
            content: AppText.labelW600(
              'Koin tidak dapat digabungkan dengan kupon',
              13,
              Colors.white,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            backgroundColor: Colors.grey.shade800,
            duration: const Duration(seconds: 1),
          ),
        );
      } else {
        onUseCoin();
      }
    }
  }

  void onUseCoin() {
    _isUsingCoin.value = !_isUsingCoin.value;

    if (_isUsingCoin.value) {
      if (_coin.value.coins >= _price.value) {
        _maxCoin.value = _price.value;
        _selectedPaymentMethod.value = _paymentMethod[
            _paymentMethod.indexWhere((e) => e.chanel == "bacs")];
      } else {
        _maxCoin.value = _coin.value.coins;
      }
    }
  }

  Future order() async {
    double discCoupon = 0.0;
    String status = "on-hold";
    String title =
        "${selectedPaymentMethod.value.title} (App v${_version.value})";
    if (_isUsingCoupon.value) {
      title = "Kupon (App v${_version.value})";
      if (_couponDetail.value.data.discountType == "percent") {
        discCoupon = (double.parse(_couponDetail.value.data.amount) / 100) *
            _price.value;

        if (double.parse(_couponDetail.value.data.amount) == 100) {
          status = "completed";
        }
      } else {
        discCoupon = double.parse(_couponDetail.value.data.amount);
      }
    }

    if (_isUsingCoin.value && _maxCoin.value >= _price.value) {
      status = "completed";
    }

    final body = {
      "customer_id": _userId.value,
      "status": status,
      "billing": {
        "first_name": _tcName.text,
        "last_name": '',
        "email": _tcEmail.text,
        "phone": newFormatHp,
      },
      "payment_method": _selectedPaymentMethod.value.chanel,
      "payment_method_title": title,
      "line_items": [
        {
          "product_id": _detailCourse.value.productId,
          "quantity": 1,
          "sku": "-",
          "image_url": "https://arkademi.com",
        }
      ],
      "coupon_lines": [
        {
          "code": _isUsingCoupon.value ? _couponDetail.value.data.code : "",
          "discount": _isUsingCoupon.value ? discCoupon.toString() : "0",
        }
      ],
      "fee_lines": [
        {
          "name": "Diskon",
          "tax_status": "taxable",
          "amount": (-randomNumber.value).toString(),
          "total": (-randomNumber.value).toString()
        },
        {
          "name": "Flash Sale",
          "tax_status": "taxable",
          "amount": "0",
          "total": "0"
        },
        {
          "name": "Coins",
          "tax_status": "taxable",
          "amount": _isUsingCoin.value ? _maxCoin.value : 0,
          "total": _isUsingCoin.value ? _maxCoin.value : 0,
        }
      ],
      "cashback": _isUsingCoin.value || _isUsingCoupon.value
          ? 0
          : double.parse(_detailCourse.value.coinCashback).toInt(),
    };

    if (_selectedPaymentMethod.value.chanel == "xendit-ovo" &&
        (_tcHp.text.length < 11 || _tcHp.text.length > 13)) {
      AppDialog.loadingFailed(
        title: "Pembayaran OVO harus menggunakan nomor yang valid",
      );
      Future.delayed(const Duration(seconds: 2), () {
        Get.back();
      });
    } else {
      if (_isEditedTextField.value) {
        AppDialog.loadingFailed(title: "Silahkan simpan data yang diubah");
        Future.delayed(const Duration(seconds: 2), () {
          Get.back();
        });
      } else {
        final response = await _useCase.order(_token.value, body);
        response.fold((fail) {
          ExceptionHandle.execute(fail);
        }, (data) {
          _orderId.value = data;
          Get.toNamed(
            "/ark-waiting-order",
            arguments: [
              data,
              _selectedPaymentMethod.value,
              _isUsingCoin.value,
              _coin.value.coins,
              _maxCoin.value,
            ],
          );
        });
      }
    }
  }

  String get newFormatHp {
    if (_tcHp.text.isNotEmpty) {
      if (_tcHp.text[0] == "0") {
        return _tcHp.text.replaceFirst(r'0', '+62');
      } else {
        return "+62${_tcHp.text}";
      }
    } else {
      return '+62';
    }
  }
}
