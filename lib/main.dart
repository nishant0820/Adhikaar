import 'dart:async';
import 'dart:io';
import 'package:adhikaar/ChatHistoryScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  bool userHasInteracted = false; // Flag to control initial content display
  List<Map<String, dynamic>> messages = []; // Store chat messages

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
    await flutterTts.setLanguage("en-IN");
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
    if (message.contains('hey') ||
        message.contains('hello') ||
        message.contains('hi') ||
        message.contains('hii')) {
      setResponseText("Hello, How can I help you?");
    } else if (message.contains('how are you')) {
      setResponseText("I am fine. Tell me how can I help you?");
    } else if (message.contains('name')) {
      setResponseText("My name is Adhikaar");
    } else if (message.contains('purpose')) {
      setResponseText(
          "The BNSS aims to consolidate and amend the law related to Criminal Procedure in India.");
    } else if (message.contains('bnss') ||
        message.contains('BNSS') ||
        message.contains('Bharatiya Nagarik Suraksha Sanhita') ||
        message.contains('bharatiya nagarik suraksha sanhita')) {
      setResponseText(
          "The Bharatiya Nagarik Suraksha Sanhita(BNSS), also known as the Indian Citizen Safety Code, is a significant piece of legislation in India.");
    } else if (message.contains('article 370') ||
        message.contains('Article 370')) {
      setResponseText(
          "Article 370 in the Indian constitution gave special status to Jammu and Kashmir, a region disputed by India, Pakistan and China. It was drafted by N Gopalaswami Ayyangar, a member of the Constituent Assembly of India, and was added to the constitution as a 'temporary provision' in 1949.");
    } else if (message.contains('article 14') ||
        message.contains('Article 14') ||
        message.contains('Right to Equality')) {
      setResponseText(
          "Article 14 of the Constitution of India guarantees equality before the law and equal protection of the law to all people within the country. It states that the state cannot deny any person these rights. This right applies to citizens, foreigners, and legal entities like companies.");
    } else if (message.contains('article 19') ||
        message.contains('Article 19') ||
        message.contains('Right to Freedom of Speech and Expression')) {
      setResponseText(
          "Article 19 grants citizens the right to freely express their thoughts, opinions, and ideas. This includes the freedom to express oneself through speech, writing, printing, visual representations, or any other means. However, reasonable restrictions can be imposed on this right for the interests of sovereignty and integrity of India, security of the State, friendly relations with foreign nations, public order, decency or morality, contempt of court, defamation, incitement to an offense, or the sovereignty and integrity of Parliament.");
    } else if (message.contains('article 21') ||
        message.contains('Article 21') ||
        message.contains('Right to Protection of Life and Personal Liberty')) {
      setResponseText(
          "Article 21 of the Constitution of India states that no person can be deprived of their life or personal liberty unless it is in accordance with the procedure established by law.");
    } else if (message.contains('article 32') ||
        message.contains('Article 32') ||
        message.contains('Right to Constitutional Remedies')) {
      setResponseText(
          "Article 32 of the Indian Constitution is the Right to Constitutional Remedies, which gives citizens the right to directly approach the Supreme Court if their fundamental rights are violated. This article is considered a fundamental right, and is unique in the Constitution.");
    } else if (message.contains('article 136') ||
        message.contains('Article 136') ||
        message.contains('Right to Special Leave Petition')) {
      setResponseText(
          "Article 136 of the Constitution of India states that the Supreme Court can grant special leave to appeal from any judgment, decree, determination, sentence, or order passed by any court or tribunal in India. The Supreme Court can exercise this power in its discretion, and in exceptional circumstances, such as when a question of law of general public importance arises.");
    } else if (message.contains('article 226') ||
        message.contains('Article 226') ||
        message.contains('Right to Power of High Courts to Issue Writs')) {
      setResponseText(
          "Article 226 of the Constitution of India states that High Courts can issue writs, orders, or directives to any person or authority, including the government, to enforce fundamental rights and for other purposes. This is true even if the person or authority is not within the High Court's territorial jurisdiction.");
    } else if (message.contains('article 141') ||
        message.contains('Article 141') ||
        message.contains(
            'Right to Law Declared by Supreme Court to be Binding on All Courts')) {
      setResponseText(
          "Article 141 states that the law declared by the Supreme Court shall be binding on all courts within the territory of India. The law declared has to be construed as a principle of law that emanates from a judgment, or an interpretation of law or judgment by the Supreme Court, upon which the case is decided.");
    } else if (message.contains('article 142') ||
        message.contains('Article 142') ||
        message.contains(
            'Right to Enforcement of Decrees and Orders of Supreme Court')) {
      setResponseText(
          "Article 142 empowers the Supreme Court to pass any decree or order necessary for doing complete justice in any case or matter pending before it. These decrees or orders are enforceable across India's territory, making them significant tools for judicial intervention.");
    } else if (message.contains('article 300A') ||
        message.contains('Article 300A') ||
        message.contains('Right to Property')) {
      setResponseText(
          "Article 300A of the Constitution of India states that no one can be deprived of their property without the authority of law. This article was added to the Constitution by the 44th Constitutional Amendment Act in 1978. The amendment also expanded the state's power to appropriate property for social welfare purposes.");
    } else if (message.contains('article 256') ||
        message.contains('Article 256') ||
        message.contains('Right to Obligation of States and Union')) {
      setResponseText(
          "Article 256 of the Constitution of India states that the executive power of every state must be exercised in accordance with the laws made by Parliament and any existing laws that apply to that state. The article also states that the executive power of the Union can extend to giving directions to a state as may be necessary.");
    } else {
      // Handle other cases (e.g., open URLs, search, etc.)
      // ...
      setResponseText("I'm only able to guide you regarding law.");
    }
  }

  void setResponseText(String text) {
    setState(() {
      responseText = text;
      showResponse = true;
    });
    speak(text);
    addMessageToList(text,
        isUser: false); // Add system response to message list
  }

  void handleSendButtonPress() async {
    final message = contentController.text;
    if (message.isNotEmpty) {
      setState(() {
        userHasInteracted =
            true; // Hide initial content when user sends message
        addMessageToList(message, isUser: true); // Add user message to list
        contentController.clear();
      });

      // Show "Thinking..." after 2 seconds
      await Future.delayed(Duration(seconds: 2), () {
        setState(() {
          addMessageToList("Thinking...",
              isUser: false); // Add "Thinking..." to the left side
        });
      });

      // Replace "Thinking..." with the actual response after 3 seconds
      await Future.delayed(Duration(seconds: 3), () {
        speakThis(message);

        setState(() {
          // Remove the "Thinking..." message
          messages.removeWhere((msg) => msg['text'] == "Thinking...");

        });
      });

      // Save the chat message to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      List<String>? chatHistory = prefs.getStringList('chat_history');
      chatHistory ??= [];
      chatHistory.add('User: $message');
      chatHistory.add('Bot: $responseText');
      await prefs.setStringList('chat_history', chatHistory);
    }
  }

  void resetChat() {
    flutterTts.stop(); // Stop any ongoing speech
    setState(() {
      messages.clear(); // Clear the chat history in the UI
      userHasInteracted = false; // Reset to initial state
      showResponse = false;
      responseText = '';
    });
  }

  void addMessageToList(String message, {required bool isUser}) {
    setState(() {
      messages.add({'text': message, 'isUser': isUser});
    });
  }

  Future<void> _openCamera() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
      maxWidth: 1920,
      maxHeight: 1080,
    );

    if (image != null) {
      setState(() {
        _selectedImage = image;
      });

      Future.delayed(Duration(seconds: 5), () {
        setState(() {
          _selectedImage = null;
        });
      });
    }
  }

  void handleLiveStreamSelection(String choice) {
    setResponseText("Opening $choice Live Stream");
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
              icon: Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                Scaffold.of(context).openDrawer();
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
                Navigator.pop(context); // close the drawer
                resetChat();
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              onTap: () {
                Navigator.pop(context); // close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.chat),
              title: Text('Chat History'),
              onTap: () {
                Navigator.pop(context); // close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatHistoryScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.live_tv),
              title: Row(
                children: [
                  Text('Live Stream'),
                  Spacer(),
                  PopupMenuButton<String>(
                    icon: Icon(Icons.arrow_drop_down),
                    onSelected: (choice) {
                      handleLiveStreamSelection(choice);
                      Navigator.pop(context); // Close the drawer
                    },
                    itemBuilder: (BuildContext context) {
                      return [
                        'Gujarat High Court',
                        'Guahati High Court',
                        'Jharkhand High Court',
                        'Karnataka High Court',
                        'Madhya Pradesh High Court',
                        'Patna High Court'
                      ].map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Text(choice),
                          ),
                        );
                      }).toList();
                    },
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.book),
              title: Text('Case Study'),
              onTap: () {
                Navigator.pop(context); // close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.note_add),
              title: Text('New Chat'),
              onTap: () {
                Navigator.pop(context); // close the drawer
                resetChat();
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context); // close the drawer
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
              child: userHasInteracted
                  ? ListView.builder(
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        return Align(
                          alignment: message['isUser']
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color:
                                  message['isUser'] ? Colors.blue : Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              message['text'],
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      },
                    )
                  : Center(
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
                            textAlign: TextAlign.justify,
                          ),
                          if (showResponse)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                responseText,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          if (_selectedImage != null)
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
