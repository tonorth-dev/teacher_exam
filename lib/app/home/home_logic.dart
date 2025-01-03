import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:teacher_exam/api/exam_api.dart';
import 'package:teacher_exam/ex/ex_hint.dart';

class HomeLogic extends GetxController {
  final RxList students = [].obs; // 动态绑定学生数据
  late StudentDataSource dataSource; // 数据源

  void pullExam() async {
    try {
      var data = await ExamApi.pullExam();
      if (data != null && data.isNotEmpty) {
        print("获取数据：$data");
        students.value = data['students']; // 更新学生数据
        dataSource = StudentDataSource(students); // 初始化数据源
        showStudentsDialog(); // 展示弹窗
      } else {
        '没有分配的试题'.toHint();
      }
    } catch (e) {
      print("Error in pullExam: $e");
      if (!e.toString().contains('登录已失效')) {
        '系统发生错误，没有抽取到试题'.toHint();
      }
    }
  }

  void startPractice(int studentId) {
    // 这里处理“开始练习”的逻辑
    print("开始练习，学生ID：$studentId");
    '学生ID $studentId 开始练习'.toHint();
  }

  void showStudentsDialog() {
    Get.defaultDialog(
      title: "考生信息",
      content: Container(
        width: 800, // 表格宽度
        height: 400, // 表格高度
        child: SfDataGrid(
          source: dataSource,
          columnWidthMode: ColumnWidthMode.fill,
          headerGridLinesVisibility: GridLinesVisibility.both,
          rowHeight: 50, // 行高
          gridLinesVisibility: GridLinesVisibility.both,
          columns: [
            GridColumn(
              columnName: 'name',
              label: Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                child: const Text(
                  '考生姓名',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            GridColumn(
              columnName: 'job',
              label: Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                child: const Text(
                  '职位',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            GridColumn(
              columnName: 'practiced',
              label: Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                child: const Text(
                  '已练习',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            GridColumn(
              columnName: 'notPracticed',
              label: Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                child: const Text(
                  '未练习',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            GridColumn(
              columnName: 'action',
              label: Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                child: const Text(
                  '操作',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StudentDataSource extends DataGridSource {
  List<DataGridRow> _rows = [];

  StudentDataSource(List students) {
    _rows = students.map<DataGridRow>((student) {
      return DataGridRow(cells: [
        DataGridCell(columnName: 'name', value: student['student_name']),
        DataGridCell(columnName: 'job', value: student['job_name']),
        DataGridCell(columnName: 'practiced', value: student['practiced_count']),
        DataGridCell(columnName: 'notPracticed', value: student['not_practiced_count']),
        DataGridCell(columnName: 'action', value: student['student_id']),
      ]);
    }).toList();
  }

  @override
  List<DataGridRow> get rows => _rows;

  @override
  Widget buildTableCell(DataGridCell cell, String columnName) {
    if (columnName == 'action') {
      return ElevatedButton(
        onPressed: () {
          final studentId = cell.value;
          print('开始练习：$studentId');
        },
        child: const Text("开始练习"),
      );
    }

    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.center,
      child: Text(cell.value.toString()),
    );
  }
}
