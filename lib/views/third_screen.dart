import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/user_viewmodel.dart';
import '../models/user_model.dart';
import '../styles/app_styles.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  ThirdScreenState createState() => ThirdScreenState();
}

class ThirdScreenState extends State<ThirdScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    final userVM = context.read<UserViewModel>();
    userVM.fetchUsers();

    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    final userVM = context.read<UserViewModel>();
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (userVM.hasMore) {
        userVM.fetchUsers();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userVM = context.watch<UserViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.blue),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Third Screen",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        color: AppStyles.primaryColor,
        onRefresh: () => userVM.refreshUsers(),
        child: userVM.users.isEmpty && !userVM.isLoading
            ? _buildEmptyState()
            : ListView.separated(
                controller: _scrollController,
                padding: EdgeInsets.symmetric(vertical: 12),
                itemCount: userVM.users.length + (userVM.hasMore ? 1 : 0),
                separatorBuilder: (context, index) => Divider(
                  height: 1,
                  color: Colors.grey[200],
                ),
                itemBuilder: (context, index) {
                  if (index < userVM.users.length) {
                    final user = userVM.users[index];
                    return _buildUserItem(user);
                  } else {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppStyles.primaryColor,
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
      ),
    );
  }

  Widget _buildUserItem(UserModel user) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      leading: CircleAvatar(
        radius: 28,
        backgroundImage: NetworkImage(user.avatar),
      ),
      title: Text(
        "${user.firstName} ${user.lastName}",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      subtitle: Text(
        user.email,
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey[600],
        ),
      ),
      onTap: () {
        Navigator.pop(context, "${user.firstName} ${user.lastName}");
      },
    );
  }

  Widget _buildEmptyState() {
    return ListView(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.4),
        Center(
          child: Text(
            "No users found.",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ),
      ],
    );
  }
}