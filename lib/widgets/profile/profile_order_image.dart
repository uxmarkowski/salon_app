import 'package:flutter/material.dart';

Container ProfileOrderImage({required data,required int index,required int index_two}) {
  return Container(
    height: 54,width: 54,
    child: Stack(
      children: [
        Container(
          height: 54,width: 54,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(data['products'][index][index_two]['img']),fit: BoxFit.cover
              )
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
          decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12),boxShadow: [BoxShadow(color: Colors.black12,blurRadius: 10)]),
          child: Text(data['products'][index][index_two]['count'].toString(),style: TextStyle(fontSize: 12,fontWeight: FontWeight.w700),),
        )
      ],
    ),
  );
}