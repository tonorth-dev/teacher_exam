import 'package:teacher_exam/app/login/logic.dart';
import 'package:teacher_exam/app/login/view.dart';
import 'package:teacher_exam/common/app_data.dart';
import 'package:teacher_exam/ex/ex_anim.dart';
import 'package:teacher_exam/ex/ex_btn.dart';
import 'package:teacher_exam/ex/ex_hint.dart';
import 'package:teacher_exam/ex/ex_url.dart';
import 'package:teacher_exam/theme/theme_util.dart';
import 'package:teacher_exam/theme/ui_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class HeadLogic extends GetxController {
  final loginLogic = Get.put(LoginLogic());

  void logout() {
    loginLogic.logout();
    Get.offAll(() => LoginPage());
  }

  void clickHeadImage() {
    showDialog(
        context: Get.context!,
        barrierColor: Colors.transparent,
        builder: (context) {
          return Stack(
              children: [
                Positioned(
                  right: 10,
                  top: 55,
                  child: head(),
                ),
              ],
          );
        });
  }

  Widget head(){
    return Container(
      width: 200,
      decoration: UiTheme.decoration(),
      child: Column(
        children: [
          ThemeUtil.height(),
          "退出登录".toBtn(onTap: (){
            logout();
          }),
          ThemeUtil.height(),
        ],
      ),
    ).toFadeInWithMoveX(true);
  }

  Widget itemBtn(Icon icon, String text, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          icon,
        ],
      ),
    );
  }
}
