import 'package:get/get.dart';
import 'package:myapp/services/news_services.dart';
import '../models/news_model.dart';

class NewsController extends GetxController {
  var isLoading = true.obs;
  var newsList = <News>[].obs;

  @override
  void onInit() {
    fetchNews();
    super.onInit();
  }

  void fetchNews() async {
    try {
      isLoading(true);
      var news = await NewsService.fetchNews();
      newsList.assignAll(news);
    } catch (e) {
      print("Error fetching news: $e");
    } finally {
      isLoading(false);
    }
  }
}
