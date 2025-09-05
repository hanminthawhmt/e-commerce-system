import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:web_app/glob_variables.dart';
import 'package:web_app/models/category.dart';
import 'package:http/http.dart' as http;
import 'package:web_app/services/manage_http_response.dart';

class CategoryController {
  uploadCategoryImages({
    required dynamic categoryImage,
    required dynamic bannerImage,
    required String name,
    required context,
  }) async {
    try {
      final cloudinary = CloudinaryPublic("dinhfwgbb", "dwq8semx");
      //upload the image
      CloudinaryResponse categoryResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(
          categoryImage,
          identifier: 'categoryImage',
          folder: 'categoryImages',
        ),
      );
      String catImage = categoryResponse.secureUrl;
      CloudinaryResponse bannerResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(
          bannerImage,
          identifier: 'bannerImage',
          folder: 'bannerImages',
        ),
      );
      String banImage = bannerResponse.secureUrl;

      Category category = Category(
        id: "",
        name: name,
        image: catImage,
        banner: banImage,
      );

      http.Response response = await http.post(
        Uri.parse("$uri/api/categories"),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8',
        },
        body: category.toJson(),
      );
      handleResponse(response: response, context: context, onSuccess: () {
        showSnackBar(context, 'Uploaded Category');
      });
    } catch (e) {
      print('Error uploadint to cloudinary: $e');
    }
  }
}
