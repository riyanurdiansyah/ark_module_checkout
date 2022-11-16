import 'package:ark_module_checkout/ark_module_checkout.dart';
import 'package:ark_module_checkout/src/domain/entities/course_coin_entity.dart';
import 'package:ark_module_checkout/src/domain/entities/payment_method_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final PaymentMethodEntity emptyPaymentMethod = PaymentMethodEntity(
  chanel: '',
  code: '',
  description: '',
  id: 99,
  image: '',
  limit: 0,
  status: false,
  tipe: 0,
  title: '',
  titleType: '',
);

final CouponEntity emptyCoupon = CouponEntity(
  success: false,
  data: CouponDataEntity(
    id: -1,
    code: "",
    amount: "",
    discountType: "",
    description: "",
    dateExpires: "",
    usageCount: "",
    individualUse: "",
    productIds: [],
    usageLimit: "",
    usageLimitPerUser: "",
    limitUsageToXItems: "",
    freeShipping: "",
    excludeSaleItems: "",
    minimumAmount: "",
    maximumAmount: "",
    usedBy: [],
  ),
);

final CourseDataEntity courseEmpty = CourseDataEntity(
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
  coin: CourseCoinEntity(
    coinFlag: "1",
    coinDescription: "",
    coinValue: "",
  ),
);

final CoinEntity coinEmpty = CoinEntity(
  coins: 0,
  isCompleted: false,
  createdAt: Timestamp.now(),
  updatedAt: Timestamp.now(),
  isOldUser: false,
);
