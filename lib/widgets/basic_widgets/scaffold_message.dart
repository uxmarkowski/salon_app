import 'package:flutter/material.dart';

void ScaffoldMessage({required context,required message}){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    duration: Duration(seconds: 3),
    backgroundColor: Colors.red,
  ));
}