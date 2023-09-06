// ignore_for_file: use_build_context_synchronously

import 'package:flash_flutter/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_flutter/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

late User loggedInUser;
final _firestore = FirebaseFirestore.instance;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';

  const ChatScreen({super.key});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;

  String messageText = '';

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    messagesStream();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void messagesStream() async {
    await for (final snapshot
        in _firestore.collection('messages').snapshots()) {
      for (final message in snapshot.docs) {
        debugPrint(message.data().toString());
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                setState(() {
                  showSpinner = true;
                });
                await _auth.signOut();
                Navigator.popAndPushNamed(context, WelcomeScreenActual.id);
                setState(() {
                  showSpinner = false;
                });
              }),
        ],
        title: Row(
          children: [
            Image.asset('assets/images/logo.png', width: 30, height: 50),
            const SizedBox(width: 10),
            const Text('Group Chat')
          ],
        ),
        backgroundColor: Colors.black38,
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MessageStreamBuilder(firestore: _firestore),
              Container(
                decoration: kMessageContainerDecoration,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 10, 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextField(
                          style: const TextStyle(color: Colors.black87),
                          cursorColor: kPrimaryColor,
                          controller: messageTextController,
                          onChanged: (value) {
                            messageText = value;
                          },
                          decoration: kMessageTextFieldDecoration,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          //Implement send functionality.
                          messageTextController.clear();
                          if (messageText != '') {
                            _firestore
                                .collection('messages')
                                .doc(DateTime.now().toString())
                                .set({
                              'text': messageText,
                              'sender': loggedInUser.email,
                            });
                          } else {}
                        },
                        child: Icon(Icons.send, color: kPrimaryColor),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MessageStreamBuilder extends StatelessWidget {
  const MessageStreamBuilder({
    super.key,
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  final FirebaseFirestore _firestore;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final messages = snapshot.data!.docs.reversed;
          List<MassageBubble> messageBubbles = [];
          for (final message in messages) {
            final messageText = message.get('text');
            final messageSender = message.get('sender');

            final currentUser = loggedInUser.email;

            final messageBubble = MassageBubble(
              sender: messageSender,
              text: messageText,
              isMe: currentUser == messageSender,
            );
            messageBubbles.add(messageBubble);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 20.0,
              ),
              children: messageBubbles,
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.white,
            color: Colors.white,
          ),
        );
      },
    );
  }
}

class MassageBubble extends StatelessWidget {
  final bool isMe;
  final String text;
  final String sender;

  const MassageBubble(
      {super.key,
      required this.sender,
      required this.text,
      required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: isMe
                  ? const BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10.0),
                      bottomLeft: Radius.circular(0.0),
                      bottomRight: Radius.circular(0.0),
                    )
                  : const BorderRadius.only(
                      topRight: Radius.circular(10.0),
                      bottomLeft: Radius.circular(0.0),
                      bottomRight: Radius.circular(00.0),
                      topLeft: Radius.circular(10)),
              color: Colors.black38,
            ),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              sender.toString().substring(0, sender.toString().indexOf('@')),
              style: const TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
          Material(
            elevation: 5.0,
            borderRadius: isMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  )
                : const BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
            color: isMe ? Colors.white : Colors.blue,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                text,
                style: const TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
