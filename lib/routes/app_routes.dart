import 'package:case_studdey/View/PostDetailView/View/PostDetailView.dart';
import 'package:case_studdey/View/PostView/View/PostView.dart';
import 'package:case_studdey/bindings/deatil_binding.dart';
import 'package:case_studdey/bindings/post_binding.dart';
import 'package:case_studdey/routes/app_pages.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.post,
      page: () => PostView(),
      binding: PostBinding(),
    ),
    GetPage(
      name: AppRoutes.postDetail,
      page: () => PostDetailView(),
      binding: DeatilBinding(), // Bu sayfa açıldığında controller'ı lazily (gerektiğinde) enjekte eder
    ),
  ];
}
