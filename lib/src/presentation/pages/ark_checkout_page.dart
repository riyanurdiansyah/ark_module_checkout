import 'package:ark_module_checkout/ark_module_checkout.dart';
import 'package:ark_module_checkout/utils/app_empty_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ArkCheckoutPage extends StatelessWidget {
  ArkCheckoutPage({Key? key}) : super(key: key);

  final _checkoutC = Get.find<ArkCheckoutController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F5),
      appBar: AppBar(
        titleSpacing: 0,
        title: const Text(
          'Checkout',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: Colors.white,
          ),
        ),
        centerTitle: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              colors: [
                Color(0xFF139DD6),
                Color(0xFF0977BE),
              ],
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "Pesanan Anda",
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 80,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Obx(
                      () {
                        if (_checkoutC.isLoading.value) {
                          return AppShimmer.loadImage(null, 80);
                        }

                        return CachedNetworkImage(
                          imageUrl: _checkoutC.detailCourse.value.featuredImage,
                          fit: BoxFit.fill,
                          errorWidget: (_, __, ___) =>
                              const ErrorImageWidget(isImage: false),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                flex: 6,
                child: Container(
                  alignment: Alignment.center,
                  height: 80,
                  child: Obx(
                    () {
                      if (_checkoutC.isLoading.value) {
                        return AppShimmer.loadImage(null, 80);
                      }
                      return Text(
                        _checkoutC.detailCourse.value.name,
                        maxLines: 3,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w700,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Harga",
                style: TextStyle(
                  fontSize: 13,
                  color: Color(
                    0xFF838589,
                  ),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Obx(
                () => Text(
                  currencyFormatter.format(_checkoutC.price.value),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Obx(
            () {
              if ((_checkoutC.isUsingCoupon.value &&
                      double.parse(_checkoutC.couponDetail.value.data.amount) ==
                          100 &&
                      _checkoutC.couponDetail.value.data.discountType ==
                          "percent") ||
                  (_checkoutC.isUsingCoin.value &&
                      _checkoutC.maxCoin >= _checkoutC.price.value)) {
                return const SizedBox();
              }
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color(0xFFD6F6D2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/svg/disc.svg',
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        AppText.labelW500(
                          'Diskon',
                          12,
                          const Color(
                            0xFF6B9673,
                          ),
                        ),
                      ],
                    ),
                    AppText.labelW500(
                      ' -Rp ${_checkoutC.randomNumber}',
                      13,
                      const Color(
                        0xFF08A524,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.labelBold(
                "Total",
                16,
                const Color(
                  0xFF838589,
                ),
              ),
              Obx(() {
                if (_checkoutC.isUsingCoin.value &&
                    _checkoutC.maxCoin.value >= _checkoutC.price.value) {
                  return const Text(
                    "Rp 0",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  );
                }

                if (_checkoutC.isUsingCoin.value) {
                  return Text(
                    currencyFormatter.format(
                      _checkoutC.price.value - _checkoutC.maxCoin.value,
                    ),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  );
                }

                if (_checkoutC.isUsingCoupon.value &&
                    double.parse(_checkoutC.couponDetail.value.data.amount) ==
                        100 &&
                    _checkoutC.couponDetail.value.data.discountType ==
                        "percent") {
                  return const Text(
                    "Rp 0",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  );
                }

                if (_checkoutC.isUsingCoupon.value &&
                    _checkoutC.couponDetail.value.data.discountType ==
                        "percent") {
                  return Text(
                    currencyFormatter.format(
                      _checkoutC.price.value -
                          ((double.parse(_checkoutC
                                          .couponDetail.value.data.amount)
                                      .toInt() /
                                  100) *
                              _checkoutC.price.value),
                    ),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  );
                }

                if (_checkoutC.isUsingCoin.value) {
                  return Text(
                    currencyFormatter.format(
                      _checkoutC.price.value -
                          double.parse(
                              _checkoutC.couponDetail.value.data.amount),
                    ),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  );
                }
                return Text(
                  currencyFormatter.format(
                      _checkoutC.price.value - _checkoutC.randomNumber.value),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 18,
                  ),
                );
              })
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          AppText.labelW800(
            'Punya kupon?',
            15,
            const Color(
              0xFF333539,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Obx(
            () => Row(
              children: [
                Flexible(
                  flex: 9,
                  child: SizedBox(
                    height: 40,
                    child: TextFormField(
                      readOnly: _checkoutC.isUsingCoupon.value,
                      controller: _checkoutC.tcCoupon,
                      inputFormatters: [
                        AppUpperCaseTxt(),
                      ],
                      style: TextStyle(
                          fontSize:
                              MediaQuery.of(context).size.shortestSide < 600
                                  ? 14
                                  : 20),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        hintText: "Kode kupon",
                        hintStyle: const TextStyle(
                            fontSize: 14,
                            color: Color.fromRGBO(28, 29, 32, 0.45)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(13, 89, 159, 0.6),
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(13, 89, 159, 0.6),
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      onChanged: (query) =>
                          _checkoutC.onChangeTextFieldCoupon(query),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Obx(
                  () => TextButton(
                    onPressed: !_checkoutC.isHaveQueryCoupon.value
                        ? null
                        : () {
                            if (_checkoutC.isUsingCoupon.value) {
                              _checkoutC.removeCoupon();
                            } else {
                              _checkoutC.checkCoupon();
                            }
                          },
                    child: Text(
                      _checkoutC.isUsingCoupon.value ? 'Hapus' : 'Pakai',
                      style: TextStyle(
                        fontSize: 12,
                        color: _checkoutC.tcCoupon.text.isEmpty
                            ? Colors.grey
                            : const Color(
                                0xFF1B91D9,
                              ),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Obx(() {
            if (_checkoutC.couponDetail.value != emptyCoupon) {
              return Row(
                children: [
                  if (_checkoutC.isUsingCoin.value)
                    Image.asset(
                      'assets/images/new_check_green.png',
                      height: 16,
                      width: 16,
                    ),
                  if (!_checkoutC.couponDetail.value.success &&
                      _checkoutC.errorMsgCoupon.value.isNotEmpty)
                    const Icon(
                      Icons.cancel,
                      size: 16,
                      color: Color.fromRGBO(232, 30, 55, 1),
                    ),
                  const SizedBox(width: 6),
                  Text(
                    _checkoutC.isUsingCoupon.value
                        ? "Kupon Terverivikasi"
                        : _checkoutC.errorMsgCoupon.value,
                    style: TextStyle(
                      fontFamily: 'SourceSansPro',
                      fontWeight: FontWeight.w600,
                      color: _checkoutC.isUsingCoupon.value
                          ? const Color.fromRGBO(12, 182, 42, 1)
                          : const Color.fromRGBO(232, 30, 55, 1),
                      fontSize: Get.size.shortestSide < 600 ? 16 : 21,
                    ),
                  ),
                ],
              );
            }

            return const SizedBox();
          }),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
      bottomNavigationBar: Obx(
        () => BottomAppBar(
          elevation: 12,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (!_checkoutC.isLoading.value)
                StreamBuilder<CoinEntity>(
                  stream: _checkoutC.streamCoin(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        child: Row(
                          children: [
                            Image.asset('assets/images/coins.png', height: 30),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Gunakan Arkademi Koin",
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700)),
                                const SizedBox(height: 5),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${numberFormat.format(_checkoutC.coin.value.coins)} Koin",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    GestureDetector(
                                      onTap: () {},
                                      child: const Icon(
                                        Icons.info_outline,
                                        size: 15,
                                        color: Color.fromRGBO(
                                          205,
                                          206,
                                          210,
                                          1,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const Spacer(),
                            Obx(
                              () => CupertinoSwitch(
                                value: _checkoutC.isUsingCoin.value,
                                onChanged: (value) {
                                  // if (_lcC.detailClass.value.data![0].course!
                                  //             .coin ==
                                  //         null ||
                                  //     _lcC.detailClass.value.data![0].course!.coin!
                                  //             .coinFlag ==
                                  //         "1") {
                                  //   if (snapshot.data?.coins == 0) {
                                  //   } else if (_checkoutC
                                  //       .isUseCoupon.isTrue) {
                                  //     ScaffoldMessenger.of(context).showSnackBar(
                                  //         AppSnackbar.defaultSnackbar(
                                  //             'Koin tidak dapat digabungkan dengan kupon'));
                                  //   } else {
                                  //     _checkoutC.changeUseCoin(
                                  //         value,
                                  //         snapshot.data?.coins,
                                  //         int.parse(widget.priceFromWebview == null
                                  //             ? tempPrice!
                                  //             : widget.priceFromWebview!));
                                  //   }
                                  // } else {
                                  //   ScaffoldMessenger.of(context).showSnackBar(
                                  //       AppSnackbar.defaultSnackbar(
                                  //           'Koin tidak dapat digunakan pada kelas ini'));
                                  // }
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return const SizedBox();
                  },
                ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
