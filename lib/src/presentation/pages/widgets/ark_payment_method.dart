import 'package:ark_module_checkout/ark_module_checkout.dart';
import 'package:ark_module_checkout/src/domain/entities/payment_method_entity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArkPaymentMethod extends StatelessWidget {
  ArkPaymentMethod({Key? key, required this.isPreptest}) : super(key: key);

  final bool isPreptest;

  final _checkoutController = Get.find<ArkCheckoutController>();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<PaymentMethodEntity>>(
      stream: _checkoutController.streamPaymentMethod(),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              Column(
                children: List.generate(
                    _checkoutController.paymentMethodTitle.length, (index) {
                  List<PaymentMethodEntity> data = [];
                  if (isPreptest) {
                    data = snapshot.data!
                        .where((e) =>
                            e.titleType ==
                                _checkoutController.paymentMethodTitle[index] &&
                            e.chanel == 'bacs')
                        .toList();
                  } else {
                    data = snapshot.data!
                        .where((e) =>
                            e.titleType ==
                                _checkoutController.paymentMethodTitle[index] &&
                            e.status == true)
                        .toList();
                  }

                  return Column(
                    children: [
                      if (data.isNotEmpty)
                        Container(
                          alignment: Alignment.centerLeft,
                          width: Get.width,
                          height: 40,
                          margin: const EdgeInsets.symmetric(
                            vertical: 5,
                          ),
                          color: const Color(0xFFF6F7F9),
                          child: AppText.labelBold(
                            _checkoutController.paymentMethodTitle[index],
                            12,
                            const Color(
                              0xFF94969B,
                            ),
                          ),
                        ),
                      Column(
                        children: List.generate(
                          data.length,
                          (i) => Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                            ),
                            child: Column(
                              children: [
                                Obx(
                                  () => InkWell(
                                    onTap: () => _checkoutController
                                        .onSelectPayment(data[i]),
                                    child: Row(
                                      children: [
                                        Radio<int>(
                                          value: data[i].id,
                                          groupValue: _checkoutController
                                              .selectedPaymentMethod.value.id,
                                          onChanged: (val) =>
                                              _checkoutController
                                                  .onSelectPayment(data[i]),
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        SizedBox(
                                          width: 80,
                                          height: 40,
                                          child: Image.network(
                                            data[i].image,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              AppText.labelBold(
                                                data[i].title,
                                                14,
                                                Colors.black,
                                              ),
                                              AppText.labelNormal(
                                                data[i].description,
                                                10,
                                                Colors.black,
                                                maxLines: 5,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                if (!data[i].code.contains("SHOPEE") &&
                                    !data[i].code.contains("ATM"))
                                  Container(
                                    width: Get.width,
                                    height: 1,
                                    color: Colors.grey.shade200,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ],
          );
        } else {
          return const SizedBox();
        }
      }),
    );
  }
}
