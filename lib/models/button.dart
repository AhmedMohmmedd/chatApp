import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class mybutton extends StatelessWidget {
  mybutton({required this.color,required this.title , required this.onpressed});

  final Color color;
  final String title;
  final VoidCallback onpressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Material(
                elevation: 5,
                color: color,
                borderRadius: BorderRadius.circular(16),
            
                child: MaterialButton(
                  onPressed: onpressed,
                  minWidth: 200,
                  height: 42,
            
                  child:
                   Text(
                    title,
                  style: TextStyle(color: Colors.white),), 
                  ),
              ),
            );
  }
}