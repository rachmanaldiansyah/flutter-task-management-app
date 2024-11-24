import 'dart:convert';

DtoMsgTasks DtoMsgTasksFromJson(String str) =>
    DtoMsgTasks.fromJson(json.decode(str));

String DtoMsgTasksToJson(DtoMsgTasks data) => json.encode(data.toJson());

class DtoMsgTasks {
  String? status;
  String? message;

  DtoMsgTasks({
    this.status,
    this.message,
  });

  factory DtoMsgTasks.fromJson(Map<String, dynamic> json) => DtoMsgTasks(
        status: json["status"] ?? "",
        message: json["message"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
