import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controller/all_search_controller.dart';
import '../model/address_model.dart';
import 'widgets/appbar_search.dart';
import 'widgets/hightlight_search.dart';

class AddressSearchScreen extends StatefulWidget {
  const AddressSearchScreen({super.key});

  @override
  State<AddressSearchScreen> createState() => _AddressSearchScreenState();
}

class _AddressSearchScreenState extends State<AddressSearchScreen> {
  final AddressSearchController _controller = AddressSearchController();
  List<AddressModel> _searchResults = [];
  String _query = '';
  bool _isLoading = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  //off loading khi có result
  void _onSearchCompleted(List<AddressModel> results) {
    setState(() {
      _searchResults = results;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SearchAppBar(
          isLoading: _isLoading,
          onChanged: (query) {
            setState(() {
              _query = query;
              _isLoading = true;
            });
            _controller.searchWithDebounce(query, _onSearchCompleted);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  final result = _searchResults[index];
                  return ListTile(
                    leading: const Icon(Icons.location_on),
                    title: HighlightSearchTerm(
                      text: result.label,
                      searchTerm: _query,
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.directions),
                      onPressed: () =>
                          _controller.openGoogleMaps(result.lat, result.lng),
                    ),
                    onTap: () =>
                        _controller.openGoogleMaps(result.lat, result.lng),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
