import 'package:intl/intl.dart';

NumberFormat numberFormat = NumberFormat.decimalPattern('id');

final currencyFormatter = NumberFormat.currency(
  locale: "id_ID",
  symbol: "Rp ",
  decimalDigits: 0,
);
