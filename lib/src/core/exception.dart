/*
  ini kelas untuk custom exception
  jika terjadi error exception
*/
class CustomException implements Exception {
  int code;
  String message;
  CustomException(this.code, this.message);
}
