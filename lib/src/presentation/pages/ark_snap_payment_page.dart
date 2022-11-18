import 'dart:developer';

import 'package:ark_module_checkout/src/presentation/pages/ark_payment_done_page.dart';
import 'package:ark_module_checkout/utils/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ArkSnapPaymentPage extends StatelessWidget {
  const ArkSnapPaymentPage({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    var isLoading = true.obs;
    var progress = 0.obs;

    return WillPopScope(
      onWillPop: () async {
        Get.off(() => ArkPaymentDonePage());
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.close, color: Colors.black),
            onPressed: () => Get.off(() => ArkPaymentDonePage()),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text("Checkout", style: Theme.of(context).textTheme.headline1),
        ),
        body: Stack(
          children: [
            InAppWebView(
              initialUrlRequest: URLRequest(url: Uri.parse(url)),
              onProgressChanged: (_, prog) {
                progress.value = prog;
                if (prog == 100) {
                  isLoading.value = false;
                }
                log("PROGRESS : $prog");
              },
              shouldOverrideUrlLoading: (_, nav) async {
                var uri = nav.request.url;
                log("URL : ${uri!.host}");
                if (uri.host.contains('gojek://') ||
                    uri.host.contains('shopee')) {
                  launchUrl(uri);
                }
              },
              onWebViewCreated: (controller) {},
              onLoadStart: (controller, uri) {
                log("URL : ${uri!.host}");
                if (uri.host.contains('gojek://') ||
                    uri.host.contains('shopee')) {
                  launchUrl(uri);
                }
              },
              onLoadStop: (_, uri) async {
                log("URL : ${uri!.host}");
                if (uri.host.contains('gojek://') ||
                    uri.host.contains('shopee')) {
                  launchUrl(uri);
                }
              },
            ),
            Obx(() {
              if (isLoading.value) {
                return SizedBox(
                  width: Get.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(
                        strokeWidth: 0.8,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AppText.labelW500(
                        "$progress %",
                        12.5,
                        Colors.grey.shade400,
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox();
            })
          ],
        ),
      ),
    );
  }
}
