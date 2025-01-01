import 'dart:typed_data';
import 'package:teacher_exam/common/app_data.dart';
import 'package:teacher_exam/ex/ex_hint.dart';
import 'package:dio/dio.dart';

import 'config_util.dart';

class HttpUtil {
  static const authorization = "Authorization";

  static final dio = Dio(BaseOptions(
    baseUrl: ConfigUtil.httpPort == "" ? ConfigUtil.baseUrl : "${ConfigUtil.baseUrl}:${ConfigUtil.httpPort}",
    connectTimeout: const Duration(seconds: 40),
    receiveTimeout: const Duration(seconds: 40),
  ))
    ..interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        print(
            'Request [${options.method}] => PATH: ${options.path}, DATA: ${options.data}');
        return handler.next(options); // 调用下一步
      },
      onResponse: (response, handler) {
        return handler.next(response); // 调用下一步
      },
      onError: (DioError e, handler) {
        print('Error [${e.response?.statusCode}] => MESSAGE: ${e.message}');
        return handler.next(e); // 调用下一步
      },
    ));

  static Future<dynamic> get(String url,
      {Map<String, dynamic>? params, bool showMsg = true}) async {
    var map = await header();
    Response response = await dio.get(url,
        queryParameters: params, options: Options(headers: map));
    return verify(response.data, showMsg);
  }

  static Future<dynamic> post(String url,
      {Map<String, dynamic>? params, bool showMsg = true}) async {
    var map = await header();
    Response response = await dio.post(url,
        data: params,
        options: Options(contentType: Headers.jsonContentType, headers: map));
    return verify(response.data, showMsg);
  }

  static Future<dynamic> put(String url,
      {Map<String, dynamic>? params, bool showMsg = true}) async {
    var map = await header();
    Response response = await dio.put(url,
        data: params,
        options: Options(contentType: Headers.jsonContentType, headers: map));
    return verify(response.data, showMsg);
  }

  static Future<dynamic> delete(String url,
      {Map<String, dynamic>? params, bool showMsg = true}) async {
    var map = await header();
    Response response = await dio.delete(url,
        queryParameters: params, options: Options(headers: map));
    return verify(response.data, showMsg);
  }

  /// 全局请求头
  static Future<Map<String, dynamic>> header() async {
    var data = await LoginData.read();
    return {authorization: data.token};
  }

  /// 上传文件处理
  static Future<dynamic> uploadByte(String url, Uint8List file, String name,
      {bool showMsg = true,
      Function(int count, int total)? onSendProgress}) async {
    var map = await header();
    var formData = FormData.fromMap({
      "file": MultipartFile.fromBytes(file, filename: name),
    });
    Response response = await dio.post(url,
        data: formData,
        options: Options(headers: map),
        onSendProgress: onSendProgress);
    return verify(response.data, showMsg);
  }

  static Future<dynamic> uploadFile(String url, FormData formData,
      {bool showMsg = true,
      Function(int count, int total)? onSendProgress}) async {
    var map = await header(); // 假设 header() 是一个返回请求头的方法

    Response response = await dio.post(
      url,
      data: formData,
      options: Options(headers: map),
      onSendProgress: onSendProgress,
    );

    return verify(response.data, showMsg); // 假设 verify() 是一个验证响应的方法
  }

  /// 验证结果
  static dynamic verify(dynamic data, bool showMsg) {
    if (data["code"] == 0) {
      return data["data"];
    } else {
      if (showMsg) {
        data["msg"].toString().toHint();
      }
      return Future.error(data["msg"]);
    }
  }
}
