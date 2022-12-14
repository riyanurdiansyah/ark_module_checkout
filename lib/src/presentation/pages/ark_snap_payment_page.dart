import 'package:ark_module_checkout/src/presentation/pages/ark_payment_done_page.dart';
import 'package:ark_module_checkout/utils/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
            WebView(
              onPageStarted: (_) {
                isLoading.value = false;
              },
              initialUrl: url,
              javascriptMode: JavascriptMode.unrestricted,
              navigationDelegate: (NavigationRequest request) async {
                if (request.url.contains('gojek://')) {
                  launchUrl(Uri.parse(request.url),
                      mode: LaunchMode.externalApplication);
                  return NavigationDecision.prevent;
                } else if (request.url.contains('gojek')) {
                  Get.off(() => ArkPaymentDonePage());
                  launchUrl(Uri.parse(request.url),
                      mode: LaunchMode.externalApplication);
                  return NavigationDecision.prevent;
                } else if (request.url.contains('shopee')) {
                  Get.off(() => ArkPaymentDonePage());
                  launchUrl(Uri.parse(request.url),
                      mode: LaunchMode.externalApplication);
                  return NavigationDecision.prevent;
                } else if (request.url
                    .contains('https://arkademi.com/?order_id=')) {
                  Get.offNamed("/ark-midtrans-payment");
                  return NavigationDecision.prevent;
                } else if (request.url.contains('https://arkademi.com')) {
                  Get.offNamed("/ark-midtrans-payment");
                  return NavigationDecision.prevent;
                } else if (request.url.contains('http://example.com')) {
                  Get.offNamed("/ark-midtrans-payment");
                  return NavigationDecision.prevent;
                } else if (request.url.contains('http://example.com')) {
                  // AppPrint.debugPrint('blocking navigation to $request}');
                  // Get.off(() => MidtransPayment(isPrepTest: isPrepTest));
                  Get.offNamed("/ark-midtrans-payment");
                  return NavigationDecision.prevent;
                } else {
                  return NavigationDecision.navigate;
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
