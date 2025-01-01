import 'package:teacher_exam/app/launch/view.dart';
import 'package:teacher_exam/common/app_data.dart';
import 'package:teacher_exam/state.dart';
import 'package:teacher_exam/theme/my_theme.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';

import 'theme/light_theme.dart';

// 定义全局变量 theme 以便在 main 函数外也可以访问
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var appData = await LoginData.read();
  var findTheme =
      themeList.firstWhereOrNull((e) => e.name() == appData.themeName);
  theme = findTheme?.theme() ?? Light().theme();

  // 自定义字体设置
  final fontFamily = 'Microsoft YaHei UI'; // 确保已在 pubspec.yaml 中声明

  await message.init();

  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = WindowOptions(
    size: Size(1728, 972),
    minimumSize: Size(1728, 972),
    maximumSize: Size(1728, 972),
    skipTaskbar: false,
  );
  await windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: message,
      defaultTransition: Transition.noTransition,
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      title: '面试模拟系统教师端',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('zh'), // Chinese
      ],
      locale: const Locale('zh'),
      home: LaunchPage(),
    );
  }
}
