import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salon_app/widgets/my_app_bar.dart';
import 'package:salon_app/widgets/profile/image_placeholder_widget.dart';
import 'package:salon_app/widgets/profile/profile_order_image.dart';
import 'package:salon_app/widgets/profile_field.dart';
import '../main.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/grey_button.dart';
import 'package:intl/intl.dart';



class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  TextEditingController AdressController=TextEditingController();
  TextEditingController NameController=TextEditingController();
  FocusNode AdressNode=FocusNode();
  FocusNode NameNode=FocusNode();

  bool show_save_button=false;
  bool is_load_over = false;

  List my_orders_ids=[];
  List my_orders=[];

  void GetUserData() async{
    var data = await db.child("UsersCollection").child(auth.currentUser!.phoneNumber.toString()).get();

    NameController.text = (data.value as Map).containsKey("name") ? (data.value as Map)['name'] : "";
    AdressController.text = (data.value as Map).containsKey("address") ? (data.value as Map)['address'] : "";
    my_orders_ids=(data.value as Map).containsKey("orders") ? (data.value as Map)['orders'] : [];

    if(my_orders_ids.length>0) GetOrders(my_orders_ids);
  }

  void GetOrders(my_orders_ids) async{
    var orders = await db.child("Orders").get();

    await Future.forEach(my_orders_ids, (order_id) {

      my_orders.add((orders.value as Map)[order_id]);
    });

    setState(() { is_load_over=true; });
  }

  @override
  void initState() {

    GetUserData();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Профиль",show_sign_out: true, context: context, showFilter: (){}),
      body: GestureDetector(
        onTap: (){
          AdressNode.hasFocus ? AdressNode.unfocus() : null;
          NameNode.hasFocus ? NameNode.unfocus() : null;
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.only(left: 12,right: 12,bottom: 12,top: 36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Данные для доставки", style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.black,),),
              SizedBox(height: 16),
              ProfileFiled(controller: NameController,node: NameNode,icon_name: "User information", hint: "ФИО", onchanged:  (){setState(() {show_save_button=true;  });}),
              SizedBox(height: 12),
              ProfileFiled(controller: AdressController,node: AdressNode,icon_name: "Building office", hint: "Адрес", onchanged:  (){setState(() {show_save_button=true;  });}),
              if(show_save_button) ...[
                SizedBox(height: 12),
                SaveButton(),
              ],
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Активные заказы", style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.black,),),
                  Row(
                    children: [
                      Text("Архив", style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,color: Colors.black,),),
                      Icon(CupertinoIcons.right_chevron,size: 16,color: Colors.black,)
                    ],
                  ),

                ],
              ),
              SizedBox(height: 16,),
              if(my_orders.length==0&&is_load_over) ...[
                SizedBox(height: 36,),
                Center(child: SvgPicture.asset("lib/assets/icons/bold/ShoppingCartEmpty.svg")),SizedBox(height: 8,),
                Center(child: Text("Вы не сделали ни одного заказа",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),)),
              ] else 
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: my_orders.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context,index){
                    return ProfileOrder(data: my_orders[index]);
                  }
              ),
              
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavBar(currentIndex: 4, context: context),
    );
  }

  Container ProfileOrder({required data}) {

    var status=data['status']=="wait" ? "В обработке" : data['status']=="done" ? "Доставлен" : "Передан в доставку";
    var status_color=data['status']=="done"||data['status']=="delivery" ? Colors.green : Colors.orange;
    var delivery_date=DateTime.fromMillisecondsSinceEpoch(data['delivery_date']);
    var formated_date_D=DateFormat("d").format(delivery_date).toString();
    var formated_date_M=DateFormat("MMMM").format(delivery_date).toString();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08),blurRadius: 20)]
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("№"+data['id'].toString().substring(7,10).toString()+" "+status.toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: status_color)),
              Text(data['price'].toString()+" ₽",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black.withOpacity(0.8))),
              // Text("3000 ₽ #387",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: Colors.black54)),
            ],
          ),
          SizedBox(height: 4),
          Text("Ожидаемая дата: "+formated_date_D+" "+months[formated_date_M].toString(),style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.7))),
          // Text("Ожидаемая дата: 28 января",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.7))),
          Divider(height: 24,color: Colors.black26,),
          ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: data['products'].length,
              itemBuilder: (context,index){
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Поставщик: "+data['products'][index].first['suplier'],style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,color: Colors.black.withOpacity(0.7))),
                    SizedBox(height: 8),
                    Container(
                      height: 54,
                      child: ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: min(4,data['products'][index].length),
                          itemBuilder: (context,index_two){
                            return index_two==3 ? ImagePlaceHolder() : ProfileOrderImage(data:data, index: index,index_two: index_two);
                          },
                        separatorBuilder: (context,index){ return SizedBox(height: 1,width: 4,); },
                      ),
                    ),
                  ],
                );
              },
            separatorBuilder: (context,index){
              return Divider(height: 24,color: Colors.black26,);
            },
          ),

        ],
      ),
    );
  }





  InkWell SaveButton() {
    return InkWell(
      onTap: () async{
        await db.child("UsersCollection").child(auth.currentUser!.phoneNumber.toString()).update({
          "name":NameController.text,
          "address":AdressController.text,
        });
        setState(() { show_save_button=false; });
        },
      child: Container(height: 56,width: double.infinity,decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(12)),
          child: Center(child: Text("Сохарнить",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),))),
    );
  }




}


Map months={
  "January"		: "Января",
  "February"	: "Февраля",
  "March"		: "Марта",
  "April"		: "Апреля",
  "May"			: "Мая",
  "June"		: "Июня",
  "July"		: "Июля",
  "August"		: "Августа",
  "September"	: "Сентября",
  "October"		: "Октября",
  "November"	: "Ноября",
  "December"	: "Декабря",
};