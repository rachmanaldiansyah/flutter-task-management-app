import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_task_management_app/screens/all_task_screen.dart';
import 'package:flutter_task_management_app/screens/task_screen.dart';
import 'package:flutter_task_management_app/utils/colors/app_colors.dart';
import 'package:flutter_task_management_app/utils/utils.dart';
import 'package:flutter_task_management_app/widgets/button_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/welcome.jpg"),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: const TextSpan(
                text: "Hello",
                style: AppFonts.mainTitle,
                children: [
                  TextSpan(
                    text: "\nstart your beautiful day",
                    style: AppFonts.smallTitle,
                  )
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 2.5),
            ButtonWidget(
              text: "Add Task",
              textColor: Colors.white,
              backgroundColor: AppColors.mainColor,
              onTap: () => Get.to(
                () => const TaskScreen(),
                transition: Transition.fade,
                duration: const Duration(seconds: 1),
              ),
            ),
            const SizedBox(height: 20),
            ButtonWidget(
              text: "View All",
              textColor: AppColors.mainColor,
              backgroundColor: Colors.white,
              onTap: () => Get.to(
                () => const AllTasksScreen(),
                transition: Transition.fade,
                duration: const Duration(seconds: 1),
              ),
            )
          ],
        ),
      ),
    );
  }
}
