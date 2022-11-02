import 'package:ark_module_checkout/ark_module_checkout.dart';
import 'package:ark_module_setup/ark_module_setup.dart';
import 'package:ark_module_setup/utils/app_shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                  currencyFormatter.format(int.parse(
                      _checkoutC.detailCourse.value.salePrice == '0'
                          ? _checkoutC.detailCourse.value.regularPrice
                          : _checkoutC.detailCourse.value.salePrice)),
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
                                  //   } else if (_checkoutController
                                  //       .isUseCoupon.isTrue) {
                                  //     ScaffoldMessenger.of(context).showSnackBar(
                                  //         AppSnackbar.defaultSnackbar(
                                  //             'Koin tidak dapat digabungkan dengan kupon'));
                                  //   } else {
                                  //     _checkoutController.changeUseCoin(
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
              AppText.labelW800(
                'Punya kupon?',
                15,
                const Color(
                  0xFF333539,
                ),
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
