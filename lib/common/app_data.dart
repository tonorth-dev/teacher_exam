import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class LoginData {
  String token = "";
  String themeName = "";
  String role = "";
  String user = "";
  DateTime? expiryDate;

  // toJson
  String toJson() {
    return jsonEncode({
      "token": token,
      "themeName": themeName,
      "expiryDate": expiryDate != null ? DateFormat('yyyy-MM-dd HH:mm:ss').format(expiryDate!) : null,
    });
  }

  // fromJson
  static LoginData fromJson(Map<String, dynamic> map) {
    var data = LoginData();
    data.token = map["token"] ?? "";
    data.themeName = map["themeName"] ?? "";
    if (map["expiryDate"] != null) {
      data.expiryDate = DateFormat('yyyy-MM-dd HH:mm:ss').parse(map["expiryDate"]);
    }
    return data;
  }

  static String saveKey = "app_data";

  static Future<LoginData> read() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString(saveKey);
    if (data == null || !await _isDataValid(data)) {
      return LoginData();
    }
    return LoginData.fromJson(jsonDecode(data));
  }

  // 检查数据是否有效（未过期）
  static Future<bool> _isDataValid(String jsonData) async {
    Map<String, dynamic> map = jsonDecode(jsonData);
    LoginData loginData = LoginData.fromJson(map);

    if (loginData.expiryDate == null) {
      return false;
    }

    final now = DateTime.now();
    return loginData.expiryDate!.isAfter(now);
  }

  // 设置过期时间为一天后
  void setExpiryToTomorrow() {
    expiryDate = DateTime.now().add(Duration(days: 1));
  }

  // 保存数据
  Future<void> save() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(saveKey, toJson());
  }

  /// 更简单的数据保存
  static Future<void> easySave(Function(LoginData) dg) async {
    var data = await read();
    dg(data);
    // 确保每次保存前都设置新的过期时间
    data.setExpiryToTomorrow();
    await data.save();
  }
}