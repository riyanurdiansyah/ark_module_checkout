import 'dart:developer';

import 'package:ark_module_checkout/ark_module_checkout.dart';
import 'package:ark_module_setup/ark_module_setup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArkCheckoutController extends GetxController {
  final Rx<CourseDataEntity> _detailCourse = CourseDataEntity(
    categories: const [],
    status: "",
    averageRating: "",
    courseSlug: "",
    description: "",
    descriptionInstruktur: "",
    enableFaceRecog: 0,
    featuredImage: "",
    id: 0,
    iosPrice: "0",
    name: "",
    price: "0",
    regularPrice: "0",
    salePrice: "0",
    totalStudents: 0,
    instructor: const InstructorEntity(
        id: "", name: "", avatar: AvatarEntity(url: ""), sub: ""),
    coinCashback: "0",
    discount: 0.0,
    courseFlag: CourseFlagEntity(
        whatsapp: "", prakerja: "", revamp: "", jrc: "", group: ""),
    mpLinks: const [],
    peluangKarir: const [],
    ratingCount: "",
    lowongan: LowonganEntity(
      id: 0,
      courseId: "",
      categoryJob: "",
      endDateLowongan: DateTime.now(),
      startDateLowongan: DateTime.now(),
      gajiMax: "",
      gajiMin: "",
      jumlahLowongan: "0",
      reference: "",
    ),
    ygAkanDipelajariWeb: const [],
  ).obs;
  Rx<CourseDataEntity> get detailCourse => _detailCourse;

  final Rx<CoinEntity> _coin = CoinEntity(
    coins: 0,
    isCompleted: false,
    createdAt: Timestamp.now(),
    updatedAt: Timestamp.now(),
    isOldUser: false,
  ).obs;
  Rx<CoinEntity> get coin => _coin;

  final Rx<String> _userId = ''.obs;
  Rx<String> get userId => _userId;

  final Rx<bool> _isUsingCoin = false.obs;
  Rx<bool> get isUsingCoin => _isUsingCoin;

  final Rx<bool> _isLoading = true.obs;
  Rx<bool> get isLoading => _isLoading;

  final Rx<int> _initialCoin = 0.obs;
  Rx<int> get initialCoin => _initialCoin;

  late SharedPreferences _prefs;

  late ArkCheckoutUseCase _useCase;
  late ArkCheckoutRepository _repository;
  late ArkCheckoutRemoteDataSource _dataSource;

  @override
  void onInit() async {
    _changeLoading(true);
    await _setup();
    // await _changeLoading(false);
    super.onInit();
  }

  Future _changeLoading(bool val) async {
    _isLoading.value = val;
  }

  Future _setup() async {
    _dataSource = ArkCheckoutRemoteDataSourceImpl();
    _repository = ArkCheckoutRepositoryImpl(_dataSource);
    _useCase = ArkCheckoutUseCase(_repository);

    _prefs = await SharedPreferences.getInstance();
    _userId.value = _prefs.getString('user_id') ?? '';

    log("CHEK ID : ${_userId.value}");

    if (Get.arguments is CourseDataEntity) {
      _detailCourse.value = Get.arguments;
    }
  }

  Stream<CoinEntity> streamCoin() {
    return _useCase.streamCoin(_userId.value).map((event) {
      _coin.value = event;
      return _coin.value;
    });
  }
}
