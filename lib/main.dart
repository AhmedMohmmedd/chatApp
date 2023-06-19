import 'package:chatapp2/screens/chat_screen.dart';
import 'package:chatapp2/screens/register.dart';
import 'package:chatapp2/screens/signin.dart';
import 'package:chatapp2/screens/welcomscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    final _auth = FirebaseAuth.instance;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'chatapp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home:chatScreen() ,
      initialRoute:_auth.currentUser != null ? chatScreen.screenRout : welcomscreen.screenRout,
      routes: {
        welcomscreen.screenRout: (context) => welcomscreen(),
        signin.screenRout: (context) => signin(),
        Registerpage.screenRout: (context) => Registerpage(),
        chatScreen.screenRout: (context) => chatScreen(),
      },
    );
  }
}
//flutter.minSdkVersion