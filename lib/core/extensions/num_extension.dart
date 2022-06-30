import 'package:intl/intl.dart';

extension NumExtension on num {
  String formatRupiah() {
    return NumberFormat.simpleCurrency(locale: 'id_ID', decimalDigits: 0).format(this);
  }
}