import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../main.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/catalog/catalog_card_widget.dart';
import '../../widgets/custom_route.dart';
import '../../widgets/my_app_bar.dart';
import 'catalog_by_category.dart';



class CatalogPage extends StatefulWidget {
  const CatalogPage({Key? key}) : super(key: key);

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  TextEditingController SearchController=TextEditingController();

  List category_value=[];
  List category_value_copy=[];

  void getCategoriesAndSubcategories() async{
    var category_snapshot = await db.child("Category").get();
    category_value=(category_snapshot.value as Map).values.toList(); // Получение данных в редактируемый массив
    category_value_copy = List.from(category_value.map((categoryMap) => Map.from(categoryMap)));

    setState(() {  });
  }

  @override
  void initState() {
    getCategoriesAndSubcategories();


    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Каталог товаров", context: context, showFilter: (){}),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24,),
            CupertinoSearchTextField(
              controller: SearchController,
              placeholder: "Поиск",
              onChanged: (value) => setState(() {

                if (value.isNotEmpty) {
                  category_value = List.from(category_value_copy.map((categoryMap) => Map.from(categoryMap)));

                  category_value.forEach((categoryMap) {
                    Map subcategories = Map.from(categoryMap['subcategory']);
                    subcategories.removeWhere((key, subcategory) =>
                    !subcategory['header'].toString().toLowerCase().startsWith(value.toLowerCase()));
                    categoryMap['subcategory'] = subcategories;
                  });
                } else {
                  category_value = List.from(category_value_copy.map((categoryMap) => Map.from(categoryMap)));
                }
                setState(() {  });

              }),
            ),
            SizedBox(height: 24,),

            ListView.separated(
              shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: category_value.length,
                separatorBuilder: (context,index){return SizedBox(height: 24);},
                itemBuilder: (context,index) {
                  return (category_value[index]['subcategory'] as Map).values.length==0 ? SizedBox(height: 0,width: 0,) : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text( category_value[index]["name"].toString(),style: TextStyle(fontSize: 24,fontWeight: FontWeight.w600),),
                      SizedBox(height: 8,),
                      GridView.builder(
                        itemCount: (category_value[index]['subcategory'] as Map).values.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 1.6)),
                        itemBuilder: (BuildContext context, int index_two) {
                          return InkWell(
                            onTap: (){
                              final page = CatalogByCategoryPage(
                                  categories: category_value_copy,
                                  category_id: category_value[index]['id'],
                                  subcategory_id: (category_value[index]['subcategory'] as Map).values.toList()[index_two]['id'],
                              );
                              Navigator.of(context).push(CupertinoPageRoute(builder: (context){ return page; }));
                            },
                            child: CatalogCard(data: (category_value[index]['subcategory'] as Map).values.toList()[index_two]),
                          );
                        },
                      ),
                    ],
                  );
                }
            ),
            SizedBox(height: 36,),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavBar(currentIndex: 1, context: context),
    );
  }



}
