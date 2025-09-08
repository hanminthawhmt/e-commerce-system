import 'dart:convert';
import 'package:multi_store_app/global_variables.dart';
import 'package:multi_store_app/models/banner.dart';
import 'package:http/http.dart' as http;


class BannerController {
  

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
