import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nanny_vanny/config/theme/app_colors.dart';
import 'package:nanny_vanny/view/dashboard.dart';

import 'controller/global_controller.dart';

void main() {
  Get.put(GlobalController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Nanny Vanny',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: AppColors.primaryPinkColor),
        useMaterial3: true,
      ),
      home: const DashboardScreen(),
    );
  }
}
