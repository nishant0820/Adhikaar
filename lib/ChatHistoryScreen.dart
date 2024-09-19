import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatHistoryScreen extends StatefulWidget {
  @override
  _ChatHistoryScreenState createState() => _ChatHistoryScreenState();
}

class _ChatHistoryScreenState extends State<ChatHistoryScreen> {
  List<String> chatHistory = [];

  @override
  void initState() {
    super.initState();
    loadChatHistory();
  }

  void loadChatHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList('chat_history') ?? [];
    setState(() {
      chatHistory = history;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chat History',
          style: TextStyle(color: Colors.white), // Set title color to white
        ),
        backgroundColor: Colors.black, // Set background color of app bar to black
        iconTheme: IconThemeData(color: Colors.white), // Set icon color (back button) to white
      ),
      body: Container(
        color: Colors.black, // Set background color of the body to black
        child: ListView.builder(
          itemCount: chatHistory.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                chatHistory[index],
                style: TextStyle(color: Colors.white), // Set text color to white
              ),
              tileColor: Colors.grey[800], // Optional: Set tile background color
            );
          },
        ),
      ),
    );
  }
}

