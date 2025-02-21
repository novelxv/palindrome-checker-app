import 'package:flutter/material.dart';
import 'third_screen.dart';

class SecondScreen extends StatefulWidget {
  final String name;

  const SecondScreen({super.key, required this.name});

  @override
  SecondScreenState createState() => SecondScreenState();
}

class SecondScreenState extends State<SecondScreen> {
  String selectedUserName = "Selected User Name";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Welcome"),
            SizedBox(height: 8),
            Text(
              widget.name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            Text(
              selectedUserName,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ThirdScreen(),
                    ),
                  );
                  if (result != null && result is String) {
                    setState(() {
                      selectedUserName = result;
                    });
                  }
                },
                child: Text("Choose a User"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}