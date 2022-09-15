import 'package:dio/dio.dart';

import '../end_point.dart';

class DioHelper {

  static  late Dio dio;

  static init(){
    dio = Dio(
     BaseOptions(
       baseUrl: BASE_URL,
       receiveDataWhenStatusError: true,
     )
    );
  }

   static Future<Response>  getData({
    required String url,
     dynamic query,
     String lang = VALUE_LANG,
     String? token,
  }) async{

     dio.options.headers =
     {
       KEY_TYPE: VALUE_TYPE,
       KEY_LANG: lang,
       KEY_AUTHORIZATION: token ?? '',
     };
    return await dio.get(
      url,
      queryParameters: query
    );
  }


  static Future<Response>  postData({
    required String url,
     dynamic query,
    required dynamic data,
    String lang = VALUE_LANG,
    String? token,
  }) async{

    dio.options.headers =
    {
      KEY_TYPE: VALUE_TYPE,
      KEY_LANG: lang,
      KEY_AUTHORIZATION: token ?? '',
    };
    return await dio.post(
        url,
        data: data,
        queryParameters: query
    );
  }
}