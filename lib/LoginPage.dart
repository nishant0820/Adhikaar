import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      // Add your login logic here
      print("Logging in...");
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
          child: Form(
            key: _formKey,
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
                _buildTextField('Username', _usernameController),
                SizedBox(height: 20),
                _buildTextField('Password', _passwordController, obscureText: true),
                SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5, // Set width to 50% of screen width
                  child: ElevatedButton(
                    onPressed: _login,
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
      ),
    );
  }

  // Helper method to build a text field
  Widget _buildTextField(String hint, TextEditingController controller, {bool obscureText = false}) {
    return TextFormField(
      controller: controller,
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $hint';
        }
        return null;
      },
    );
  }
}
