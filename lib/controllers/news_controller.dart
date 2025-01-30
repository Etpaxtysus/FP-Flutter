import 'package:get/get.dart';
import '../services/news_services.dart';
import '../models/news_model.dart';

class NewsController extends GetxController {
  var isLoading = true.obs;
  var newsList = <News>[].obs;
  var searchResults = <News>[].obs; // Menyimpan hasil pencarian
  var page = 1.obs; // Untuk pagination
  var limit = 10.obs; // Jumlah berita per halaman

  @override
  void onInit() {
    fetchNews();
    super.onInit();
  }

  // Fungsi untuk mengambil berita
  void fetchNews() async {
    try {
      isLoading(true);
      var news = await NewsService.fetchNews(limit: limit.value, page: page.value);
      newsList.assignAll(news);
      page.value++;
    } catch (e) {
      print("Error fetching news: $e");
    } finally {
      isLoading(false);
    }
  }

  // Fungsi untuk mencari berita berdasarkan keyword
  void searchNews(String keyword) async {
    try {
      isLoading(true);
      var news = await NewsService.searchNews(keyword); // Mengambil berita sesuai pencarian
      searchResults.assignAll(news); // Menyimpan hasil pencarian
    } catch (e) {
      print("Error searching news: $e");
    } finally {
      isLoading(false);
    }
  }
}
