import 'package:flutter/material.dart';
import 'package:flutter_task_management_app/utils/colors/app_colors.dart';
import 'package:flutter_task_management_app/widgets/button_widget.dart';
import 'package:flutter_task_management_app/widgets/textfield_widget.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController detailController = TextEditingController();

    return Scaffold(
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
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: AppColors.secondaryColor,
                  ),
                )
              ],
            ),
            Column(
              children: [
                TextFieldWidget(
                  hintText: "Task Name",
                  controller: nameController,
                  borderRadius: 15,
                  maxLines: 1,
                ),
                const SizedBox(height: 20),
                TextFieldWidget(
                  hintText: "Task Detail",
                  controller: detailController,
                  borderRadius: 15,
                  maxLines: 3,
                ),
                const SizedBox(height: 20),
                ButtonWidget(backgroundColor: AppColors.mainColor, text: "Add Task", textColor: Colors.white, onTap: () {  },),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 6)
          ],
        ),
      ),
    );
  }
}
