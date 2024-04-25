

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Align SortingWidget({required filters}) {
  return Align(
    alignment: Alignment.bottomRight,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
          margin: EdgeInsets.only(right: 12,bottom: 12),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08),blurRadius: 10)],
              borderRadius: BorderRadius.circular(100)
          ),
          child: Row(
            children: [
              Container(width: 20,height: 20,child: SvgPicture.asset("lib/assets/icons/light/Sorts complete.svg")), SizedBox(width: 8,),
              Text("Сортировка: ${filters['sorting_type']=="popular" ? "По популярности" : (filters['sorting_type']=="price_up" ? "Повышение цены" : "Понижение цены") }",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500),),
            ],
          ),
        ),
      ],
    ),
  );
}