class AddressModel {
  final String label;
  final double lat;
  final double lng;

  AddressModel({required this.label, required this.lat, required this.lng});

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    final position = json['position'];
    return AddressModel(
      label: json['title'] ?? '',
      lat: position['lat'],
      lng: position['lng'],
    );
  }
}
