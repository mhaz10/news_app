import 'package:dio/dio.dart';
import 'package:news_app/shared/components/constants.dart';

class DioHelper  {

  static Dio? dio;

  static init () {
    dio = Dio(
      BaseOptions(baseUrl: baseUrl, receiveDataWhenStatusError: true),
    );
  }

  static Future<Response> getData ({required String url, required Map<String, dynamic> query}) async {
    return await dio!.get(
      url, queryParameters: query
    );
  }
}