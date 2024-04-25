import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../main.dart';


Container RoundedContainerr({required bool is_current_category, required text}) {
  return Container(
      height: 42,
      padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      decoration: is_current_category ? BoxDecoration(
          color: PrimaryColors,
          borderRadius: BorderRadius.circular(36)
      ) : BoxDecoration(
          color: CupertinoColors.systemGrey5,
          borderRadius: BorderRadius.circular(36)
      ),
      child: Center(child: Text(text,style: TextStyle(color: is_current_category ? Colors.white : Colors.black),))
  );
}


Container SmallRoundedContainerr({required bool is_current_category, required text}) {
  return Container(
      height: 24,
      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
      decoration: is_current_category ? BoxDecoration(
          color: PrimaryColors,
          borderRadius: BorderRadius.circular(36)
      ) : BoxDecoration(
          color: CupertinoColors.systemGrey5,
          borderRadius: BorderRadius.circular(36)
      ),
      child: Center(child: Text(text,style: TextStyle(fontSize: 12,color: is_current_category ? Colors.white : Colors.black),))
  );
}