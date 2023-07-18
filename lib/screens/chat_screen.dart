

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestor = FirebaseFirestore.instance;
late User signedInUser;
//  String? messageText;

class chatScreen extends StatefulWidget {
  static const String screenRout = 'chatScreen';
  const chatScreen({super.key});

  @override
  State<chatScreen> createState() => _chatScreenState();
}

class _chatScreenState extends State<chatScreen> {
  final messageTextControler = TextEditingController();
  // final _firestor = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  String? messageText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUaer();
  }

  void getCurrentUaer() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signedInUser = user;
        print(signedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Row(
          children: [
            Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/images (7).jpeg'),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text('A7MdApp' , style: TextStyle(fontFamily: 'Pacifico'),),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
               // messageStreams();
              },
              icon: Icon(Icons.logout)),
        ],
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          messageStreamBuilder(),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.blue[900]!, width: 2),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: messageTextControler,
                    onChanged: (value) {
                      messageText = value;
                    },
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      hintText: 'Write Your message here...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                TextButton(
                  
                    onPressed: () {
                      messageTextControler.clear();
                      _firestor.collection('messages').add({
                        'text': messageText,
                        'sender': signedInUser.email,
                        'time' : FieldValue.serverTimestamp(),
                      });
                    },
                    child: Icon(Icons.send ,size: 30,color: Colors.blue[900],),
                    
                    ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}

class messageStreamBuilder extends StatelessWidget {
  const messageStreamBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestor.collection('messages').orderBy('time').snapshots(),
      builder: (context, snapshot) {
        List<MessageLine> massegeWidghets = [];

        if (!snapshot.hasData) {
          //add herr spinar
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.blue,
            ),
          );
        }

        final masseges = snapshot.data!.docs.reversed;
        for (var massege in masseges) {
          final massageText = massege.get('text');
          final massageSender = massege.get('sender');
          final currentUser = signedInUser.email;

          final massegeWidghet = MessageLine(
            sender: massageSender,
            text: massageText,
            isMe: currentUser == massageSender,
          );
          massegeWidghets.add(massegeWidghet);
        }

        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            children: massegeWidghets,
          ),
        );
      },
    );
  }
}

class MessageLine extends StatelessWidget {
  const MessageLine({this.sender, this.text,required this.isMe});

  final String? sender;
  final String? text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            '$sender',
            style: TextStyle(fontSize: 12, color: Colors.black45),
          ),
          Material(
            elevation: 5,
            borderRadius: isMe ? BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ) : BorderRadius.only(
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ) ,


            color: isMe? Colors.blue[900] : Colors.blue[600],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                '$text ',
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

