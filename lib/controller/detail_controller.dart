// lib/controllers/detail_controller.dart
import 'package:get/get.dart';
import 'package:case_studdey/model/post_model.dart';
import '../services/post_service.dart';

class DetailController extends GetxController {
  // UI ile paylaşılan durumlar ——
  final activePost = Rxn<Post>(); // Seçilen post
  final isLoading = false.obs; // Progress göstergesi
  final readMode = false.obs; // “Read All” -> true / false

  final ApiService _api = ApiService();

  @override
  void onInit() {
    super.onInit();
    final id = Get.arguments as int?; // navigator’dan gelen ID
    if (id == null) {
      Get.snackbar('Hata', 'Geçersiz post kimliği gönderildi.');
    } else {
      _fetchPost(id);
    }
  }

  /// Belirli bir postu ID ile getirir
  Future<void> _fetchPost(int id) async {
    isLoading.value = true;
    try {
      final data = await _api.getPostById(id);

      // Sunucu beklenmedik bir şey (HTML / String vs.) dönerse:
      if (data is! Map<String, dynamic>) {
        throw Exception('Sunucu JSON yerine ${data.runtimeType} döndürdü.');
      }

      activePost.value = Post.fromJson(data);
    } catch (e) {
      Get.snackbar('Post alınamadı', e.toString()); //Eğer hata alırsak snackbar ile gösterir burda mesela veri yok
    } finally {
      isLoading.value = false;
    }
  }

  /// Okuma modunu açar / kapatır
  void toggleReadMode() => readMode.toggle(); //toggle true/false yapar
}
