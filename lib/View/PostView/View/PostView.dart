import 'package:case_studdey/View/PostView/Widgets/CustomCard.dart';
import 'package:case_studdey/controller/post_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostView extends GetView<PostController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: kToolbarHeight * 1.5,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // Menü aç
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Image.asset(
              "assets/images/profile.png",
              width: 32,
              height: 32,
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: controller.searchController,
                decoration: InputDecoration(
                  fillColor: const Color.fromARGB(255, 250, 249, 249),
                  filled: true,
                  hintText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
                onChanged: (value) {
                  controller.searchPosts(value); //Dinamik filitreleme işlemi
                },
              ),
            ),
            SizedBox(height: 40),
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.categories.length,
                itemBuilder: (context, index) {
                  final category = controller.categories[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextButton(
                      onPressed: () {
                        controller.selectedCategory.value = category;
                        controller.filterByCategory();
                      },
                      child: Obx(() => Text(
                            category,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black.withOpacity(
                                category == controller.selectedCategory.value ? 1 : 0.5,
                              ),
                            ),
                          )),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: controller.filteredPosts.length,
                itemBuilder: (context, index) {
                  final post = controller.filteredPosts[index]; //filitelenmiş yoksa tüm postları getirir
                  return GestureDetector(
                      onTap: () {
                        Get.toNamed('/postDetail', arguments: post.id);
                      },
                      child: CustomCard(post: post));
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
