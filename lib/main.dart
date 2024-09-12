import 'package:flutter/material.dart';

import 'screen/search_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Search Address App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  const AddressSearchScreen(),
    );
  }
}
