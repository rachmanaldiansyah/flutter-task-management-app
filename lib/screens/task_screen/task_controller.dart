import 'package:flutter_task_management_app/dto/dto_msg_tasks.dart';
import 'package:flutter_task_management_app/models/task_msg_model.dart';
import 'package:flutter_task_management_app/screens/get_task_screen/get_task_view.dart';
import 'package:flutter_task_management_app/screens/task_screen/task_service.dart';
import 'package:get/get.dart';

class TaskController extends GetxController {
  int? totalData;
  RxBool isLoading = false.obs;
  TaskMsgView? taskMsgView;

  Future<void> createTasks({String? title, String? description}) async {
    DtoMsgTasks? dtoMsgTasks = await TaskService()
        .createTasks(title: title, description: description)
        .whenComplete(() => Future.delayed(
              Duration(seconds: 3),
              () => isLoading.value = false,
            ));

    taskMsgView = TaskMsgView(
      status: dtoMsgTasks.status,
      message: dtoMsgTasks.message,
    );

    Get.to(() => GetTaskScreenView());
  }
}
