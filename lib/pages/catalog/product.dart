import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salon_app/main.dart';
import 'package:salon_app/widgets/my_app_bar.dart';

import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/open_filters.dart';


class ProductPage extends StatefulWidget {
  final product_data;
  const ProductPage({Key? key,required this.product_data}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  int ProductCount=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(title: "Brand", context: context, showFilter: (){}),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(widget.product_data['img'] ),
                Text(widget.product_data['header'],style: TextStyle(fontSize: 24,fontWeight: FontWeight.w700) ),
                SizedBox(height: 12 ),
                Text(widget.product_data['description'],style: TextStyle(height: 1.5) ),
                SizedBox(height: 124 ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 64,
              padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
              margin: EdgeInsets.only(left: 12,right: 16,bottom: 16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black12,blurRadius: 20)],
                borderRadius: BorderRadius.circular(100)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Center(child: Text((1000*(ProductCount==0 ? 1 : ProductCount)).toString()+" ₽",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.black)))
                  ),
                  Expanded(
                    child: Container(
                      height: 64-8*2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                        color: PrimaryColors
                      ),
                      child: Center(
                          child: ProductCount==0 ? InkWell(
                            onTap: (){
                              setState(() {  ProductCount++;  });
                            },
                              child: Container(height: 64-8*2,child: Center(child: Text("В коризну",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white),)))
                          )
                              : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                                IconButton(onPressed: (){ setState(() {  ProductCount--;  }); }, icon: Icon(CupertinoIcons.minus,color: Colors.white,size: 28)),
                                Text(ProductCount.toString(),style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w600),),
                                IconButton(onPressed: (){ setState(() {  ProductCount++;  }); }, icon: Icon(CupertinoIcons.plus,color: Colors.white,size: 28,)),
                            ],
                          )
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: MyBottomNavBar(currentIndex: 2, context: context),
    );
  }

}



