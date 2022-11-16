import 'package:ark_module_checkout/ark_module_checkout.dart';
import 'package:ark_module_checkout/utils/app_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ArkFormBuyer extends StatelessWidget {
  ArkFormBuyer({Key? key}) : super(key: key);

  final _checkoutController = Get.find<ArkCheckoutController>();

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _checkoutController.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppText.labelW600(
                'Nama Lengkap ',
                11,
                const Color(0xFF1C1D20),
              ),
              AppText.labelW400(
                '(akan tampil di sertifikat)',
                11,
                const Color(0xFF1C1D20),
              ),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Obx(
            () => TextFormField(
              readOnly: !_checkoutController.isEditedTextField.value,
              controller: _checkoutController.tcName,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Color(0xFF75767A),
                fontSize: 12,
              ),
              decoration: InputDecoration(
                fillColor: const Color(0xFFC9CBCF).withOpacity(0.5),
                filled:
                    _checkoutController.isEditedTextField.value ? false : true,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                labelStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: MediaQuery.of(context).size.shortestSide < 600
                        ? 12
                        : 23),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).errorColor),
                    borderRadius: BorderRadius.circular(5)),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).errorColor),
                    borderRadius: BorderRadius.circular(5)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: _checkoutController.isEditedTextField.value
                          ? const Color.fromRGBO(8, 114, 199, 1)
                          : const Color.fromRGBO(198, 201, 207, 1),
                    ),
                    borderRadius: BorderRadius.circular(5)),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(198, 201, 207, 1)),
                    borderRadius: BorderRadius.circular(5)),
              ),
              validator: (value) => AppValidator.checkNama(value!),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          AppText.labelW600(
            'Email',
            11,
            const Color(0xFF1C1D20),
          ),
          const SizedBox(
            height: 4,
          ),
          Obx(
            () => TextFormField(
              readOnly:
                  _checkoutController.isEditedTextField.value ? false : true,
              controller: _checkoutController.tcEmail,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Color(0xFF75767A),
                fontSize: 12,
              ),
              decoration: InputDecoration(
                fillColor: const Color(0xFFC9CBCF).withOpacity(0.5),
                filled:
                    _checkoutController.isEditedTextField.value ? false : true,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                labelStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: MediaQuery.of(context).size.shortestSide < 600
                        ? 12
                        : 23),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).errorColor),
                    borderRadius: BorderRadius.circular(5)),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).errorColor),
                    borderRadius: BorderRadius.circular(5)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: _checkoutController.isEditedTextField.value
                            ? const Color.fromRGBO(8, 114, 199, 1)
                            : const Color.fromRGBO(198, 201, 207, 1)),
                    borderRadius: BorderRadius.circular(5)),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(198, 201, 207, 1)),
                    borderRadius: BorderRadius.circular(5)),
              ),
              validator: (value) => AppValidator.checkEmail(value!),
            ),
          ),
          const SizedBox(
            height: 35,
          ),
          Container(
            height: 4,
            color: const Color(0xFFF4F6F9),
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            children: [
              AppText.labelW600(
                'Nomor HP/WhatsApp',
                11,
                const Color(0xFF1C1D20),
              ),
              AppText.labelBold(
                '*',
                12,
                Colors.red,
              ),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          TextFormField(
            controller: _checkoutController.tcHp,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
              AppPhoneText(),
            ],
            style: TextStyle(
              fontSize: Get.size.shortestSide < 600 ? 14 : 25,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
              labelStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize:
                      MediaQuery.of(context).size.shortestSide < 600 ? 12 : 23),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).errorColor),
                  borderRadius: BorderRadius.circular(5)),
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).errorColor),
                  borderRadius: BorderRadius.circular(5)),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color.fromRGBO(8, 114, 199, 1)),
                  borderRadius: BorderRadius.circular(5)),
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color.fromRGBO(198, 201, 207, 1)),
                  borderRadius: BorderRadius.circular(5)),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}
