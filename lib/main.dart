import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainSection(),
    );
  }
}

class MainSection extends StatefulWidget {
  @override
  _MainSectionState createState() => _MainSectionState();
}

class _MainSectionState extends State<MainSection> {
  final contentController = TextEditingController();
  final ValueNotifier<bool> isTextEmpty = ValueNotifier<bool>(true);
  Timer? _textChangeTimer;
  FlutterTts flutterTts = FlutterTts();
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;
  String responseText = '';
  bool showResponse = false;

  @override
  void initState() {
    super.initState();
    activateInertia();
    contentController.addListener(() {
      isTextEmpty.value = contentController.text.isEmpty;
    });
    flutterTts.setCompletionHandler(() {
      setState(() {
        showResponse = false;
      });
    });
  }

  void activateInertia() {
    speak("Activating Adhikaar");
    speak("Going online");
    wishMe();
  }

  void speak(String sentence) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(sentence);
  }

  void wishMe() {
    final DateTime now = DateTime.now();
    final int hour = now.hour;

    if (hour >= 0 && hour < 12) {
      speak("Good Morning, Welcome to Adhikaar");
    } else if (hour == 12) {
      speak("Good noon, Welcome to Adhikaar");
    } else if (hour > 12 && hour <= 17) {
      speak("Good Afternoon, Welcome to Adhikaar");
    } else if (hour > 17 && hour <= 21) {
      speak("Good Evening, Welcome to Adhikaar");
    } else {
      speak("Good Night, Welcome to Adhikaar");
    }
  }

  void processTranscript(String transcript) {
    contentController.text = transcript;
    speakThis(transcript.toLowerCase());
  }

  void speakThis(String message) {
    if (message.contains('hello')) {
      setResponseText("Hello, How can I help you?");
    } else {
      setResponseText("I'm only able to guide you regarding law.");
    }
  }

  void setResponseText(String text) {
    setState(() {
      responseText = text;
      showResponse = true;
    });
    speak(text);
  }

  void handleSendButtonPress() {
    final message = contentController.text;
    if (message.isNotEmpty) {
      speakThis(message);
      contentController.clear();
    }
  }

  Future<void> _openCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _selectedImage = image;
      });

      // Automatically remove the image after 5 seconds
      Future.delayed(Duration(seconds: 5), () {
        setState(() {
          _selectedImage = null; // Remove the image
        });
      });
    }
  }

  @override
  void dispose() {
    contentController.dispose();
    _textChangeTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu, color: Colors.white), // White menu icon
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Opens the drawer
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF333333),
              ),
              child: Text(
                'Adhikaar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                // Handle the Home button tap
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              onTap: () {
                // Handle the About button tap
              },
            ),
            ListTile(
              leading: Icon(Icons.chat),
              title: Text('Chat History'),
              onTap: () {
                // Handle the Chat History button tap
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/Designer.png',
                      width: 170,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'A D H I K A A R',
                      style: TextStyle(
                        color: Color(0xFF00BCD4),
                        fontSize: 40,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "I'm a Virtual Assistant. How can I help you?",
                      style: TextStyle(
                        color: Color(0xFF324042),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    if (showResponse) // Conditionally render the response text
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          responseText,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    if (_selectedImage != null) // Display the captured image
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.file(
                          File(_selectedImage!.path),
                          width: 200,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 40),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(
                    color: Colors.white,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 80.0),
                      child: TextField(
                        controller: contentController,
                        readOnly: contentController.text == 'Listening...',
                        decoration: InputDecoration(
                          hintText: 'Ask Your Doubt',
                          hintStyle: TextStyle(color: Colors.white),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        ),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 48,
                      child: IconButton(
                        icon: Icon(Icons.camera_alt, color: Colors.white),
                        onPressed: _openCamera,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: ValueListenableBuilder<bool>(
                        valueListenable: isTextEmpty,
                        builder: (context, isEmpty, child) {
                          return IconButton(
                            icon: Icon(
                              isEmpty ? Icons.mic : Icons.send,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              if (isEmpty) {
                                setState(() {
                                  contentController.text = 'Listening...';
                                });
                                Future.delayed(Duration(seconds: 5), () {
                                  setState(() {
                                    contentController.text = '';
                                  });
                                });
                              } else {
                                handleSendButtonPress();
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
