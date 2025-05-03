import 'package:case_studdey/services/post_service.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:case_studdey/model/post_model.dart';

class PostController extends GetxController {
  final posts = <Post>[].obs; // Tüm postlar
  final filteredPosts = <Post>[].obs; // Filtrelenmiş postlar (arama ve kategori)
  final categories = <String>[].obs; // Gelen verdeki kaç katogori var bilmiyoruz burda tutulacak
  final searchQuery = ''.obs;

  final isLoading = false.obs;
  final searchController = TextEditingController();

  final ApiService _apiService = ApiService();

  var selectedCategory = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  /// Postları getirir ve hem ana hem filtre listelerine atar
  Future<void> fetchPosts() async {
    isLoading.value = true;
    try {
      List<dynamic> data = await _apiService.getPosts();

      final loadedPosts = data.map((json) => Post.fromJson(json)).toList();

      posts.assignAll(loadedPosts);
      filteredPosts.assignAll(loadedPosts);

      // Kategorileri çıkar
      List<String> unique = loadedPosts.map((p) => p.category ?? "").toSet().toList(); //tekrar eden katogorileri kaldır
      categories.assignAll(unique);
    } catch (e) {
      print('Postlar alınamadı: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Başlığa göre arama yapar
  void searchPosts(String query) {
    searchQuery.value = query;

    if (query.isEmpty) {
      filteredPosts.assignAll(posts);
    } else {
      filteredPosts.assignAll(
        posts.where((post) => post.title?.toLowerCase().contains(query.toLowerCase()) ?? false),
      );
    }
  }

  /// Kategoriye göre filtreler (örneğin dropdown veya butonla)
  void filterByCategory() {
    final selected = selectedCategory.value;

    if (selected.isEmpty) {
      filteredPosts.assignAll(posts);
    } else {
      filteredPosts.assignAll(
        posts.where((post) => post.category == selected),
      );
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
