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
      home: Scaffold(
        body: MainSection(),
      ),
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
  Timer? _timer;
  String responseText = '';
  bool showResponse = false;
  FlutterTts flutterTts = FlutterTts();
  final ImagePicker _picker = ImagePicker();

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
    if (message.contains('hey') || message.contains('hello') || message.contains('hi')) {
      setResponseText("Hello, How can I help you?");
    } else if (message.contains('how are you')) {
      setResponseText("I am fine. Tell me how can I help you?");
    } else if (message.contains('name')) {
      setResponseText("My name is Adhikaar");
    } else if (message.contains('purpose')) {
      setResponseText("The BNSS aims to consolidate and amend the law related to Criminal Procedure in India.");
    } else if (message.contains('bnss') || message.contains('Bharatiya Nagarik Suraksha Sanhita')) {
      setResponseText("The Bharatiya Nagarik Suraksha Sanhita(BNSS), also known as the Indian Citizen Safety Code, is a significant piece of legislation in India.");
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
      // You can handle the image file here
      print('Image path: ${image.path}');
    }
  }

  @override
  void dispose() {
    contentController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  SizedBox(height: 10),
                  Visibility(
                    visible: showResponse,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        responseText,
                        style: TextStyle(
                          color: Color(0xFFAED0D0),
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 10),
            width: MediaQuery.of(context).size.width * 0.9,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(
                color: Color(0xFFAED0D0),
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
                    icon: Icon(Icons.camera_alt, color: Color(0xFFAED0D0)),
                    onPressed: _openCamera, // Open the camera on press
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
                          color: Color(0xFFAED0D0),
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
        ],
      ),
    );
  }
}
