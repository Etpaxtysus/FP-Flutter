import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/controllers/news_controller.dart';
import 'package:myapp/pages/app/news_detail_page.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final NewsController newsController = Get.put(NewsController());
    final ScrollController scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        print('Bottom of the list reached, loading more news');
        newsController.fetchNews();
      }
    });

    return Obx(() {
      if (newsController.isLoading.value && newsController.newsList.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      if (newsController.newsList.isEmpty) {
        return const Center(child: Text("No news available."));
      }

      return ListView.builder(
        controller: scrollController,
        itemCount: newsController.newsList.length,
        itemBuilder: (context, index) {
          final news = newsController.newsList[index];

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              leading: Image.network(
                news.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset('assets/images/placeholder.png',
                      width: 80, height: 80, fit: BoxFit.cover);
                },
              ),
              title: Text(
                news.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                news.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(fontSize: 14),
              ),
              onTap: () {
                Get.to(() => const NewsDetailPage(),
                    arguments: news);
              },
            ),
          );
        },
      );
    });
  }
}
