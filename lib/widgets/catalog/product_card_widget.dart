import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../pages/catalog/product.dart';
import '../basic_widgets/custom_route.dart';


Container ProductCard({required context, required data,required increment,required decrement,}) {
  return Container(
      margin: EdgeInsets.only(left: 4,right: 4,top: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: Colors.white,boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05),blurRadius: 10)]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: InkWell(
              onTap: (){
                final page = ProductPage(product_data: data);
                Navigator.of(context).push(CustomPageRoute(page));
              },
              child: Container(
                decoration: BoxDecoration(  image: DecorationImage(  image: NetworkImage(data['img']),fit: BoxFit.cover  ),  ),
                margin: EdgeInsets.all(4),
              ),
            ),
          ),
          InkWell(
            onTap: (){
              final page = ProductPage(product_data: data);
              Navigator.of(context).push(CustomPageRoute(page));
            },
            child: Column(
              children: [
                SizedBox(height: 16),
                Text(data['price'].toString()+" ₽",style: TextStyle(fontSize: 11,fontWeight: FontWeight.w700),),
                SizedBox(height: 2),
                Text(data['header'].toString(),style: TextStyle(fontSize: 11,fontWeight: FontWeight.w500),),
              ],
            ),
          ),
          SizedBox(height: 8),
          data['count']==0 ? InkWell(
            onTap: (){
              increment();
            },
            child: Container(
              child: Center(child: Text("В корзину",style: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.w600),)),
              decoration: BoxDecoration(
                  // color: CupertinoColors.systemGrey5,
                  border: Border.all(width: 1,color: Colors.black),
                  borderRadius: BorderRadius.circular(4)),
              height: 28,
              width: double.infinity,
            ),
          ) : Container(
            height: 28,
            // decoration: BoxDecoration(
            //     color: CupertinoColors.systemGrey5,
            //     // border: Border.all(width: 1,color: Colors.black),
            //     borderRadius: BorderRadius.circular(4)
            // ),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // IconButton(onPressed: (){ increment(); }, icon: Icon(CupertinoIcons.plus_circled)),
                InkWell(
                  onTap:(){ decrement(); },
                  child: Container(
                    // color: Colors.red,
                    height: 28,width: 28,
                    // child: Icon(CupertinoIcons.minus,size: 16,),
                    child: Icon(CupertinoIcons.minus_circled),
                  ),
                ),
                Text(data['count'].toString(),style: TextStyle(fontWeight: FontWeight.w600),),
                InkWell(
                  onTap:(){ increment(); },
                  child: Container(
                    height: 28,width: 28,
                    // child: Icon(CupertinoIcons.plus,size: 16,),
                    child: Icon(CupertinoIcons.plus_circled),
                  ),
                ),
                // IconButton(onPressed: (){ decrement(); }, icon: Icon(CupertinoIcons.minus_circled)),
              ],
            ),
          )
        ],
      )
  );
}