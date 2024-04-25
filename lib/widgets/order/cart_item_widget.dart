import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../pages/catalog/product.dart';
import '../basic_widgets/custom_route.dart';



Container CartItem({required data,required context,required Function increment_func,}) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08),blurRadius: 10)]
    ),
    width: double.infinity,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: (){
            final page = ProductPage(product_data: data,);
            Navigator.of(context).push(CustomPageRoute(page));
          },
          child: Row(
            children: [
              Container(
                height: 56,
                width: 56,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(data['img']),fit: BoxFit.cover
                    )
                ),
              ),
              SizedBox(width: 8,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width-24-24-56-8-100,
                      child: Text(data['header'])
                  ),
                  SizedBox(height: 4,),
                  Text((data['price']*data['count']).toString()+" ₽",style: TextStyle(fontWeight: FontWeight.w600),),
                ],
              ),
            ],
          ),
        ),
        Row(
          children: [
            InkWell(
                onTap: (){  increment_func(false);  },
                child: Icon(CupertinoIcons.minus_circle,size: 28)
            ),
            SizedBox(width: 8,), Text(data['count'].toString(),style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),  SizedBox(width: 8,),
            InkWell(
                onTap: (){  increment_func(true);  },
                child: Icon(CupertinoIcons.plus_circled,size: 28,)
            ),
          ],
        )
      ],
    ),
  );
}