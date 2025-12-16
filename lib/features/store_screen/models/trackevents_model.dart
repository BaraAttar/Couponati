class TrackeventsModel {
  final String id;
  final String type;
  final String action;

  TrackeventsModel({
    required this.id,
    required this.type,
    required this.action,
  });

  Map<String, dynamic> toJson() {
    return {"id": id, "type": type, "action": action};
  }
}
