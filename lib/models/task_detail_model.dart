class TaskDetailView {
  String? status;
  String? message;
  TaskDetailViewData? data;

  TaskDetailView({
    this.status,
    this.message,
    this.data,
  });
}

class TaskDetailViewData {
  int? id;
  String? title;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;

  TaskDetailViewData({
    this.id,
    this.title,
    this.description,
    this.createdAt,
    this.updatedAt,
  });
}
