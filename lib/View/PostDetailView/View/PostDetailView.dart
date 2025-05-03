import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:case_studdey/controller/detail_controller.dart';
import 'package:lottie/lottie.dart';

class PostDetailView extends GetView<DetailController> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final post = controller.activePost.value;
        if (post == null) {
          return const Center(child: Text('Post bulunamadı')); // Eyer psot yoksa hata mesajı çıksın üstten
        }

        return Stack(
          children: [
            Container(
              height: size.height, // üst kısmın yüksekliği
              width: size.width,
              decoration: BoxDecoration(
                color: const Color(0xFFD5E4FF),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(32),
                ),
              ),
              child: Stack(
                children: [
                  // back ve menu icon
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          BackButton(color: Colors.black87),
                          Icon(Icons.menu, color: Colors.black87),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Lottie.asset(
                      'assets/lottie/animation.json', // Lottie animasyonu
                      width: size.width * .8,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: size.height * .70,
              left: 0,
              right: 0,
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  onPressed: controller.toggleReadMode,
                  child: const Text('Read All'),
                ),
              ),
            ),
            Obx(() {
              final readMode = controller.readMode.value;
              final topStart = size.height * .80; // Kart başlangıçta neredeyse en altta (ekranın %80’i)
              final topEnd = size.height * .10; // Read mode'da ekranın üst kısmına kadar çıkıyor (%10’u)

              return AnimatedPositioned(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
                top: readMode ? topEnd : topStart,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(32),
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 12,
                        color: Colors.black12,
                        offset: Offset(0, -4),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.title ?? '',
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          post.content ?? '',
                          style: const TextStyle(fontSize: 15, height: 1.4),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
            Obx(() => controller.readMode.value
                ? Positioned.fill(
                    child: GestureDetector(
                      onTap: controller.toggleReadMode, // kartı kapatır
                      child: Container(color: Colors.transparent),
                    ),
                  )
                : const SizedBox.shrink()),
          ],
        );
      }),
    );
  }
}
