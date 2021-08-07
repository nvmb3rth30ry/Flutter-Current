import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/screens/welcome_screen.dart'
    '';
// global properties
final _firestore = FirebaseFirestore.instance;
User loggedInUser = null;


// ABC TV Sydney Main Control Room : 02 8333 1620

class ChatScreen extends StatefulWidget {
  static String id = 'chat';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final messageTextController = TextEditingController();
  String messageText;

  void getCurrentUser() async {
    final user = _auth.currentUser;
    try {
      if (user != null) {
        loggedInUser = user;
        print('Logged In User : $loggedInUser');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser(); // load user
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            // LOGOUT button
            icon: Icon(Icons.close),
            onPressed: () {
              //Implement logout functionality
              _auth.signOut();
              Navigator.pushReplacementNamed(context, WelcomeScreen.id);
            },
          ),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        //Do something with the user input.
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _firestore.collection('messages').add({
                        'text': messageText,
                        'sender': loggedInUser.email,
                        'time': FieldValue.serverTimestamp(),
                      });
                      messageTextController.clear(); // remove what's just been entered
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// Messages Stream handler fetcher class
class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').orderBy('time').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          // if initial snap null, show spinner
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data.docs;
        List<ChatBubble> chatBubbles = [];
        for (var msg in messages) {
          final msgText = msg['text']; // can use .get('key') too
          final msgSender = msg['sender'];
          final isMe = msgSender == loggedInUser.email;  // who? me?
          final chatBubble = ChatBubble(
            text: msgText,
            sender: msgSender,
            isMe: isMe,
          );
          chatBubbles.add(chatBubble);
        }
        return Expanded(
          child: ListView(
            padding:
            EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0,),
            children: chatBubbles,
          ),
        );
      },
    );
  }
}


// custom chat bubble
class ChatBubble extends StatelessWidget {
  ChatBubble({this.text, this.sender, this.isMe});

  final String text;
  final String sender;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          height: 14.0,
          child: Text(
            sender,
            style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w900,
            color: Colors.black38,
          ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(4.0, 2.0, 4.0, 12.0),
          child: Material(
            elevation: 2.0,
            borderRadius: isMe ? kBubbleRadiusSelf : kBubbleRadiusOther,
            color: isMe ? Colors.lime : Colors.lightBlue,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0,),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 18.0,
                  //fontFamily: nnn,
                  color: isMe ? Colors.black : Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
