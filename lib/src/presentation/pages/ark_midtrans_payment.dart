import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ArkMidtransPayment extends StatelessWidget {
  const ArkMidtransPayment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.close, color: Color.fromRGBO(28, 29, 32, 1)),
            onPressed: () => Get.offAllNamed("/main"),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "Checkout",
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        body: ListView(
          children: [
            SvgPicture.asset('assets/images/midtrans-payment.svg',
                width: double.infinity, height: Get.size.height * 0.38),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Terima kasih sudah membeli kelas!",
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: Get.size.shortestSide < 600 ? 18 : 28,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      "Jika belum melakukan pembayaran silahkan melakukan pembayaran sesuai dengan metode pembayaran yang sudah Kamu pilih dan ikuti pentunjuk pembayarannya.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: Get.size.shortestSide < 600 ? 14 : 24,
                      ),
                    ),
                  ),
                  Text(
                    "Untuk melihat petunjuk pembayaran silahkan cek email yang Kamu gunakan pada saat pembelian.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: Get.size.shortestSide < 600 ? 14 : 24),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      "Jika sudah melakukan pembayaran silahkan langsung masuk ke kelas dan mulai belajar dengan cara menekan tombol KEMBALI KE KELAS dibawah ini",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: Get.size.shortestSide < 600 ? 14 : 24,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                          side: const BorderSide(
                              color: Color.fromRGBO(8, 114, 199, 1), width: 1),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      onPressed: () {
                        Get.back();
                        Get.back();
                      },
                      child: const Text(
                        "MASUK KELAS",
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: Color.fromRGBO(8, 114, 199, 1),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                          side: const BorderSide(
                              color: Color.fromRGBO(8, 114, 199, 1), width: 1),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      onPressed: () => Get.offAllNamed("/main"),
                      child: const Text(
                        "KEMBALI KE DEPAN",
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: Color.fromRGBO(8, 114, 199, 1),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
