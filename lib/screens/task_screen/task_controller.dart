import 'package:flutter_task_management_app/dto/dto_detail_tasks.dart';
import 'package:flutter_task_management_app/dto/dto_msg_tasks.dart';
import 'package:flutter_task_management_app/models/task_detail_model.dart';
import 'package:flutter_task_management_app/models/task_msg_model.dart';
import 'package:flutter_task_management_app/screens/get_task_screen/get_task_view.dart';
import 'package:flutter_task_management_app/screens/task_screen/task_service.dart';
import 'package:flutter_task_management_app/utils/utils.dart';
import 'package:get/get.dart';

class TaskController extends GetxController {
  RxBool isLoading = false.obs;
  RxString title = "Task Name".obs;
  RxString description = "Task Description".obs;
  TaskMsgView? taskMsgView;
  TaskDetailView? taskDetail;

  Future<void> getTaskDetail(int id) async {
    try {
      DtoTaskDetail? dtoTaskDetail = await TaskService().getTaskDetail(id);

      taskDetail = TaskDetailView(
        status: dtoTaskDetail.status,
        message: dtoTaskDetail.message,
        data: TaskDetailViewData(
          id: dtoTaskDetail.data?.id,
          title: dtoTaskDetail.data?.title,
          description: dtoTaskDetail.data?.description,
          createdAt: dtoTaskDetail.data?.createdAt,
          updatedAt: dtoTaskDetail.data?.updatedAt,
        ),
      );

      if (taskDetail?.data != null) {
        title.value = taskDetail?.data?.title ?? "";
        description.value = taskDetail?.data?.description ?? "";
      }
    } catch (e) {
      getMsgNotification("Error", "Error occurred: $e");
    }
  }

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

    if (isLoading.value == false) Get.to(() => GetTaskScreenView());
  }

  Future<void> updateTasks(int id, {String? title, String? description}) async {
    DtoMsgTasks? dtoMsgTasks = await TaskService()
        .updateTasks(id, title: title, description: description)
        .whenComplete(() => Future.delayed(
              Duration(seconds: 3),
              () => isLoading.value = false,
            ));

    taskMsgView = TaskMsgView(
      status: dtoMsgTasks.status,
      message: dtoMsgTasks.message,
    );

    if (isLoading.value == false) Get.to(() => GetTaskScreenView());
  }
}
