import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/palindrome_viewmodel.dart';
import 'second_screen.dart';

class FirstScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController sentenceController = TextEditingController();

  FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: sentenceController,
              decoration: InputDecoration(labelText: "Palindrome"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<PalindromeViewModel>().checkPalindrome(
                  nameController.text,
                  sentenceController.text,
                );
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Result"),
                      content: Text(context.watch<PalindromeViewModel>().result),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("OK"),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text("CHECK"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondScreen(name: nameController.text)),
                );
              },
              child: Text("NEXT"),
            ),
          ],
        ),
      ),
    );
  }
}