import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/palindrome_viewmodel.dart';
import '../styles/app_styles.dart';
import 'second_screen.dart';

class FirstScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController sentenceController = TextEditingController();

  FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppStyles.backgroundGradient,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha((0.2 * 255).toInt()),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.person_add_outlined,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                SizedBox(height: 40),
                TextField(
                  controller: nameController,
                  decoration: AppStyles.textFieldDecoration("Name"),
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: sentenceController,
                  decoration: AppStyles.textFieldDecoration("Palindrome"),
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 32),
                ElevatedButton(
                  style: AppStyles.elevatedButtonStyle,
                  onPressed: () {
                    context.read<PalindromeViewModel>().checkPalindrome(
                      nameController.text,
                      sentenceController.text,
                    );
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          title: Text("Result"),
                          content: Text(
                            context.watch<PalindromeViewModel>().result,
                            style: TextStyle(fontSize: 16),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                "OK",
                                style: TextStyle(color: AppStyles.primaryColor),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text(
                    "CHECK",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  style: AppStyles.elevatedButtonStyle,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SecondScreen(
                          name: nameController.text,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "NEXT",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}