import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rs_task/model/hive_data_model/local_data_model.dart';
import 'package:rs_task/utils/exceptions/dio_exceptions.dart';

class GetDataService {
  Dio dio = Dio();
  Future<List<GetLocalDataModel>?> getDataService(context, page) async {
    try {
      final Response response = await dio.get(
          "https://api.github.com/users/JakeWharton/repos?page=$page&per_page=15");

      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.statusCode.toString());
        if (response.data == null) {
          return null;
        } else {
          final List<GetLocalDataModel> model = (response.data as List)
              .map((e) => GetLocalDataModel.fromJson(e))
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
