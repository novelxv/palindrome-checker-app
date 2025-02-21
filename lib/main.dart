import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/palindrome_viewmodel.dart';
import 'views/first_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PalindromeViewModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Palindrome Checker',
      home: FirstScreen(),
    );
  }
}