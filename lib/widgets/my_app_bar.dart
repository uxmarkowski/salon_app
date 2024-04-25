import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salon_app/pages/sign/sign_up.dart';

import '../main.dart';
import 'custom_route.dart';
import 'open_filters.dart';



AppBar MyAppBar({
  required title,
  required context,
  show_sign_out=false,
  show_question=false,
  show_search=false,
  show_filter=false,
  required Function showFilter,
}) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 1,
    foregroundColor: Colors.black,
    centerTitle: true,
    title: Padding(padding: EdgeInsets.only(bottom: 2),child: Text(title,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),)),
    actions: [
      if(show_question) ...[
        SvgPicture.asset("lib/assets/icons/light/question.svg"),
        SizedBox(width: 12),
      ],
      if(show_sign_out) ...[
        InkWell(
          onTap: (){
            auth.signOut();
            final page = SignUpPage(is_sign_up: false,);
            Navigator.of(context).push(CustomPageRoute(page));
          },
            child: SvgPicture.asset("lib/assets/icons/light/Logout.svg")
        ),
        SizedBox(width: 12,)
      ],
      if(show_search) ...[
        SvgPicture.asset("lib/assets/icons/light/Search.svg"),
        SizedBox(width: 12,)
      ],
      if(show_filter) ...[
        GestureDetector(
          onTap: (){ showFilter(); },
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(width: 20,height: 20,child: SvgPicture.asset("lib/assets/icons/light/Filter.svg")), SizedBox(width: 8,),
                Text("Фильтры",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,color: Colors.black),),
                SizedBox(width: 12,),
              ],
            ),
          ),
        )
      ],

    ],
  );
}