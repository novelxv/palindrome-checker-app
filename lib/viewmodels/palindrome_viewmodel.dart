import 'package:flutter/material.dart';
import '../models/palindrome_model.dart';

class PalindromeViewModel extends ChangeNotifier {
  String result = "";

  void checkPalindrome(String name, String sentence) {
    final palindrome = PalindromeModel(name: name, sentence: sentence);
    result = palindrome.isPalindrome() ? "Palindrome" : "Not Palindrome";
    notifyListeners();
  }
}