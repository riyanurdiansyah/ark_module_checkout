import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

NumberFormat numberFormat = NumberFormat.decimalPattern('id');

final currencyFormatter = NumberFormat.currency(
  locale: "id_ID",
  symbol: "Rp ",
  decimalDigits: 0,
);

Options dioOptions({
  Map<String, dynamic>? headers,
}) {
  return Options(
    followRedirects: false,
    validateStatus: (status) => true,
    headers: headers ?? {},
  );
}
