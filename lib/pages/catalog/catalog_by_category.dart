import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salon_app/main.dart';
import 'package:salon_app/widgets/bottom_nav_bar.dart';
import 'package:salon_app/widgets/catalog/sorting_widget.dart';
import 'package:salon_app/widgets/my_app_bar.dart';

import '../../widgets/basic_widgets/custom_route.dart';
import '../../widgets/catalog/product_card_widget.dart';
import '../../widgets/catalog/rounded_container_widget.dart';
import '../../widgets/open_filters.dart';
import 'product.dart';


class CatalogByCategoryPage extends StatefulWidget {
  final categories;
  final category_id;
  final subcategory_id;
  const CatalogByCategoryPage({Key? key,required this.categories,required this.category_id,required this.subcategory_id}) : super(key: key);

  @override
  State<CatalogByCategoryPage> createState() => _CatalogByCategoryPageState();
}

class _CatalogByCategoryPageState extends State<CatalogByCategoryPage> {

  List sub_categories=[];
  Map current_category={
    "header": "Уход",
    "id":"123243432"
  };

  Map filters={
    "sorting_type":"popular",
    "price_from":0,
    "price_to":0,
    "brand":{"id":0,"name":"Все"},
    "suplier":{"id":0,"name":"Все"},
  };

  bool product_loading=true;
  
  List cart = [];
  List supliers_list=[{"id":0,"name":"Все"}];
  List brands_list=[{"id":0,"name":"Все"}];
  List category_list=[];
  List products=[];
  List all_products=[];


  void sorting(){
    if(filters['sorting_type']=='popular') products.sort((a,b){if(a['popularity']<b['popularity']) return 1; else return -1; });
    else if(filters['sorting_type']=='price_up') products.sort((a,b){if(a['price']<b['price']) return 1; else return -1; });
    else if(filters['sorting_type']=='price_down') products.sort((a,b){if(a['price']>b['price']) return 1; else return -1; });
    if(filters['price_from']!=0) products.removeWhere((element) => filters['price_from']<=element['price']);
    if(filters['price_to']!=0) products.removeWhere((element) => element['price']>=filters['price_to']);
    if(filters['brand']['name']!="Все") products.removeWhere((element) => filters['brand']['id']!=element['brand_id']);
    if(filters['suplier']['name']!="Все") products.removeWhere((element) => filters['suplier']['id']!=element['suplier_id']);

  }

  @override
  void initState() {
    loadData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: (widget.categories as List).firstWhere((element) => element['id']==widget.category_id)['name'],show_filter: true, context: context, showFilter: () async{
        var filters_data = await ShowFilters(context: context,filters: filters,suplierList: supliers_list, developerList: brands_list, currentSuplier: filters['suplier'], currentDeveloper: filters['brand']);
        if((filters_data as Map).length!=0) {
          filters = filters_data; products.clear();

          Future.forEach(all_products, (element) {if(element['category_id']==widget.category_id&&element['subcategory_id']==current_category['id']) products.add(element);
          }).then((value) => sorting());

        };
        setState(() {  });
      }),
      body: product_loading ? Container(width: double.infinity,height: double.infinity,padding: EdgeInsets.only(top: 56),child: Center(child: CupertinoActivityIndicator(color: PrimaryColors,))) : Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24,),
                Container(
                  height: 42,
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    shrinkWrap: true,
                      itemCount: sub_categories.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index){
                      bool is_current_category=current_category['header']==sub_categories[index]['header'];
                      return InkWell(
                        onTap: (){
                          setState(() {
                            current_category=sub_categories[index];
                            products.clear();
                            Future.forEach(all_products, (element) {
                              if(element['category_id']==widget.category_id&&element['subcategory_id']==current_category['id']) products.add(element);
                            }).then((value) => sorting());

                          });
                        },
                        child: RoundedContainerr(is_current_category: is_current_category, text: sub_categories[index]['header']),
                      );
                      },
                    separatorBuilder: (context,index){
                      return SizedBox(width: 12);
                    },
                  ),
                ),
                SizedBox(height: 12,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 12,),
                      Text(current_category['header'] ,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                      SizedBox(height: products.length==0 ? 8 : 12),
                      products.length==0 ? Text("Продуктов по данной категории пока нет") :
                      GridView.builder(
                        itemCount: products.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 1.2)),
                        itemBuilder: (BuildContext context, int index) {
                          return ProductCard(
                              context: context,
                              data: products[index],
                              increment: (){
                                setState(() { products[index]['count']=products[index]['count']+1; });
                                if(cart.where((element) => element['id']==products[index]['id']).length>0) cart.removeWhere((element) => element['id']==products[index]['id']);
                                cart.add(products[index]);
                                model.saveCart(cart);
                                },
                              decrement: (){
                                setState(() { products[index]['count']=products[index]['count']-1;products[index]['count']=max(0,products[index]['count'] as int); });
                                if(cart.where((element) => element['id']==products[index]['id']).length>0) cart.removeWhere((element) => element['id']==products[index]['id']);
                                cart.add(products[index]);
                                model.saveCart(cart);
                              }
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SortingWidget(filters: filters)
        ],
      ),
      bottomNavigationBar: MyBottomNavBar(currentIndex: 1, context: context),
    );
  }


  loadCartCount() async{
    cart=await model.getCart();
    if(products.length==0) setState(() {product_loading=false; print("false");});
    for(int i =0;i<products.length;i++) {
      if(cart.where((cart_elem) => cart_elem['id']==products[i]['id']).length>0)
        setState(() {products[i]['count']=cart.where((element) => element['id']==products[i]['id']).first['count'];product_loading=false; });

      if(i==products.length-1) setState(() {product_loading=false;});
    }


  }



  loadData() async{
    sub_categories=((widget.categories as List).firstWhere((element) => element["id"]==widget.category_id)['subcategory'] as Map).values.toList();
    sub_categories.sort((a,b){return a['id']==widget.subcategory_id ? -1 : 1;});
    current_category=sub_categories.firstWhere((element) => element['id']==widget.subcategory_id);
    setState(() { });

    var supliers = await db.child("Supliers").get(); supliers_list.addAll((supliers.value as Map).values.toList());
    var brands = await db.child("Brands").get(); brands_list.addAll((brands.value as Map).values.toList());

    loadProducts();
  }

  loadProducts() async{
    var data=await db.child("Products").get();
    all_products=(data.value as Map).values.toList();
    await Future.forEach((data.value as Map).values.toList(), (element) {
      if(element['category_id']==widget.category_id&&element['subcategory_id']==current_category['id']) products.add(element);
    });

    sorting();
    loadCartCount();
  }





}
