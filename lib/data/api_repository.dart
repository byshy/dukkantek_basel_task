import 'package:dio/dio.dart';

import '../models/core/error_res.dart';
import '../models/user.dart';

class ApiRepo {
  final Dio client;

  ApiRepo({required this.client});

  Future<User> login({required Map<String, dynamic> data}) async {
    if (data['mobile'] == '0560000001') {
      RequestOptions _requestOptions = RequestOptions(path: client.options.baseUrl);

      throw DioError(
        type: DioErrorType.response,
        requestOptions: _requestOptions,
        response: Response(
          data: ErrorResponse(
            status: 401,
            message: 'Test error',
          ).toJson(),
          requestOptions: _requestOptions,
        ),
      );
    }

    Response response = await client.get('4eb00486-a52c-467d-bd40-f430b4cf949b');

    print('response: ${response.data.toString()}');

    return User.fromJson(response.data);
  }
}
