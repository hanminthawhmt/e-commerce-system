import 'dart:convert';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:web_app/glob_variables.dart';
import 'package:web_app/models/subcategory.dart';
import 'package:http/http.dart' as http;
import 'package:web_app/services/manage_http_response.dart';

class SubcategoryController {
  uploadSubCategoryImages({
    required String categoryId,
    required String categoryName,
    required dynamic image,
    required String subCategoryName,
    required context,
  }) async {
    try {
      final cloud = CloudinaryPublic("dinhfwgbb", "dwq8semx");
      CloudinaryResponse subCategoryResponse = await cloud.uploadFile(
        CloudinaryFile.fromBytesData(
          image,
          identifier: 'subcategory',
          folder: 'subcategory',
        ),
      );
      String subCategoryImage = subCategoryResponse.secureUrl;
      Subcategory subcategory = Subcategory(
        id: "",
        categoryId: categoryId,
        categoryName: categoryName,
        image: subCategoryImage,
        subCategoryName: subCategoryName,
      );
      http.Response response = await http.post(
        Uri.parse('$uri/api/subcategoires'),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8',
        },
        body: subcategory.toJson(),
      );
      handleResponse(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Uploaded Sub Category');
        },
      );
    } catch (e) {
      print('Error uploading to cloudinary: $e');
    }
  }

  Future<List<Subcategory>> loadSubCategory() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/subcategories'),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8',
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<Subcategory> subcategoires =
            data
                .map((subcategory) => Subcategory.fromJson(subcategory))
                .toList();
        return subcategoires;
      } else {
        throw Exception('Failed to Load Sub Categories');
      }
    } catch (e) {
      throw Exception('Error Loading Sub Categories $e');
    }
  }
}
