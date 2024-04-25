import 'dart:math';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salon_app/main.dart';
import 'package:salon_app/pages/catalog/catalog.dart';
import 'package:salon_app/pages/catalog/product.dart';
import 'package:salon_app/widgets/bottom_nav_bar.dart';
import 'package:salon_app/widgets/global_variables.dart';
import 'package:salon_app/widgets/my_app_bar.dart';
import 'package:salon_app/widgets/order/cart_item_widget.dart';
import '../../widgets/custom_route.dart';
import '../../widgets/grey_button.dart';
import 'order_settings.dart';




class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  
  List cart=[];
  List supliers_list=[{"id":0,"name":"Все"}];
  List brands_list=[{"id":0,"name":"Все"}];



  loadCart() async{
    cart=await model.getCart();
    print("cart "+cart.toString());
    cart.sort((a,b){return a['suplier']==b['suplier'] ? 0 : 1;});
    setState(() { });
  }

  @override
  void initState() {
    loadData();

    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    var total_price=0;
    cart.forEach((element) {total_price=total_price+(element['price'] as int)*(element['count'] as int);});

    return Scaffold(
      appBar: MyAppBar(title: "Корзина", context: context, showFilter: (){}),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: ListView.separated(
                itemCount: cart.length,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 12,vertical: 24),
                shrinkWrap: true,
                itemBuilder: (context,index){
                  var suplier_name=supliers_list.firstWhere((element) => element['id']==cart[index]["suplier_id"])['name'];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if(index==0||cart[index]["suplier_id"]!=cart[index-1]["suplier_id"]) ...[
                        SizedBox(height: 8),
                        Text(suplier_name,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),),
                        SizedBox(height: 12),
                      ],
                      CartItem(data: cart[index],context: context, increment_func: (value){
                        setState(() {
                          cart[index]["count"]=cart[index]["count"]+(value ? 1 : (-1));cart[index]["count"]=max(0, cart[index]["count"] as int);
                          if(cart[index]["count"]==0) cart.removeWhere((element) => element['id']==cart[index]["id"]);
                        });

                      }),
                    ],
                  );
                },
              separatorBuilder: (context,index){
                  return SizedBox(height: 12,);
              },
            ),
          ),
          if(cart.length!=0) Align(
            alignment: Alignment.bottomCenter,
            child: Padding(padding: EdgeInsets.all(12),
              child: SignButton(text: "К оформлению | $total_price ₽", color: PrimaryColors, func: (){
                final page = Oreder_Settings_Screen(cart: cart,);
                Navigator.of(context).push(CustomPageRoute(page));Navigator.of(context).push(CupertinoPageRoute(builder: (context){ return page; }));
                // Navigator.of(context).push(CustomPageRoute(page));
              },),
            ),
          )
        ],
      ),
      bottomNavigationBar: MyBottomNavBar(currentIndex: 2, context: context),
    );
  }

  loadData() async{
    var supliers = await db.child("Supliers").get(); supliers_list.addAll((supliers.value as Map).values.toList());
    var brands = await db.child("Brands").get(); brands_list.addAll((brands.value as Map).values.toList());
    loadCart();
  }


}
