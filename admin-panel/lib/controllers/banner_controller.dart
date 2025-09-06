import 'dart:convert';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:web_app/glob_variables.dart';
import 'package:web_app/models/banner.dart';
import 'package:http/http.dart' as http;
import 'package:web_app/services/manage_http_response.dart';

class BannerController {
  uploadBannerImage({required pickedImage, required context}) async {
    try {
      final cloudinary = CloudinaryPublic("dinhfwgbb", "dwq8semx");
      CloudinaryResponse cloudinaryResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(
          pickedImage,
          identifier: 'pickedImage',
          folder: 'banners',
        ),
      );
      String image = cloudinaryResponse.secureUrl;

      BannerModel banner = BannerModel(id: '', image: image);

      http.Response response = await http.post(
        Uri.parse("$uri/api/banner"),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8',
        },
        body: banner.toJson(),
      );
      handleResponse(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Banner Uploaded');
        },
      );
    } catch (e) {
      print('Banner Uploading Error $e');
    }
  }

  Future<List<BannerModel>> loadBanner() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/banner'),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8',
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<BannerModel> banners =
            data.map((banner) => BannerModel.fromJson(banner)).toList();
        return banners;
      } else {
        throw Exception('Failed to Load Banners');
      }
    } catch (e) {
      throw Exception('Error Loading Bannerss: $e');
    }
  }
}
