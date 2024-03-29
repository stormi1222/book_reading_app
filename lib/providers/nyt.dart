import 'dart:convert';
import 'package:book_reading_app/models/category.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class NYT with ChangeNotifier {
  bool _loaded = false;
  List<Category> _categories = [];
  String _selectedCategory = '';

  bool get isLoaded {
    return _loaded;
  }

  List<Category> get getAllCategories {
    return [..._categories];
  }

  void setLoading(bool loadingState) {
    _loaded = loadingState;
    notifyListeners();
  }

  String get getSelectedCategory {
    return _selectedCategory;
  }

  Future<void> getCategoryList() async {
    var apiKey = 'AIzaSyAoQ8UorQyUY-gJEsObT_EyAZbUcVAPOBc'; //change api
    final url =
        'https://www.googleapis.com/svc/books/v3/lists/names.json?api-key=$apiKey';
    try {
      http.Response response = await http.get(Uri.parse(url));

      var jsonResponse = await jsonDecode(response.body);
      List categoriesJsonList = jsonResponse['results'];

      List<Category> categories = [];
      categoriesJsonList.forEach((category) {
        categories.add(Category(
          categoryLink: category['list_name_encoded'],
          categoryTitle: category['display_name'],
          oldDate: category['oldest_published_date'],
          newDate: category['newest_published_date'],
          updated: category['updated'],
        ));
      });
      _categories = categories;

      await null;
    } catch (e) {
      print(e);
    }
  }
}
