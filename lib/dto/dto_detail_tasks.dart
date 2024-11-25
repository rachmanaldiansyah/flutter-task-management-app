import 'dart:convert';

DtoTaskDetail dtoTaskDetailFromJson(String str) =>
    DtoTaskDetail.fromJson(json.decode(str));

String dtoTaskDetailToJson(DtoTaskDetail data) => json.encode(data.toJson());

class DtoTaskDetail {
  String? status;
  String? message;
  DtoTaskDetailData? data;

  DtoTaskDetail({
    this.status,
    this.message,
    this.data,
  });

  factory DtoTaskDetail.fromJson(Map<String, dynamic> json) => DtoTaskDetail(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : DtoTaskDetailData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class DtoTaskDetailData {
  int? id;
  String? title;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;

  DtoTaskDetailData({
    this.id,
    this.title,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory DtoTaskDetailData.fromJson(Map<String, dynamic> json) =>
      DtoTaskDetailData(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
