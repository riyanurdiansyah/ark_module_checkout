import 'package:ark_module_checkout/ark_module_checkout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArkWaitingOrderPage extends StatelessWidget {
  ArkWaitingOrderPage({Key? key}) : super(key: key);

  final waitingOrderC = Get.find<ArkWaitingOrderController>();

  static const List stepOvo = [
    'Buka aplikasi OVO',
    'Klik menu inbox di halaman utama',
    'Klik notifikasi konfirmasi pembayaran dari Arkademi Daya Indonesia',
    'Lakukan pembayaran sesuai dengan jumlah yang tertera'
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        body: Obx(
          () {
            if (waitingOrderC.isOvo.value) {
              return SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      color: const Color.fromRGBO(244, 245, 247, 1),
                      width: Get.width,
                      height: 40,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Selesaikan pembayaran Anda dalam',
                                style: TextStyle(
                                    color: Color.fromRGBO(62, 63, 67, 1),
                                    fontSize: 11.5)),
                            const SizedBox(width: 10),
                            Obx(() => waitingOrderC.timerOvo.value < 10
                                ? Text(
                                    '00:0${waitingOrderC.timerOvo.value}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.5),
                                  )
                                : Text(
                                    '00:${waitingOrderC.timerOvo.value}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.5),
                                  ))
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Image.asset(
                      'assets/images/waiting-order.png',
                      width: Get.width * 0.5,
                      height: Get.height * 0.15,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      child: Text(
                        'Notifikasi pembayaran berhasil di kirim\nke aplikasi OVO anda...',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1C1D20),
                          height: 1.4,
                        ),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText.labelW400(
                            'Total tagihan :',
                            13,
                            const Color.fromRGBO(62, 63, 67, 1),
                            maxLines: 2,
                          ),
                          const SizedBox(height: 14),
                          Obx(
                            () => AppText.labelW700(
                              currencyFormatter.format(int.parse(waitingOrderC
                                  .waitingOrder.value.data.orderTotal)),
                              16.5,
                              const Color.fromRGBO(62, 63, 67, 1),
                              maxLines: 2,
                            ),
                          ),
                          const SizedBox(height: 20),
                          AppText.labelW700(
                            'Cara melakukan pembayaran di OVO:',
                            13,
                            const Color.fromRGBO(62, 63, 67, 1),
                            maxLines: 2,
                          ),
                          const SizedBox(height: 14),
                          for (int i = 0; i < stepOvo.length; i++)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText.labelW400(
                                  '${i + 1}.',
                                  13,
                                  const Color.fromRGBO(62, 63, 67, 1),
                                  height: 1.4,
                                  maxLines: 2,
                                ),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: AppText.labelW400(
                                    i == 0 ? ' ${stepOvo[i]}' : '${stepOvo[i]}',
                                    13,
                                    const Color.fromRGBO(62, 63, 67, 1),
                                    height: 1.4,
                                    maxLines: 2,
                                  ),
                                )
                              ],
                            )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.offAllNamed("/main");
                        Future.delayed(const Duration(milliseconds: 100),
                            () => Get.toNamed("/historyTransactionPage"));
                      },
                      child: AppText.labelW600(
                        'Cek Status Pembayaran',
                        13,
                        const Color.fromRGBO(8, 114, 199, 1),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                    )
                  ],
                ),
              );
            }

            return SizedBox(
              width: Get.width,
              height: Get.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/waiting-order.png',
                    width: 264,
                    height: 173,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: AppText.labelW700(
                      'Transaksimu sedang diproses',
                      14,
                      const Color(0xFF1C1D20),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: AppText.labelW400(
                      'Sebentar ya...',
                      14,
                      maxLines: 2,
                      familiy: 'SourceSansPro',
                      const Color(0xFF333539),
                    ),
                  ),
                  Obx(
                    () {
                      if (waitingOrderC.isShowBackBtn.value) {
                        return Column(
                          children: [
                            const SizedBox(
                              height: 35,
                            ),
                            OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                color: Color.fromRGBO(8, 114, 199, 1),
                                width: 0.8,
                              )),
                              child: AppText.labelW600(
                                'Kembali',
                                12,
                                const Color.fromRGBO(8, 114, 199, 1),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
