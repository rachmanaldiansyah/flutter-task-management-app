import 'package:flutter/material.dart';
import 'package:flutter_task_management_app/screens/get_task_screen/get_task_controller.dart';
import 'package:flutter_task_management_app/screens/task_screen/task_controller.dart';
import 'package:get/get.dart';

import 'package:flutter_task_management_app/screens/home_screen/home_view.dart';
import 'package:flutter_task_management_app/screens/task_screen/task_view.dart';
import 'package:flutter_task_management_app/utils/colors/app_colors.dart';
import 'package:flutter_task_management_app/widgets/button_widget.dart';
import 'package:flutter_task_management_app/widgets/task_widget.dart';

class GetTaskScreenView extends StatefulWidget {
  const GetTaskScreenView({super.key});

  @override
  State<GetTaskScreenView> createState() => _GetTaskScreenViewState();
}

class _GetTaskScreenViewState extends State<GetTaskScreenView> {
  final GetTaskController getTaskCtr = Get.put(GetTaskController());
  final TaskController taskCtr = Get.put(TaskController());

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => getTaskCtr.getTasks());
  }

  final leftEditIcon = Container(
    margin: const EdgeInsets.only(bottom: 10),
    color: const Color(0xFf2e3253).withOpacity(0.5),
    alignment: Alignment.centerLeft,
    child: const Icon(Icons.edit, color: Colors.white),
  );

  final rightDeleteIcon = Container(
    margin: const EdgeInsets.only(bottom: 10),
    color: Colors.redAccent,
    alignment: Alignment.centerRight,
    child: const Icon(Icons.delete, color: Colors.white),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20, top: 60),
              alignment: Alignment.topLeft,
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height / 3.2,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/header1.jpg"),
                ),
              ),
              child: IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppColors.secondaryColor,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Get.to(
                      () => const HomeScreenView(),
                      transition: Transition.fade,
                      duration: const Duration(seconds: 1),
                    ),
                    icon:
                        const Icon(Icons.home, color: AppColors.secondaryColor),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.5),
                      color: Colors.black54,
                    ),
                    child: Center(
                      child: IconButton(
                        onPressed: () => Get.to(
                          () => const TaskScreenView(id: 0),
                          transition: Transition.fade,
                          duration: Duration(seconds: 1),
                        ),
                        icon: const Icon(Icons.add,
                            color: Colors.white, size: 20),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                  const Icon(
                    Icons.calendar_month_rounded,
                    color: AppColors.secondaryColor,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "${getTaskCtr.totalData.value}",
                    style: TextStyle(
                      fontSize: 20,
                      color: AppColors.secondaryColor,
                    ),
                  )
                ],
              ),
            ),
            Flexible(
              child: getTaskCtr.isLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : getTaskCtr.totalData.value == 0
                      ? Text("Data Kosong")
                      : ListView.builder(
                          itemCount: getTaskCtr.taskList?.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            return Dismissible(
                              background: leftEditIcon,
                              secondaryBackground: rightDeleteIcon,
                              // onDismissed: (DismissDirection direction) async => true,
                              confirmDismiss:
                                  (DismissDirection direction) async {
                                var taskId =
                                    getTaskCtr.taskList?.data?[index].id ?? 0;

                                return direction == DismissDirection.startToEnd
                                    ? Future.delayed(Duration.zero, () {
                                        editModalWidget(
                                          context,
                                          taskId: taskId,
                                        );
                                        return false;
                                      })
                                    : Future.delayed(
                                        const Duration(seconds: 1),
                                        () {
                                          direction ==
                                              DismissDirection.endToStart;

                                          taskCtr.deleteTasks(taskId);
                                          return;
                                        },
                                      );
                              },
                              key: ObjectKey(index),
                              child: Container(
                                margin: const EdgeInsets.only(
                                    right: 20, left: 20, bottom: 10),
                                child: TaskWidget(
                                  text:
                                      getTaskCtr.taskList?.data?[index].title ??
                                          "-",
                                  color: Colors.blueGrey,
                                ),
                              ),
                            );
                          }),
            ),
          ],
        );
      }),
    );
  }

  Future<void> editModalWidget(BuildContext context, {int? taskId}) {
    return showModalBottomSheet(
      barrierColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (_) {
        return Container(
          height: MediaQuery.of(context).size.height / 2.8,
          decoration: BoxDecoration(
            color: const Color(0xFf2e3253).withOpacity(0.4),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonWidget(
                  text: "View",
                  textColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  onTap: () => Get.off(
                    () => TaskScreenView(id: taskId ?? 0, isView: true),
                  ),
                ),
                const SizedBox(height: 10),
                ButtonWidget(
                  text: "Edit",
                  textColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  onTap: () => Get.off(
                    () => TaskScreenView(id: taskId ?? 0, isEdit: true),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
