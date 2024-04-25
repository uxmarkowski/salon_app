import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Container ImagePlaceHolder() {
  return Container(
    height: 56,
    width: 56,
    decoration: BoxDecoration(
      color: CupertinoColors.systemGrey4,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.circle,color: Colors.white,size: 4,),
          SizedBox(width: 4,),
          Icon(Icons.circle,color: Colors.white,size: 4,),
          SizedBox(width: 4,),
          Icon(Icons.circle,color: Colors.white,size: 4,),
        ],
      ),
    ),
  );
}