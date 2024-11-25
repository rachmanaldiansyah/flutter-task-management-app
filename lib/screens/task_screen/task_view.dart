import 'package:flutter/material.dart';
import 'package:flutter_task_management_app/screens/task_screen/task_controller.dart';
import 'package:get/get.dart';

import 'package:flutter_task_management_app/utils/colors/app_colors.dart';
import 'package:flutter_task_management_app/widgets/button_widget.dart';
import 'package:flutter_task_management_app/widgets/textfield_widget.dart';

class TaskScreenView extends StatefulWidget {
  final int id;
  final bool? isView;
  final bool? isEdit;

  const TaskScreenView({
    super.key,
    required this.id,
    this.isView,
    this.isEdit,
  });

  @override
  State<TaskScreenView> createState() => _TaskScreenViewState();
}

class _TaskScreenViewState extends State<TaskScreenView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  TaskController taskCtr = Get.put(TaskController());

  @override
  void initState() {
    super.initState();
    if (widget.isView == true) {
      Future.delayed(Duration.zero, () => taskCtr.getTaskDetail(widget.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/addtask1.jpg"),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(height: 60),
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: AppColors.secondaryColor,
                  ),
                )
              ],
            ),
            Obx(() {
              return Column(
                children: [
                  TextFieldWidget(
                    hintText: taskCtr.title.value,
                    controller: nameController,
                    borderRadius: 15,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 20),
                  TextFieldWidget(
                    hintText: taskCtr.description.value,
                    controller: detailController,
                    borderRadius: 15,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 20),
                  ButtonWidget(
                    backgroundColor: AppColors.mainColor,
                    text: widget.isView == true
                        ? "Back"
                        : widget.isView == true && widget.isEdit == true
                            ? "Update"
                            : "Save",
                    textColor: Colors.white,
                    onTap: widget.isView == true
                        ? () => Get.back()
                        : widget.isView == true && widget.isEdit == true
                            ? () {}
                            : () => taskCtr.createTasks(
                                  title: nameController.text,
                                  description: detailController.text,
                                ),
                  ),
                ],
              );
            }),
            Flexible(
              child: SizedBox(height: MediaQuery.of(context).size.height / 6),
            )
          ],
        ),
      ),
    );
  }
}
