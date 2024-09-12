import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../model/address_model.dart';

class AddressSearchController {
  final String _apiKey = 'Wde2JE0RgSGYhVHRKSJqA6lBJr_NAjNdbFKvsfgbASo';
  Timer? _debounce;
  final Duration debounceDuration = const Duration(seconds: 1);

  Future<List<AddressModel>> searchAddress(String query) async {
    final url =
        'https://geocode.search.hereapi.com/v1/geocode?q=$query&limit=10&apiKey=$_apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(utf8.decode(response.bodyBytes));
      final List results = data['items'] ?? [];
      return results.map((e) => AddressModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  void searchWithDebounce(String query, Function(List<AddressModel>) onSearchCompleted) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(debounceDuration, () async {
      if (query.isNotEmpty) {
        final results = await searchAddress(query);
        onSearchCompleted(results);
      } else {
        onSearchCompleted([]);
      }
    });
  }

  void dispose() {
    _debounce?.cancel();
  }

  void openGoogleMaps(double lat, double lng) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not open Google Maps';
    }
  }
}
