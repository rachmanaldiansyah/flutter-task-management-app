import 'dart:convert';
import 'dart:developer';

import 'package:flutter_task_management_app/dto/dto_detail_tasks.dart';
import 'package:flutter_task_management_app/dto/dto_msg_tasks.dart';
import 'package:flutter_task_management_app/screens/task_screen/task_controller.dart';
import 'package:flutter_task_management_app/utils/utils.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TaskService extends GetConnect {
  TaskController taskCtr = Get.put(TaskController());

  Future<DtoMsgTasks> createTasks({String? title, String? description}) async {
    try {
      taskCtr.isLoading.value = true;

      final uri = Uri.parse(AppConfig.createTask);
      final response = await http.post(
        uri,
        body: json.encode({
          "title": "${title ?? ""}",
          "description": "${description ?? ""}",
        }),
      );

      if (response.statusCode >= 200) {
        final data = json.decode(response.body);
        DtoMsgTasks dtoMsgTasks = DtoMsgTasks.fromJson(data);

        getMsgNotification("Success", "${dtoMsgTasks.message}");
        return DtoMsgTasks.fromJson(data);
      } else {
        getMsgNotification(
          "Error",
          "Error: ${response.statusCode} - ${response.body}",
        );

        log("Error: ${response.statusCode} - ${response.body}");
        return DtoMsgTasks.fromJson({});
      }
    } catch (e) {
      // Menangani error lain seperti koneksi
      getMsgNotification("Error", "Exception occurred: $e");

      log("Exception occurred: $e");
      return DtoMsgTasks.fromJson({});
    }
  }

  Future<DtoTaskDetail> getTaskDetail(int id) async {
    try {
      final uri = Uri.parse("${AppConfig.getTaskById}/${id}");
      final response = await http.get(uri, headers: HttpEx.headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        return DtoTaskDetail.fromJson(data);
      } else {
        getMsgNotification(
          "Error",
          "Error: ${response.statusCode} - ${response.body}",
        );

        log("Error: ${response.statusCode} - ${response.body}");
        return DtoTaskDetail.fromJson({});
      }
    } catch (e) {
      // Menangani error lain seperti koneksi
      getMsgNotification("Error", "Exception occurred: $e");

      log("Exception occurred: $e");
      return DtoTaskDetail.fromJson({});
    }
  }
}
