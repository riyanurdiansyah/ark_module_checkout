import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([List properties = const <dynamic>[]]) : super();
}

/*
  ini untuk handle message error
  jika terjadi error pada API
  atau status code yang tidak 200
*/
class HttpFailure extends Failure {
  final int code;
  final String message;

  const HttpFailure(
    this.code,
    this.message,
  );

  @override
  List<Object?> get props => [code, message];
}
