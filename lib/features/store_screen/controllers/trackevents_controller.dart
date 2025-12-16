import 'package:my_app/app/api_service.dart';
import 'package:my_app/app/config.dart';
import 'package:my_app/core/logger/logger_service.dart';
import 'package:my_app/features/store_screen/models/trackevents_model.dart';

class TrackeventsController {
  Future<void> postStoreViewEvent(String id) async {
    final body = TrackeventsModel(
      id: id,
      type: "Store",
      action: "view",
    );

    try {
      final uri = Uri.parse(AppConfig.trackEvent);
      final response = await ApiService.post(uri, body);
      AppLogger.api(response);
    } catch (error) {
      AppLogger.d('Unexpected error during store view track event in: $error');
    }
  }
  
  Future<void> postCodeCopiedEvent(String id) async {
    final body = TrackeventsModel(
      id: id,
      type: "Coupon",
      action: "action",
    );

    try {
      final uri = Uri.parse(AppConfig.trackEvent);
      final response = await ApiService.post(uri, body);
      AppLogger.api(response);
    } catch (error) {
      AppLogger.d('Unexpected error during coupon code copied event in: $error');
    }
  }
}
