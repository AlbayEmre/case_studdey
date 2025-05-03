import 'package:case_studdey/controller/detail_controller.dart';
import 'package:get/get.dart';

class DeatilBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailController>(() => DetailController(), fenix: false); // Sayfa bazlı kullanım için detail binding
  }
}
