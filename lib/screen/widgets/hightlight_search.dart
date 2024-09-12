import 'package:flutter/material.dart';

class HighlightSearchTerm extends StatelessWidget {
  final String text;
  final String searchTerm;

  const HighlightSearchTerm({
    super.key,
    required this.text,
    required this.searchTerm,
  });

  @override
  Widget build(BuildContext context) {
    if (searchTerm.isEmpty) return Text(text);

    final searchTermLower = searchTerm.toLowerCase();
    final textLower = text.toLowerCase();

    if (!textLower.contains(searchTermLower)) return Text(text);

    final startIndex = textLower.indexOf(searchTermLower);
    final endIndex = startIndex + searchTerm.length;

    return RichText(
      text: TextSpan(
        text: text.substring(0, startIndex),
        style: const TextStyle(color: Colors.black),
        children: [
          TextSpan(
            text: text.substring(startIndex, endIndex),
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: text.substring(endIndex),
            style: const TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
