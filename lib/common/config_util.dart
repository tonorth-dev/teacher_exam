import 'dart:typed_data';
import 'package:teacher_exam/common/app_data.dart';
import 'package:teacher_exam/ex/ex_hint.dart';
import 'package:dio/dio.dart';

class ConfigUtil {
  static const String baseUrl = "https://admin.81hongshi.com";
  // static const String baseUrl = "http://127.0.0.1";
  static const String httpPort = "";
  static const String ossUrl = "http://123.56.83.210"; // todo 暂时使用ip
  static const String ossPort = "9000";
  static const String ossPrefix = "/hongshi";
}
