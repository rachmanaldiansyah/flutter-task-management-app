class TasksView {
  String? status;
  String? message;
  List<TasksViewData>? data;

  TasksView({
    this.status,
    this.message,
    this.data,
    });
}

class TasksViewData {
  int? id;
  String? title;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;

  TasksViewData({
    this.id,
    this.title,
    this.description,
    this.createdAt,
    this.updatedAt,
    });
}
