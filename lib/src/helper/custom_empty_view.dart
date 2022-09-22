import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomEmptyView extends StatelessWidget {
  final String message;
  final double bottomPadding;
  final double fontSize;

  const CustomEmptyView({Key? key,required this.message,this.bottomPadding=0,this.fontSize=22}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(color: Colors.white,child: Column(mainAxisAlignment: MainAxisAlignment.center,children:  [
      Padding(padding: EdgeInsets.only(bottom: bottomPadding),
          child: Center(child: Text(message,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: fontSize)),))
    ],),);
  }
}
