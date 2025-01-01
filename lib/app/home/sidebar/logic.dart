
import 'package:teacher_exam/app/home/pages/empty/view.dart';

import 'package:teacher_exam/app/home/system/settings/view.dart';
import 'package:teacher_exam/ex/ex_int.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SidebarLogic extends GetxController {
  static var selectName = "".obs;
  var animName = "".obs;
  var expansionTile = <String>[].obs;

  /// 面包屑列表
  static var breadcrumbList = <SidebarTree>[].obs;

  static List<SidebarTree> treeList = [
  ];

  /// 面包屑和侧边栏联动
  static void selSidebarTree(SidebarTree sel) {
    if (breadcrumbList.isNotEmpty && breadcrumbList.last.name == sel.name) {
      return;
    }
    breadcrumbList.clear();
    32.toDelay(() {
      findSidebarTree(sel,treeList);
    });
  }

  /// 递归查找面包屑
  static bool findSidebarTree(SidebarTree sel, List<SidebarTree> list) {
    for (var item in list) {
      if (item.name == sel.name) {
        breadcrumbList.add(item);
        return true;
      }
      if (item.children.isNotEmpty) {
        /// 递归查找，当找到时，将当前节点插入到面包屑列表中，并返回true
        if (findSidebarTree(sel, item.children)) {
          breadcrumbList.insert(0, item);
          return true;
        }
      }
    }
    return false;
  }
}

class SidebarTree {
  final String name;
  final IconData icon;
  final List<SidebarTree> children;
  var isExpanded = false.obs;
  final Widget page;
  final Color color; // 正确添加 color 属性

  SidebarTree({
    required this.name,
    this.icon = Icons.ac_unit,
    this.children = const [],
    this.page = const EmptyPage(),
    Color? color, // 修改为可选参数
  }) : color = color ?? Colors.black; // 使用 ?? 运算符提供默认颜色
}


SidebarTree newThis(String name) {
  return SidebarTree(
    name: name,
    icon: Icons.supervised_user_circle,
    color: Colors.grey[600], // Set default color (optional)
  );
}
