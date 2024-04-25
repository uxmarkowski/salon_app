import 'package:flutter/material.dart';
import 'package:salon_app/widgets/my_app_bar.dart';

import '../main.dart';
import '../widgets/bottom_nav_bar.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Главная", context: context, showFilter: (){}),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ElevatedButton(onPressed: (){
            //   var newid=DateTime.now().millisecondsSinceEpoch.toString();
            //   var newids=DateTime.now().add(Duration(minutes: 1)).millisecondsSinceEpoch.toString();
            //
            //   db.child("Brands").child(newid).set({
            //     "id":newid,
            //     "name":"Бренд 1",
            //   });
            //
            //   db.child("Brands").child(newids).set({
            //     "id":newid,
            //     "name":"Бренд 2",
            //   });
            //
            //   // db.child("Supliers").child(newid).set({
            //   //   "id":newid,
            //   //   "name":"Бьютилог",
            //   //   "description":"Компания ООО «Русская косметика» выступила генеральным спонсором VIII Конференции «Логистика парфюмерно-косметической продукции» БьютиЛог-2022",
            //   //   "logo_link":"https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.artstation.com%2Fartwork%2F49eRR8&psig=AOvVaw2gdD6vqXC5-SOfjrHbREGN&ust=1713354933266000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCOiLoNTWxoUDFQAAAAAdAAAAABAS",
            //   //   "delivery_time_days":4,
            //   //   "delivery_price":2000,
            //   // });
            //   //
            //   // db.child("Supliers").child(newids).set({
            //   //   "id":newids,
            //   //   "name":"VICHY",
            //   //   "description":"Make your online skin analysis and discover the whole range of skincare products from the n°1 skincare brand in European pharmacies, Laboratoires Vichy.",
            //   //   "logo_link":"https://cdn.worldvectorlogo.com/logos/vichy-1.svg",
            //   //   "delivery_time_days":3,
            //   //   "delivery_price":1500,
            //   // });
            //
            //   // db.child("Orders").child(newid).set({
            //   //   "id":newid,
            //   //   "user_phone":auth.currentUser!.phoneNumber.toString(),
            //   //   "price":10000,
            //   //   "products":[newid],
            //   //   "suplier":"13425313",
            //   // });
            //
            //   // db.child("Products").child(newid).set({
            //   //   "id":newid,
            //   //   "name":"Syoss - Сolor Краска для волос, тон 1-1 Черный",
            //   //   "price":1000,
            //   //   "image":"https://images.apteka.ru/original_d58017d2-6887-4f88-8f79-e30760979a4a.jpeg",
            //   //   "description":"Description",
            //   //   "category":"hair",
            //   //   "sub_category":"painting",
            //   //   "suplier_id":"33212112",
            //   //   "brand_id":"33141511",
            //   // });
            //
            // }, child: Text("Не трогать"))
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavBar(currentIndex: 0, context: context),
    );
  }
}
