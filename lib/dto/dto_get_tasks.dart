import 'dart:convert';

DtoGetTasks dtoGetTasksFromJson(String str) =>
    DtoGetTasks.fromJson(json.decode(str));

String dtoGetTasksToJson(DtoGetTasks data) => json.encode(data.toJson());

class DtoGetTasks {
  String status;
  String message;
  List<DtoGetTasksData> data;

  DtoGetTasks({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DtoGetTasks.fromJson(Map<String, dynamic> json) {
    return DtoGetTasks(
      status: json["status"] ?? '',
      message: json["message"] ?? '',
      data: (json["data"] as List<dynamic>?)
              ?.map((x) => DtoGetTasksData.fromJson(x))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DtoGetTasksData {
  int id;
  String title;
  String description;
  DateTime? createdAt;
  DateTime? updatedAt;

  DtoGetTasksData({
    required this.id,
    required this.title,
    required this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory DtoGetTasksData.fromJson(Map<String, dynamic> json) {
    return DtoGetTasksData(
      id: json["id"] ?? 0,
      title: json["title"] ?? '',
      description: json["description"] ?? '',
      createdAt: json["created_at"] != null
          ? DateTime.tryParse(json["created_at"])
          : null,
      updatedAt: json["updated_at"] != null
          ? DateTime.tryParse(json["updated_at"])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
