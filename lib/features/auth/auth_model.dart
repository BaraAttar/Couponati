import 'package:my_app/features/home/models/store_model.dart';

class UserProfileModel {
  final String? googleId;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? picture;
  final List<StoreModel>? favourites;

  UserProfileModel({
    required this.googleId,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.picture,
    required this.favourites,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      googleId: json['googleId'] ?? '',
      email: json['email'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      picture: json['picture'] ?? '',
      favourites:
          (json['favourites'] as List<dynamic>?)
              ?.map((storeJson) => StoreModel.fromJson(storeJson))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "googleId": googleId,
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "picture": picture,
    };
  }
}

class DataModel {
  final UserProfileModel? user;
  final String? token;

  DataModel({required this.user, required this.token});

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      user: json["user"] != null
          ? UserProfileModel.fromJson(json['user'])
          : null,
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {"user": user, "token": token};
  }
}

class AuthControllerModel {
  final bool success;
  final String message;
  final DataModel? data;

  AuthControllerModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AuthControllerModel.fromJson(Map<String, dynamic> json) {
    return AuthControllerModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? DataModel.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {"success": success, "message": message, "data": data};
  }
}
