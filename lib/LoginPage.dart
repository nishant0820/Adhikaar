import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(color: Colors.white), // Set the title text color to white
        ),
        backgroundColor: Colors.black, // Background color of the AppBar
        iconTheme: IconThemeData(color: Colors.white), // Set the back button color to white
      ),
      body: Center(
        child: Text(
          'Login Page Content Goes Here',
          style: TextStyle(fontSize: 24, color: Colors.black), // Set the content text color to white
        ),
      ),
    );
  }
}

