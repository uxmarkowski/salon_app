import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

InkWell MyButton({required text,required color,required Function func}) {
  return InkWell(
    onTap: (){
      func();
    },
    child: Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12)
      ),
      child: Center(child: Text(text,style: TextStyle(fontWeight: FontWeight.w600),)),
    ),
  );
}

InkWell SignButton({required text,required color,required Function func}) {
  return InkWell(
    onTap: (){
      func();
    },
    child: Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12)
      ),
      child: Center(child: Text(text,style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.w600),)),
    ),
  );
}