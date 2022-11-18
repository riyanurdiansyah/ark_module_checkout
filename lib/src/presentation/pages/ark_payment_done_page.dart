import 'package:ark_module_checkout/ark_module_checkout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ArkPaymentDonePage extends StatelessWidget {
  ArkPaymentDonePage({Key? key}) : super(key: key);

  final _checkoutC = Get.find<ArkCheckoutController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed("/main");
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
              Get.offAllNamed("/main");
            },
            child: const Icon(
              Icons.close,
              color: Colors.black,
            ),
          ),
          title: AppText.labelBold(
            "Pesanan Diterima",
            14,
            Colors.black,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 25,
              ),
              AppText.labelBold(
                "Rincian Pembayaran",
                18,
                Colors.black,
              ),
              const SizedBox(
                height: 18,
              ),
              AppText.labelNormal(
                "Nama Kelas",
                12,
                Colors.black,
              ),
              const SizedBox(
                height: 8,
              ),
              AppText.labelW600(
                _checkoutC.detailCourse.value.name,
                14,
                Colors.black,
              ),
              const SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText.labelNormal(
                    "Nomor Order",
                    12,
                    Colors.black,
                  ),
                  AppText.labelW700(
                    _checkoutC.orderId.value.toString(),
                    14,
                    Colors.black,
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText.labelNormal(
                    "Tanggal",
                    12,
                    Colors.black,
                  ),
                  AppText.labelW700(
                    DateFormat('yyyy-MM-dd').format(
                      DateTime.parse(
                        _checkoutC.waitingOrder.value.data.createdAt,
                      ),
                    ),
                    14,
                    Colors.black,
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText.labelNormal(
                    "Subtotal",
                    12,
                    Colors.black,
                  ),
                  _checkoutC.detailCourse.value.salePrice == '0'
                      ? AppText.labelW700(
                          currencyFormatter.format(int.parse(
                              _checkoutC.detailCourse.value.regularPrice)),
                          14,
                          Colors.black,
                        )
                      : AppText.labelW700(
                          currencyFormatter.format(int.parse(
                              _checkoutC.detailCourse.value.salePrice)),
                          14,
                          Colors.black,
                        )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText.labelNormal(
                    "Diskon",
                    12,
                    Colors.black,
                  ),
                  _checkoutC.waitingOrder.value.data.discountTotal == 0
                      ? _checkoutC.detailCourse.value.salePrice == '0'
                          ? AppText.labelW700(
                              currencyFormatter.format(int.parse(
                                  _checkoutC.detailCourse.value.regularPrice)),
                              14,
                              Colors.black,
                            )
                          : AppText.labelW700(
                              currencyFormatter.format(int.parse(
                                  _checkoutC.detailCourse.value.salePrice)),
                              14,
                              Colors.black,
                            )
                      : AppText.labelW700(
                          "-${currencyFormatter.format(_checkoutC.waitingOrder.value.data.discountTotal + _checkoutC.randomNumber.value)}",
                          14,
                          Colors.black,
                        )
                ],
              ),
              if (_checkoutC.isUsingCoin.value)
                const SizedBox(
                  height: 10,
                ),
              if (_checkoutC.isUsingCoin.value)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText.labelNormal(
                      "Arkademi Koin yang digunakan",
                      12,
                      Colors.black,
                    ),
                    AppText.labelW700(
                      "-${currencyFormatter.format(_checkoutC.maxCoin.value)}",
                      14,
                      Colors.black,
                    )
                  ],
                ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText.labelNormal(
                    "Total",
                    12,
                    Colors.black,
                  ),
                  AppText.labelW700(
                    numberFormat.format(int.parse(
                        _checkoutC.waitingOrder.value.data.orderTotal)),
                    14,
                    Colors.black,
                  )
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              AppText.labelBold(
                "Data Pembeli",
                18,
                Colors.black,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText.labelNormal(
                    "Nama Lengkap",
                    12,
                    Colors.black,
                  ),
                  AppText.labelW700(
                    _checkoutC.tcName.text,
                    12,
                    Colors.black,
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText.labelNormal(
                    "Alamat Email",
                    12,
                    Colors.black,
                  ),
                  AppText.labelW700(
                    _checkoutC.tcEmail.text,
                    12,
                    Colors.black,
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText.labelNormal(
                    "Nomor HP/WhatsApp",
                    12,
                    Colors.black,
                  ),
                  AppText.labelW700(
                    _checkoutC.tcHp.text,
                    12,
                    Colors.black,
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 3,
                width: Get.width,
                color: Colors.grey.shade300,
              ),
              const SizedBox(
                height: 25,
              ),
              AppText.labelBold(
                "Pelatihan Anda",
                18,
                Colors.black,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 80,
                    width: 80,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        _checkoutC.detailCourse.value.featuredImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: AppText.labelW700(
                      _checkoutC.detailCourse.value.name,
                      14,
                      Colors.black,
                      maxLines: 5,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(15),
          child: InkWell(
            onTap: () {
              Get.delete<ArkCheckoutController>();
              if (_checkoutC.detailCourse.value.courseFlag.jrc == '1') {
                Get.offNamed("/ark-course-jrc");
              } else {
                Get.offNamed("/ark-course");
              }
            },
            child: Container(
              alignment: Alignment.center,
              height: 45,
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF2C95EB),
                    Color(0xFF57B6F0),
                  ],
                ),
              ),
              child: AppText.labelBold(
                "MASUK PELATIHAN",
                14,
                Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
