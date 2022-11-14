import 'package:flutter/cupertino.dart';

class AppText {
  static labelNormal(
    String title,
    double fontSize,
    Color colors, {
    String? familiy,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    double? height,
  }) {
    return Text(
      title,
      textAlign: textAlign ?? TextAlign.start,
      overflow: overflow,
      maxLines: maxLines ?? 1,
      style: TextStyle(
        fontWeight: FontWeight.normal,
        fontFamily: familiy ?? 'Montserrat',
        fontSize: fontSize,
        color: colors,
        height: height ?? 1.0,
      ),
    );
  }

  static labelW400(
    String title,
    double fontSize,
    Color colors, {
    String? familiy,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    double? height,
    FontStyle? fontStyle,
  }) {
    return Text(
      title,
      textAlign: textAlign ?? TextAlign.start,
      overflow: overflow,
      maxLines: maxLines ?? 1,
      style: TextStyle(
          fontWeight: FontWeight.w400,
          fontFamily: familiy ?? 'Montserrat',
          fontSize: fontSize,
          color: colors,
          fontStyle: fontStyle ?? FontStyle.normal,
          height: height ?? 1.0),
    );
  }

  static labelW500(String title, double fontSize, Color colors,
      {String? familiy,
      TextAlign? textAlign,
      TextOverflow? overflow,
      int? maxLines,
      FontStyle? fontStyle,
      bool? softWarp}) {
    return Text(
      title,
      textAlign: textAlign ?? TextAlign.start,
      overflow: overflow,
      maxLines: maxLines ?? 1,
      softWrap: softWarp,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontFamily: familiy ?? 'Montserrat',
        fontSize: fontSize,
        color: colors,
        fontStyle: fontStyle ?? FontStyle.normal,
      ),
    );
  }

  static labelW600(
    String title,
    double fontSize,
    Color colors, {
    String? familiy,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    double? height,
    FontStyle? fontStyle,
  }) {
    return Text(
      title,
      textAlign: textAlign ?? TextAlign.start,
      overflow: overflow,
      maxLines: maxLines ?? 1,
      style: TextStyle(
          fontWeight: FontWeight.w600,
          fontFamily: familiy ?? 'Montserrat',
          fontSize: fontSize,
          color: colors,
          fontStyle: fontStyle ?? FontStyle.normal,
          height: height ?? 1.0),
    );
  }

  static labelW700(
    String title,
    double fontSize,
    Color colors, {
    String? familiy,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    double? height,
  }) {
    return Text(
      title,
      textAlign: textAlign ?? TextAlign.start,
      overflow: overflow,
      maxLines: maxLines ?? 1,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontFamily: familiy ?? 'Montserrat',
        fontSize: fontSize,
        color: colors,
        height: height ?? 1.0,
      ),
    );
  }

  static labelW800(
    String title,
    double fontSize,
    Color colors, {
    String? familiy,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
  }) {
    return Text(
      title,
      textAlign: textAlign ?? TextAlign.start,
      overflow: overflow,
      maxLines: maxLines ?? 1,
      style: TextStyle(
        fontWeight: FontWeight.w800,
        fontFamily: familiy ?? 'Montserrat',
        fontSize: fontSize,
        color: colors,
      ),
    );
  }

  static labelW900(
    String title,
    double fontSize,
    Color colors, {
    String? familiy,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
  }) {
    return Text(
      title,
      textAlign: textAlign ?? TextAlign.start,
      overflow: overflow,
      maxLines: maxLines ?? 1,
      style: TextStyle(
        fontWeight: FontWeight.w900,
        fontFamily: familiy ?? 'Montserrat',
        fontSize: fontSize,
        color: colors,
      ),
    );
  }

  static labelBold(
    String title,
    double fontSize,
    Color colors, {
    String? familiy,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
  }) {
    return Text(
      title,
      textAlign: textAlign ?? TextAlign.start,
      overflow: overflow,
      maxLines: maxLines ?? 1,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: familiy ?? 'Montserrat',
        fontSize: fontSize,
        color: colors,
      ),
    );
  }
}
