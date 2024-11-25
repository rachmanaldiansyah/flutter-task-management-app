import 'package:flutter_task_management_app/dto/dto_get_tasks.dart';
import 'package:flutter_task_management_app/models/task_model.dart';
import 'package:flutter_task_management_app/screens/get_task_screen/get_task_service.dart';
import 'package:flutter_task_management_app/utils/utils.dart';
import 'package:get/get.dart';

class GetTaskController extends GetxController {
  RxInt totalData = 0.obs;
  RxBool isLoading = false.obs;
  TasksView? taskList;

  Future<void> getTasks() async {
    try {
      DtoGetTasks? dtoGetTasks =
          await GetTaskService().getTasks().whenComplete(() => Future.delayed(
                Duration(seconds: 3),
                () => isLoading.value = false,
              ));

      taskList = TasksView(
        status: dtoGetTasks.status,
        message: dtoGetTasks.message,
        data: dtoGetTasks.data
            .map((e) => TasksViewData(
                  id: e.id,
                  title: e.title,
                  description: e.description,
                  createdAt: e.createdAt,
                  updatedAt: e.updatedAt,
                ))
            .toList(),
      );

      if (taskList != null) totalData.value = taskList?.data?.length ?? 0;
    } catch (e) {
      getMsgNotification("Error", "Error occurred: $e");
    }
  }
}
