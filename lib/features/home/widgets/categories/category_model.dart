class CategoryModel {
  final String id;
  final String name;
  final num order;
  final String? icon;

  CategoryModel({
    required this.id,
    required this.name,
    required this.order,
    required this.icon,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['_id'],
      name: json['name'],
      order: json['order'],
      icon: json['icon'],
    );
  }
}

class CategoriesControllerModel {
  final bool success;
  final String message;
  final List<CategoryModel> data;
  final num count;

  CategoriesControllerModel({
    required this.success,
    required this.message,
    required this.data,
    required this.count,
  });

  factory CategoriesControllerModel.fromJson(Map<String, dynamic> json) {
    final categoriesJson = json['data'] as List<dynamic>? ?? [];
    return CategoriesControllerModel(
      success: json['success'] ?? false,
      message: json['message'] ?? "",
      data: categoriesJson.map((b) => CategoryModel.fromJson(b)).toList(),
      count: json['count'] ?? 0,
    );
  }
}
