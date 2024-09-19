import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set background color to black
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(color: Colors.white), // Set the title text color to white
        ),
        backgroundColor: Colors.black, // Background color of the AppBar
        iconTheme: IconThemeData(color: Colors.white), // Set the back button color to white
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding around the content
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Login',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Set the text color to white
                ),
              ),
              SizedBox(height: 20),
              _buildTextField('Username'),
              SizedBox(height: 20),
              _buildTextField('Password', obscureText: true),
              SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5, // Set width to 80% of screen width
                child: ElevatedButton(
                  onPressed: () {
                    // Add your login logic here
                  },
                  child: Text('Login'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.black, // Text color of the button
                    padding: EdgeInsets.symmetric(vertical: 15), // Adjust vertical padding as needed
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(color: Colors.white), // Border color of the button
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Forgot Password?',
                style: TextStyle(
                  color: Colors.blue, // Keep the forgot password text color as blue
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build a text field
  Widget _buildTextField(String hint, {bool obscureText = false}) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white), // Set hint text color to white
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white), // Set the border color to white
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white), // Set the border color to white when focused
          borderRadius: BorderRadius.circular(30),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      ),
      style: TextStyle(color: Colors.white), // Set the text color to white
    );
  }
}
