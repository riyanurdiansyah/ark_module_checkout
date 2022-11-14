import 'package:flutter/material.dart';

class ErrorImageWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final double? iconSize;
  final Color? iconColor;
  final bool isImage;
  final Widget? child;
  const ErrorImageWidget({
    Key? key,
    this.child,
    this.height,
    this.width,
    this.iconColor,
    this.iconSize,
    required this.isImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 75,
      height: height ?? 75,
      child: Center(
        child: isImage == false
            ? Image.asset(
                'assets/images/logo-arkademi.png',
                fit: BoxFit.fill,
                color: Colors.blue,
              )
            : child,
      ),
    );
  }
}
