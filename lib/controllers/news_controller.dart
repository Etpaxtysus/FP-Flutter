import 'package:get/get.dart';
import '../services/news_services.dart';
import '../models/news_model.dart';

class NewsController extends GetxController {
  var isLoading = true.obs;
  var newsList = <News>[].obs;
  var page = 1.obs; // Menyimpan nomor halaman
  var limit = 10.obs; // Menyimpan jumlah artikel per halaman

  @override
  void onInit() {
    fetchNews();
    super.onInit();
  }

  void fetchNews() async {
    try {
      isLoading(true);
      // Mengambil data berita sesuai halaman dan limit
      var news =
          await NewsService.fetchNews(limit: limit.value, page: page.value);
      newsList.addAll(news); // Menambahkan berita baru ke dalam daftar
      page.value++; // Increment page untuk load selanjutnya
    } catch (e) {
      print("Error fetching news: $e");
    } finally {
      isLoading(false);
    }
  }
}
