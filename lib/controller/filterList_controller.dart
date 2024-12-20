import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

enum FilterNewsList { bbcNews, cnnNews, aljazeeraNews }

class FilterController extends GetxController {
  var selectedFilter = FilterNewsList.bbcNews.obs;
  RxString name = 'bbc-news'.obs;

  void updateSelectedFilet(FilterNewsList filter) {
    selectedFilter.value = filter;
    if (FilterNewsList.bbcNews.name == filter.name) {
      name.value = 'bbc-news';
    }
    if (FilterNewsList.cnnNews.name == filter.name) {
      name.value = 'cnn';
    }
    if (FilterNewsList.aljazeeraNews.name == filter.name) {
      name.value = 'al-jazeera-english';
    }
  }
}
