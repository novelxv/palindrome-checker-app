import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/user_viewmodel.dart';
import '../models/user_model.dart';

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
      appBar: AppBar(
        title: Text("Third Screen"),
      ),
      body: RefreshIndicator(
        onRefresh: () => userVM.refreshUsers(),
        child: userVM.users.isEmpty && !userVM.isLoading
            ? _buildEmptyState()
            : ListView.builder(
                controller: _scrollController,
                itemCount: userVM.users.length + (userVM.hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < userVM.users.length) {
                    final user = userVM.users[index];
                    return _buildUserItem(user);
                  } else {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: CircularProgressIndicator(),
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
      leading: CircleAvatar(
        backgroundImage: NetworkImage(user.avatar),
      ),
      title: Text("${user.firstName} ${user.lastName}"),
      subtitle: Text(user.email),
      onTap: () {
        Navigator.pop(context, "${user.firstName} ${user.lastName}");
      },
    );
  }

  Widget _buildEmptyState() {
    return ListView(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.4),
        Center(child: Text("No users found.")),
      ],
    );
  }
}