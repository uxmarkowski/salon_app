import 'package:flutter/material.dart';
import 'package:salon_app/main.dart';



Widget WidgetDenisa({required context, required isActive, required header, required function}) {
  return InkWell(
    onTap: function,
    child: Container(
      width: (MediaQuery.of(context).size.width-12*3)/2,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isActive ? PrimaryColors : Colors.white, width: 1,),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08),blurRadius: 20)]
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              header,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 24,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  header=="Доставка Яндекс" ? "1 день" : "1-3 дня",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                Container(
                  height: 20,
                  width: 20,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            color: PrimaryColors,
                            shape: BoxShape.circle
                        ),
                      ),
                      Container(
                        height: isActive ? 10 : 20,
                        width: isActive ? 10 : 20,
                        decoration: BoxDecoration(
                            color: isActive ? Colors.white : Color.fromRGBO(229, 229, 229, 1),
                            shape: BoxShape.circle
                        ),
                      )
                    ],
                  ),
                )

              ],
            )
          ],
        ),
      ),
    ),
  );
}

Widget OrderWidget({required name,required orderNumber, required price, required deliveryPrice, required deliveryTime, required products}) {
  var total_price=0;
  products.forEach((element) {total_price=total_price+(element['price'] as int)*(element['count'] as int);});


  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08),blurRadius: 20)],
        borderRadius: BorderRadius.circular(12)
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 12,vertical: 16),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                    color: PrimaryColors,
                    shape: BoxShape.circle
                ),
                child: Text(orderNumber.toString(), style: TextStyle(color: Colors.white, fontSize: 16),),
              ),
              SizedBox(width: 12,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  Text("Доставка - $deliveryPrice руб.", style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),)
                ],
              ),
              Spacer(),
              Column(
                children: [
                  SizedBox(height: 4,),
                  Text("$deliveryTime день", style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                ],
              ),
              SizedBox(width: 4,)
            ],
          ),
          SizedBox(height: 24,),
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: products.length,
              itemBuilder: (context,index){
                return ProductWidget(
                  name: products[index]["header"],
                  price: products[index]["price"],
                  link: products[index]["img"], count: products[index]["count"],
                );
              }
          ),
          SizedBox(height: 12,),
          Row(
            children: [
              Text("Стоимость заказа:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
              SizedBox(width: 8,),
              Text(total_price.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
              Text(" ₽", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
            ],
          )
        ],
      ),
    ),
  );
}

Widget ProductWidget ({required name, required price, required link,required count}) {
  return Padding(
    padding: EdgeInsets.only(bottom: 12),
    child: Row(
      children: [
        Container(
          height: 50,
          width: 50,
          child: Image.network("$link", fit: BoxFit.fill, ),
        ),
        SizedBox(width: 8,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(name, style: TextStyle(fontSize: 10,fontWeight: FontWeight.normal),),
            SizedBox(height: 4,),
            Text("${count.toString()} шт. | ${price.toString()} руб.", style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),)
          ],
        )
      ],
    ),
  );
}

Widget ChoosePayWayWidget ({required context, required name, required numberThatMeanBeActive, required id, required function}) {
  return InkWell(
    onTap: function,
    child: Container(
      width: (MediaQuery.of(context).size.width-12*4)/3,
      height: 46,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08),blurRadius: 10)],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: (numberThatMeanBeActive == id) ? PrimaryColors : Colors.white,
          width: 1
        )
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
        child: Text(name, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
      )
    ),
  );
}