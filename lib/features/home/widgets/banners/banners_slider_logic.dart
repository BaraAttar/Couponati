import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:my_app/app/config.dart';

class BannerModel {
  final String id;
  final String name;
  final String? link;
  final String image;
  final bool active;

  BannerModel({
    required this.id,
    required this.name,
    required this.link,
    required this.image,
    required this.active,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['_id'],
      name: json['name'],
      link: json['link'],
      image: json['image'],
      active: json['active'],
    );
  }
}

class BannerController {
  Future<List<BannerModel>> fetchBanners() async {
    try {
      final response = await http.get(Uri.parse(AppConfig.getBanners));
      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final List<dynamic> data = decoded['data'];
        return data.map((json) => BannerModel.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}
