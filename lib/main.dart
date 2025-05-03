import 'package:case_studdey/routes/app_pages.dart';
import 'package:case_studdey/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.post, //Firs page
      getPages: AppPages.routes,
      defaultTransition: Transition.fade, //opsyonel
      theme: ThemeData.light(), //Aydınlık tema seçelim
    );
  }
}
