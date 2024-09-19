import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _voiceControlEnabled = true; // Default to true
  bool _darkThemeEnabled = true; // Default to true

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _voiceControlEnabled = prefs.getBool('voice_control') ?? true; // Default to true if not set
      _darkThemeEnabled = prefs.getBool('dark_theme') ?? true; // Default to true if not set
    });
  }

  void _toggleVoiceControl(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _voiceControlEnabled = value;
      prefs.setBool('voice_control', value);
    });
  }

  void _toggleTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _darkThemeEnabled = value;
      prefs.setBool('dark_theme', value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set background color to black
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(color: Colors.white), // Set title color to white
        ),
        backgroundColor: Colors.black, // Set background color of app bar to black
        iconTheme: IconThemeData(color: Colors.white), // Set icon color (back button) to white
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          SwitchListTile(
            title: Text(
              'Voice Control',
              style: TextStyle(color: Colors.white), // Text color to white
            ),
            value: _voiceControlEnabled,
            onChanged: _toggleVoiceControl,
            activeColor: Colors.blue, // Customize the switch color if needed
            inactiveTrackColor: Colors.grey, // Customize the switch color if needed
            inactiveThumbColor: Colors.white, // Customize the switch color if needed
          ),
          SwitchListTile(
            title: Text(
              'Dark Theme',
              style: TextStyle(color: Colors.white), // Text color to white
            ),
            value: _darkThemeEnabled,
            onChanged: _toggleTheme,
            activeColor: Colors.blue, // Customize the switch color if needed
            inactiveTrackColor: Colors.grey, // Customize the switch color if needed
            inactiveThumbColor: Colors.white, // Customize the switch color if needed
          ),
        ],
      ),
    );
  }
}
