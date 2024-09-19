import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _voiceControlEnabled = false;
  bool _darkThemeEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _voiceControlEnabled = prefs.getBool('voice_control') ?? false;
      _darkThemeEnabled = prefs.getBool('dark_theme') ?? false;
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
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          SwitchListTile(
            title: Text('Voice Control'),
            value: _voiceControlEnabled,
            onChanged: _toggleVoiceControl,
          ),
          SwitchListTile(
            title: Text('Dark Theme'),
            value: _darkThemeEnabled,
            onChanged: _toggleTheme,
          ),
        ],
      ),
    );
  }
}

