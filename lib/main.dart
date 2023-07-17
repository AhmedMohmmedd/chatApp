import 'package:chatapp2/blocs/authbloc/auth_bloc.dart';
import 'package:chatapp2/cubits/chatcubit/chat_cubit.dart';
import 'package:chatapp2/cubits/registercubit/register_cubit.dart';
import 'package:chatapp2/screens/chat_screen.dart';
import 'package:chatapp2/screens/register.dart';
import 'package:chatapp2/screens/signin.dart';
import 'package:chatapp2/screens/welcomscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubits/logincubit/login_cubit.dart';

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
    // final _auth = FirebaseAuth.instance;
    return MultiBlocProvider(
      providers: [
        BlocProvider( create: (context) => LoginCubit()),
        BlocProvider( create: (context) => RegisterCubit()),
        BlocProvider( create: (context) => ChatCubit()),
        BlocProvider( create: (context) => AuthBloc()),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'chatapp',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        //home:chatScreen() ,
        initialRoute: welcomscreen.screenRout,
        // _auth.currentUser != null ? chatScreen.screenRout : welcomscreen.screenRout,
        routes: {
          welcomscreen.screenRout: (context) => welcomscreen(),
          signin.screenRout: (context) => signin(),
          Registerpage.screenRout: (context) => Registerpage(),
          chatScreen.screenRout: (context) => chatScreen(),
        },
      ),
    );
  }
}
//flutter.minSdkVersion