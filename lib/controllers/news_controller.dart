import 'package:get/get.dart';
import '../services/news_services.dart';
import '../models/news_model.dart';

class NewsController extends GetxController {
  var isLoading = true.obs;
  var newsList = <News>[].obs;
  var searchResults = <News>[].obs;
  var page = 1.obs;
  var limit = 10.obs;

  @override
  void onInit() {
    fetchNews();
    super.onInit();
  }

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

  void searchNews(String keyword) async {
    try {
      isLoading(true);
      var news = await NewsService.searchNews(keyword);
      searchResults.assignAll(news);
    } catch (e) {
      print("Error searching news: $e");
    } finally {
      isLoading(false);
    }
  }
}
