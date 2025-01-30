import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/controllers/news_controller.dart';
import 'package:myapp/pages/app/news_detail_page.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final NewsController newsController = Get.put(NewsController());
    TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search News',
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // TextField untuk pencarian
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search for news...',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    // Memanggil fungsi pencarian ketika tombol search ditekan
                    newsController.searchNews(searchController.text);
                  },
                ),
              ),
              onSubmitted: (value) {
                newsController
                    .searchNews(value); // Pencarian otomatis saat Enter
              },
            ),
            const SizedBox(height: 20),
            // Menampilkan hasil pencarian
            Obx(() {
              if (newsController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (newsController.searchResults.isEmpty) {
                return const Center(child: Text("No results found."));
              }

              return Expanded(
                child: ListView.builder(
                  itemCount: newsController.searchResults.length,
                  itemBuilder: (context, index) {
                    final news = newsController.searchResults[index];

                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
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
                          // Navigasi ke halaman detail berita
                          Get.to(() => const NewsDetailPage(), arguments: news);
                        },
                      ),
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
