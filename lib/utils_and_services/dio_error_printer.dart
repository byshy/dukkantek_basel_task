import 'dart:developer';

import 'package:dio/dio.dart';

void printDioError(DioError e, String callingMethod) {
  log(
    'type: ${e.type.toString()}\nmessage: ${e.message}\data: ${e.response?.data.toString()}',
    name: 'DioError in $callingMethod',
  );
}
