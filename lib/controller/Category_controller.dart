import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/state_manager.dart';

class CategoryController extends GetxController {
    RxList<String> categoryList = [
    'General',
    'Health',
    'Science',
    'Sports',
    'Technology',
    'Entertainment',
    'Business'
  ].obs;

  RxString category = 'General'.obs;

}