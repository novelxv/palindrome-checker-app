import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  final String name;

  const SecondScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
      ),
      body: Center(
        child: Text('Hello, $name!'),
      ),
    );
  }
}