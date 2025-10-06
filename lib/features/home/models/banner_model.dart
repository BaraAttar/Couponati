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
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      link: json['link'] ?? '',
      image: json['image'] ?? '',
      active: json['active'] ?? '',
    );
  }
}

class BannerControllerModel {
  final bool success;
  final String message;
  final List<BannerModel>? data;

  BannerControllerModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory BannerControllerModel.fromJson(Map<String, dynamic> json) {
    final bannersJson = json['data'] as List<dynamic>? ?? [];
    return BannerControllerModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: bannersJson.map((b) => BannerModel.fromJson(b)).toList(),
    );
  }
}