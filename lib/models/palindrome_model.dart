class PalindromeModel {
  final String name;
  final String sentence;

  PalindromeModel({required this.name, required this.sentence});

  bool isPalindrome() {
    String formattedText = sentence.replaceAll(RegExp(r'[^A-Za-z]'), '').toLowerCase();
    return formattedText == formattedText.split('').reversed.join('');
  }
}