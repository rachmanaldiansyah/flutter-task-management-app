import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'colors/app_colors.dart';

final String baseUrl = "http://192.168.1.6:8080";

class AppConfig {
  static String getTasks = "$baseUrl/api/v1/tasks";
  static String getTaskById = "$baseUrl/api/v1/tasks/detail";
  static String createTask = "$baseUrl/api/v1/tasks/create";
  static String updateTask = "$baseUrl/api/v1/tasks/update";
  static String deleteTask = "$baseUrl/api/v1/tasks/delete";
}

class HttpEx {
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
}

class AppFonts {
  static const mainTitle = TextStyle(
    color: AppColors.mainColor,
    fontSize: 60,
    fontWeight: FontWeight.bold,
  );
  static const smallTitle = TextStyle(
    color: AppColors.smallTextColor,
    fontSize: 12,
  );
}

void getMsgNotification(String labelTitle, String labelMessage) {
  var validationBg = labelTitle == "Info"
      ? Colors.blueAccent
      : labelTitle == "Warning"
          ? Colors.deepOrangeAccent
          : labelTitle == "Success"
              ? Colors.green
              : Colors.redAccent;

  var validationIcon = labelTitle == "Info"
      ? Icons.info_outline_rounded
      : labelTitle == "Warning"
          ? Icons.warning_amber_rounded
          : labelTitle == "Success"
              ? Icons.check_circle_outline
              : Icons.dangerous_rounded;

  Get.snackbar(
    labelTitle,
    labelMessage,
    backgroundColor: validationBg,
    icon: Icon(validationIcon, color: Colors.white),
    colorText: Colors.white,
  );
}
