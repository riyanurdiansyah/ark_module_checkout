import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class AppDialog {
  static loadingDialog({String? title, bool? dissmiss}) {
    return Get.defaultDialog(
      radius: 8,
      onWillPop: () async => false,
      barrierDismissible: dissmiss ?? false,
      middleText: '',
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: Column(
        children: [
          const SizedBox(height: 25),
          Lottie.asset('assets/images/loading-animation.json',
              height: 100, width: 100),
          const SizedBox(height: 35),
          Text(
            title ?? 'Harap Tunggu',
            style: const TextStyle(
              fontSize: 16.5,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(28, 29, 32, 1),
            ),
          )
        ],
      ),
    );
  }

  static loadingFailed({String? title, bool? dissmiss}) {
    return Get.defaultDialog(
      onWillPop: () async => false,
      barrierDismissible: dissmiss ?? false,
      radius: 8,
      middleText: '',
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: Column(
        children: [
          const SizedBox(height: 25),
          Lottie.asset('assets/images/fail-animation.json',
              repeat: false, height: 100, width: 100),
          const SizedBox(height: 35),
          Text(
            title ?? 'Gagal!',
            style: const TextStyle(
              height: 1.4,
              fontSize: 16.5,
              color: Color.fromRGBO(28, 29, 32, 1),
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  static loadingSuccess({String? title, bool? dissmiss}) {
    return Get.defaultDialog(
      onWillPop: () async => false,
      barrierDismissible: dissmiss ?? false,
      radius: 8,
      middleText: '',
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: Column(
        children: [
          const SizedBox(height: 25),
          Lottie.asset('assets/images/success-animation.json',
              repeat: false, height: 100, width: 100),
          const SizedBox(height: 35),
          Text(
            title ?? 'Sukses!',
            style: const TextStyle(
              height: 1.4,
              fontSize: 16.5,
              color: Color.fromRGBO(28, 29, 32, 1),
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
