import 'dart:math';

import 'package:ark_module_checkout/ark_module_checkout.dart';
import 'package:ark_module_checkout/src/core/exception_handling.dart';
import 'package:ark_module_checkout/utils/app_dialog.dart';
import 'package:ark_module_checkout/utils/app_empty_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArkCheckoutController extends GetxController {
  final Rx<CourseDataEntity> _detailCourse = courseEmpty.obs;
  Rx<CourseDataEntity> get detailCourse => _detailCourse;

  final Rx<CoinEntity> _coin = coinEmpty.obs;
  Rx<CoinEntity> get coin => _coin;

  final Rx<String> _userId = ''.obs;
  Rx<String> get userId => _userId;

  final Rx<String> _token = ''.obs;
  Rx<String> get token => _token;

  final Rx<String> _errorMsgCoupon = ''.obs;
  Rx<String> get errorMsgCoupon => _errorMsgCoupon;

  final Rx<bool> _isUsingCoin = false.obs;
  Rx<bool> get isUsingCoin => _isUsingCoin;

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

  final Random _random = Random();

  final Rx<CouponEntity> _couponDetail = emptyCoupon.obs;
  Rx<CouponEntity> get couponDetail => _couponDetail;

  final TextEditingController _tcCoupon = TextEditingController();
  TextEditingController get tcCoupon => _tcCoupon;

  late SharedPreferences _prefs;

  late ArkCheckoutUseCase _useCase;
  late ArkCheckoutRepository _repository;
  late ArkCheckoutRemoteDataSource _dataSource;

  @override
  void onInit() async {
    _changeLoading(true);
    await _setup();
    await _changeLoading(false);
    super.onInit();
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

    if (Get.arguments is Map<String, dynamic>) {
      _detailCourse.value = CourseDataDTO.fromJson(Get.arguments);
      _price.value = getPrice;
    }
  }

  Stream<CoinEntity> streamCoin() {
    return _useCase.streamCoin(_userId.value).map((event) {
      _coin.value = event;
      return _coin.value;
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
}
