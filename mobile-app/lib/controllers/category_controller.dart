import 'dart:convert';
import 'package:multi_store_app/global_variables.dart';
import 'package:multi_store_app/models/category.dart';
import 'package:http/http.dart' as http;

class CategoryController {
  Future<List<Category>> loadCategory() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/categories'),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8',
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<Category> categories =
            data.map((category) => Category.fromJson(category)).toList();
        return categories;
      } else {
        throw Exception('Failed to Load Categories');
      }
    } catch (e) {
      throw Exception('Error Loading Categories: $e');
    }
  }
}
