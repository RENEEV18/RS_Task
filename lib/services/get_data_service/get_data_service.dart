import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rs_task/common/api/api_base_url.dart';
import 'package:rs_task/model/get_data_model/get_data_model.dart';
import 'package:rs_task/utils/exceptions/dio_exceptions.dart';

class GetDataService {
  Dio dio = Dio();
  Future<List<GetDataModel>?> getDataService(context) async {
    try {
      final Response response = await dio.get(ApiBaseUrl.baseUrl);
      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.statusCode.toString());
        if (response.data == null) {
          return null;
        } else {
          final List<GetDataModel> model = (response.data as List)
              .map((e) => GetDataModel.fromJson(e))
              .toList();
          log(response.data.toString());
          log(model.toString());
          return model;
        }
      }
    } on DioError catch (e) {
      log(e.message.toString());
      DioExceptions().dioError(e, context);
    }
    return null;
  }
}
