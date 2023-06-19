import 'package:chatapp2/screens/chat_screen.dart';
import 'package:chatapp2/screens/register.dart';
import 'package:chatapp2/screens/signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../models/button.dart';

class welcomscreen extends StatefulWidget {
  static const String screenRout = 'welcomScreen';

  const welcomscreen({super.key});

  @override
  State<welcomscreen> createState() => _welcomscreenState();
}

class _welcomscreenState extends State<welcomscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                 Container(
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(fit: BoxFit.cover , 
                    image: AssetImage('assets/images/images (7).jpeg'),),
                  ),
                ),
                Text(
                  'A7MdChat',
                  style: TextStyle(
                    fontFamily: 'Pacifico' ,
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    color: Color(0xff2e286b),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),

            mybutton(
              color: Colors.blue[900]!,
              title: 'Sign in',
              onpressed: () {
                Navigator.pushNamed(context,signin.screenRout);
              },
            ),
            mybutton(
              color: Colors.blue[900]!,
              title: 'Register',
              onpressed: () {
                Navigator.pushNamed(context,Registerpage.screenRout);
              },
            ),

            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 10),
            //   child: Material(
            //     elevation: 5,
            //     color: Colors.blue[900],
            //     borderRadius: BorderRadius.circular(16),

            //     child: MaterialButton(
            //       onPressed:(){},
            //       minWidth: 200,
            //       height: 42,

            //       child: Text('Sign in',
            //       style: TextStyle(color: Colors.white),),
            //       ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
