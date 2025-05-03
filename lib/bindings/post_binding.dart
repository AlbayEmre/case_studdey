import 'package:case_studdey/controller/post_controller.dart';

import 'package:get/get.dart';

class PostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostController>(() => PostController(), fenix: false); //Sayfa bazlı kulanım için
  }
}
