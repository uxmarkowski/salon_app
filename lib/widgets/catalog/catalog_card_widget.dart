import 'package:flutter/material.dart';

Container CatalogCard({required data}) {
  return Container(
      margin: EdgeInsets.only(left: 4,right: 4,top: 8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: Colors.white,boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05),blurRadius: 10)]),
      child: Column(
        children: [
          SizedBox(height: 16),
          Text(data['header'].toString(),style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500),),
          SizedBox(height: 4,),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(data['img']),fit: BoxFit.cover
                ),
              ),
              margin: EdgeInsets.all(16),
            ),
          )
        ],
      )
  );
}