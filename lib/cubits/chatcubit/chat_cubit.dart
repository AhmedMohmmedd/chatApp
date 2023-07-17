import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../screens/chat_screen.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  // String? massageText;
  // String? massageSender;

  List<MessageLine> massegeWidghets = [];

  final _firestor = FirebaseFirestore.instance;
  final messageTextControler = TextEditingController();

  void sendMseag({required String messageText}) {
    // messageTextControler.clear();
    _firestor.collection('messages').add({
      'text': messageText,
      'sender': signedInUser.email,
      'time': FieldValue.serverTimestamp(),
    });
  }

  void ggetMseag<QuerySnapshot>() {
             massegeWidghets.clear();

    _firestor
        .collection('messages')
        .orderBy('time')
        .snapshots()
        .listen((event) {
      final masseges = event.docs.reversed;
        //  massegeWidghets.clear();
      for (var massege in masseges) {
        final massageText = massege.get('text');
       final  massageSender = massege.get('sender');
        final currentUser = signedInUser.email;

        final massegeWidghet = MessageLine(
          sender: massageSender,
          text: massageText,
          isMe: currentUser == massageSender,
        );
        massegeWidghets.add(massegeWidghet);
      }

      emit(ChatSuccess(messabes: massegeWidghets));
    });
  }
}
