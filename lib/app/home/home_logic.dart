import 'package:get/get.dart';
import 'package:teacher_exam/api/exam_api.dart';
import 'package:teacher_exam/ex/ex_hint.dart';


class HomeLogic extends GetxController {

  void pullExam() async {
    try {
      var data = await ExamApi.pullExam();
      if (data.isNotEmpty) {
        print("获取数据：$data");
      } else {
        '没有分配的试题'.toHint();
      }
    } catch (e) {
      '系统发生错误，没有抽取到试题'.toHint();
    }
  }

}
