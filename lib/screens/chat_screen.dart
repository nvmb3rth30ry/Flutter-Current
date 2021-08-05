import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ABC TV Sydney Main Control Room : 02 8333 1620

class ChatScreen extends StatefulWidget {
  static String id = 'chat';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  User loggedInUser;
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

  void messageStream() {
    _firestore.collection('messages').snapshots().forEach((var snap) {
      for (var msg in snap.docs) {
        print('Snap.msg.text = ${msg.get('text')}\n===');
        print('Snap.msg.data = ${msg.data()}\n>>>>><<<<<');
      }
    });
  }

  // void getMessages() async {
  //   final messages = await _firestore.collection('messages').get();
  //   for (var msg in messages.docs) {
  //     //print('Document = [${msg['sender']}] says \'${msg['text']}\'');
  //     print(msg.get('text'));
  //     print(msg.data());
  //   }
  // }

  void updateUserText() {
    //
    print('User TextField clears now, ideally.');
    print('and string moves to chat display box.');
  }

  void clearUserInput() {
    //
    print('User TextField clears now.');
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
        actions: <Widget>[
          IconButton(
            // LOGOUT button
            icon: Icon(Icons.close),
            onPressed: () {
              //Implement logout functionality
              _auth.signOut();
              Navigator.pop(context);
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
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        //Do something with the user input.
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //Implement send functionality.
                      //messageText + loggedInUser.email
                      _firestore.collection('messages').add(
                          {'text': messageText, 'sender': loggedInUser.email});
                      // console test output:
                      // print('User says: \"$messageText\"');
                      // updateUserText();
                      //getMessages();
                      messageStream();
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
