import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salon_app/main.dart';
import 'package:salon_app/pages/profile.dart';
import 'package:salon_app/widgets/basic_widgets/scaffold_message.dart';

import '../../widgets/basic_widgets/custom_route.dart';
import '../../widgets/grey_button.dart';
import '../../widgets/my_app_bar.dart';
import '../../widgets/widgets.dart';


var mainColor = Color.fromRGBO(103, 0, 255, 1);



class Oreder_Settings_Screen extends StatefulWidget {
  final cart;
  const Oreder_Settings_Screen({Key? key,required this.cart}) : super(key: key);

  @override
  State<Oreder_Settings_Screen> createState() => _Oreder_Settings_ScreenState();
}

class _Oreder_Settings_ScreenState extends State<Oreder_Settings_Screen> {

  bool firstWidgetActive = true;

  int idForShoosPayWay = 0;
  int total_price=0;

  String pay_type = "Наличными курьеру";
  String delivery_type = "Доставка от продавца";

  List supliers_list=[{"id":0,"name":"Все"}];
  List brands_list=[{"id":0,"name":"Все"}];
  List<List<dynamic>> cartProducts=[];



  @override
  void initState() {
    loadData();

    // TODO: implement initState
    super.initState();
  }

  check_total_price() => widget.cart.forEach((element) {total_price=total_price+(element['price'] as int)*(element['count'] as int);});


  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: MyAppBar(title: "Оформление", context: context, showFilter: (){}),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 12,right: 12,top: 36),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Условия доставки", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
                SizedBox(height: 16,),
                Row(
                  children: [
                    WidgetDenisa(context: context, isActive: firstWidgetActive, function: (){
                      setState(() { delivery_type = "Доставка от продавца"; firstWidgetActive = true;  });
                    }, header: "Доставка от продавца"),
                    SizedBox(width: 12,),
                    WidgetDenisa(context: context, isActive: !firstWidgetActive, function: (){
                      setState(() {  delivery_type = "Доставка Яндекс"; firstWidgetActive = false;  });
                    }, header: "Доставка Яндекс"),
                  ],
                ),
                SizedBox(height: 24,),
                Text("Заказы", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                SizedBox(height: 16,),
                ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: cartProducts.length,
                    itemBuilder: (context,index) {
                      var suplier_name=supliers_list.firstWhere((element) => element['id']==(cartProducts[index] as Map)["suplier_id"])['name'];

                      return OrderWidget(
                        name: suplier_name,
                        orderNumber: index+1,
                        price: 3500,
                        deliveryPrice: 1000,
                        deliveryTime: 1,
                        products: cartProducts[index],
                      );
                    },
                  separatorBuilder: (context,index) {
                    return SizedBox(height: 16,);
                  },
                ),
                SizedBox(height: 24,),
                Text("Способ оплаты", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                SizedBox(height: 4),
                Text("(Оплата производится напрямую поставщикам)", style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),),
                SizedBox(height: 12,),
                Row(
                  children: [
                    ChoosePayWayWidget(
                        context: context, name: "Наличными курьеру", numberThatMeanBeActive: 0, id: idForShoosPayWay,
                        function: (){
                          setState(() { pay_type="Наличными курьеру"; idForShoosPayWay = 0;  });
                        }
                    ),
                    SizedBox(width: 12,),
                    ChoosePayWayWidget(
                        context: context, name: "Картой курьеру", numberThatMeanBeActive: 1, id: idForShoosPayWay,
                        function: (){
                          setState(() {  pay_type="Картой курьеру"; idForShoosPayWay = 1;  });
                        }
                    ),
                    SizedBox(width: 12,),
                    ChoosePayWayWidget(
                        context: context, name: "По счету юрлица", numberThatMeanBeActive: 2, id: idForShoosPayWay,
                        function: (){
                          setState(() {  pay_type="По счету юрлица"; idForShoosPayWay = 2;  });
                        }
                    ),
                  ],
                ),
                SizedBox(height: 24,),
                // Divider(height: 36,color: Colors.black26,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Итого:", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),),
                    SizedBox(width: 8,),
                    Text(total_price.toString()+" ₽", style: TextStyle(color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold),),
                  ],
                ),

                SizedBox(height: 24,),
                SignButton(text: "Оформить", color: PrimaryColors, func: () async{
                  var my_orders = await db.child("UsersCollection").child(auth.currentUser!.phoneNumber.toString()).get();
                  AcceptOrder(my_orders);
                }),
                SizedBox(height: 48),
              ],
            ),
          )
        )
    );
  }

  void cartChanges() {
    List supliers=[];
    (widget.cart as List).forEach((element) {if(!supliers.contains(element['suplier'])) supliers.add(element['suplier']); });
    supliers.forEach((element) {cartProducts.add([]);});
    (widget.cart as List).forEach((element) {
      cartProducts[supliers.indexOf(element['suplier'])].add(element);
    });

    // print("CartProducts "+cartProducts.toString());
  }

  void AcceptOrder(my_orders) {
    var newid=DateTime.now().millisecondsSinceEpoch.toString();
    var delivery_date=DateTime.now().add(Duration(days: 1)).millisecondsSinceEpoch;
    var my_orders_list = (my_orders.value as Map).containsKey("orders") ? (my_orders.value as Map)['orders'] : [];

    my_orders_list.add(newid);

    db.child("UsersCollection").child(auth.currentUser!.phoneNumber.toString()).update({
      "orders":my_orders_list,
    });

    db.child("Orders").child(newid).set({
      "id":newid,
      "status":"wait",
      "user_phone":auth.currentUser!.phoneNumber.toString(),
      "price":total_price,
      "pay_type":pay_type,
      "delivery_date":delivery_date,
      "delivery_type":delivery_type,
      "products":cartProducts,
    });

    model.clearCart();
    ScaffoldMessage(context: context, message: "Заказ передан в обработку");
    final page = ProfilePage(); Navigator.of(context).pushAndRemoveUntil(CustomPageRoute(page),(Route<dynamic> route) => false);
  }


  loadData() async{
    var supliers = await db.child("Supliers").get(); supliers_list.addAll((supliers.value as Map).values.toList());
    var brands = await db.child("Brands").get(); brands_list.addAll((brands.value as Map).values.toList());

    check_total_price();
    cartChanges();
  }


}
