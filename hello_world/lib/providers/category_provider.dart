import 'package:flutter/cupertino.dart';
import 'package:hello_world/services/api.dart';

import '../models/Category.dart';

class CategoryProvider extends ChangeNotifier {
  List<Category> categories = [];
  late ApiService apiService;

  CategoryProvider() {
    apiService = ApiService();

    init();
  }

  Future init() async {
    categories = (await apiService.fetchCategories()).cast<Category>();
    notifyListeners();
  }

  Future updateCategory(Category category) async {
    try {
      Category updatedCategory = (await apiService.updateCategory(category));
      int index = categories.indexOf(category);
      categories[index] = updatedCategory;

      notifyListeners();
    } catch (Exception) {
      print(Exception);
    }
  }
}
