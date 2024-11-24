import 'dart:convert';
import 'dart:developer';

import 'package:flutter_task_management_app/dto/dto_get_tasks.dart';
import 'package:flutter_task_management_app/screens/get_task_screen/get_task_controller.dart';
import 'package:flutter_task_management_app/utils/utils.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GetTaskService extends GetConnect {
  GetTaskController getTaskCtr = Get.put(GetTaskController());

  Future<DtoGetTasks> getTasks() async {
    try {
      getTaskCtr.isLoading.value = true;

      // Membuat URI dengan format yang benar
      final uri = Uri.parse(AppConfig.getTasks);
      final response = await http.get(uri, headers: HttpEx.headers);

      // Menangani response berdasarkan status
      if (response.statusCode == 200) {
        // Parse body menjadi JSON map sebelum diubah ke model DtoGetTasks
        final data = json.decode(response.body);
        return DtoGetTasks.fromJson(data);
      } else {
        getMsgNotification(
          "Error",
          "Error: ${response.statusCode} - ${response.body}",
        );

        log("Error: ${response.statusCode} - ${response.body}");
        return DtoGetTasks.fromJson({});
      }
    } catch (e) {
      // Menangani error lain seperti koneksi
      getMsgNotification("Error", "Exception occurred: $e");

      log("Exception occurred: $e");
      return DtoGetTasks.fromJson({});
    }
  }
}
