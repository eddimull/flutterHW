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

  Future<void> addCategory(String name) async {
    try {
      Category addedCategory = (await apiService.addCategory(name));
      categories.add(addedCategory);

      notifyListeners();
    } on Exception {
      print(Exception);
    }
  }

  Future<void> updateCategory(Category category) async {
    try {
      Category updatedCategory = (await apiService.updateCategory(category));
      int index = categories.indexOf(category);
      categories[index] = updatedCategory;

      notifyListeners();
    } on Exception {
      print(Exception);
    }
  }

  Future<void> deleteCategory(Category category) async {
    try {
      await apiService.deleteCategory(category.id);
      categories.remove(category);

      notifyListeners();
    } on Exception {
      print(Exception);
    }
  }
}
