import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/user_service.dart';

class UserViewModel extends ChangeNotifier {
  final UserService _userService = UserService();

  List<UserModel> users = [];
  bool isLoading = false;
  bool hasMore = true;
  int currentPage = 1;

  // Pull to refresh
  Future<void> refreshUsers() async {
    currentPage = 1;
    users.clear();
    hasMore = true;
    await fetchUsers();
  }

  Future<void> fetchUsers() async {
    if (isLoading) return;

    isLoading = true;
    notifyListeners();

    try {
      final newUsers = await _userService.fetchUsers(page: currentPage, perPage: 6);
      if (newUsers.isEmpty) {
        hasMore = false;
      } else {
        users.addAll(newUsers);
        currentPage++;
      }
    } catch (e) {
      // Error handling
      debugPrint("Error fetching users: $e");
    }

    isLoading = false;
    notifyListeners();
  }
}