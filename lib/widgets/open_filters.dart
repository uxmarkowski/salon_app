import 'dart:ui';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salon_app/main.dart';
import 'package:salon_app/pages/order/order_settings.dart';

import 'catalog/rounded_container_widget.dart';


Future<Map> ShowFilters({required context,required suplierList,required filters,required developerList,required currentSuplier,required currentDeveloper,}) async{
  TextEditingController PriceFrom=TextEditingController();
  TextEditingController PriceTo=TextEditingController();
  if(filters["price_from"]!=0) PriceFrom.text=filters["price_from"].toString();
  if(filters["price_to"]!=0) PriceTo.text=filters["price_to"].toString();

  FocusNode priceToNode=FocusNode();
  FocusNode priceFromNode=FocusNode();
  bool change_exist=false;
  Map my_filters=Map.from(filters);

  await showCupertinoModalPopup(
    // useRootNavigator: true,
      barrierDismissible: true,
      filter: ImageFilter.blur(sigmaX: 0,sigmaY: 0),
      barrierColor: Colors.black.withOpacity(0.1),
      context: context,
      builder: (BuildContext builder) {

        return StatefulBuilder(
          key: GlobalKey(),
          builder: (context, setState){
            return CupertinoPopupSurface(
              isSurfacePainted: false,
              child: Material(
                color: CupertinoColors.white,
                child: InkWell(
                  onTap: (){
                    priceToNode.hasFocus ? priceToNode.unfocus() : null;
                    priceFromNode.hasFocus ? priceFromNode.unfocus() : null;
                  },
                  child: Container(
                      height: 620,
                      decoration: BoxDecoration(
                          color: CupertinoColors.white,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(24),topRight: Radius.circular(24))
                      ),
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 12,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Добавить фильтр ",style: TextStyle(fontFamily: "SFPro",fontSize: 24,fontWeight: FontWeight.w600),),
                              InkWell(
                                  onTap: (){
                                    Navigator.pop(context);
                                  },
                                  child: Icon(Icons.close,size: 32,)
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                          Text("Сортировка ",style: TextStyle(fontFamily: "SFPro",fontSize: 14,fontWeight: FontWeight.w500,color: Colors.black.withOpacity(0.66)),),
                          SizedBox(height: 12),
                          Row(
                            children: [
                              InkWell(onTap: (){setState((){ my_filters['sorting_type']="popular";});},child: RoundedContainerr(is_current_category:  my_filters['sorting_type']=="popular", text: "Популярность")),
                              SizedBox(width: 12,),
                              InkWell(onTap: (){setState((){ my_filters['sorting_type']="price_up";});},child: RoundedContainerr(is_current_category: my_filters['sorting_type']=="price_up", text: "Возростание цены")),

                            ],
                          ),
                          SizedBox(height: 12),
                          Row(
                            children: [
                              InkWell(onTap: (){setState((){ my_filters['sorting_type']="price_down";});},child: RoundedContainerr(is_current_category: my_filters['sorting_type']=="price_down", text: "Убывание цены")),
                              Spacer()
                            ],
                          ),
                          SizedBox(height: 20),
                          Text("Цена (₽)",style: TextStyle(fontFamily: "SFPro",fontSize: 14,fontWeight: FontWeight.w500,color: Colors.black.withOpacity(0.66)),),
                          SizedBox(height: 12),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  color: CupertinoColors.systemGrey5,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                height: 48,
                                width: (MediaQuery.of(context).size.width-16*3)/2,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  maxLength: 7,
                                  controller: PriceFrom,
                                  focusNode: priceFromNode,
                                  decoration: InputDecoration(
                                    counterText: "",
                                    border: InputBorder.none,
                                    prefixIcon: Text("От: ",style: TextStyle(fontSize: 16),),
                                    prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                                  ),
                                  onChanged: (value){
                                    my_filters['price_from']=value.isNotEmpty ? int.parse(value) : 0;
                                  },
                                ),
                              ),
                              SizedBox(width: 16,),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  color: CupertinoColors.systemGrey5,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                height: 48,
                                width: (MediaQuery.of(context).size.width-16*3)/2,
                                child: TextFormField(
                                  maxLength: 7,
                                  keyboardType: TextInputType.number,
                                  controller: PriceTo,
                                  focusNode: priceToNode,
                                  decoration: InputDecoration(
                                      counterText: "",
                                      border: InputBorder.none,
                                      prefixIcon: Text("До: ",style: TextStyle(fontSize: 16),),
                                      prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                                  ),
                                  onChanged: (value){
                                    my_filters['price_to']=value.isNotEmpty ? int.parse(value) : 0;
                                  },
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                          Text("Производитель ",style: TextStyle(fontFamily: "SFPro",fontSize: 14,fontWeight: FontWeight.w500,color: Colors.black.withOpacity(0.66)),),
                          SizedBox(height: 12),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 0,vertical: 0),
                            decoration: BoxDecoration(
                                border: Border.all(width: 1,color: Colors.black26),
                                borderRadius: BorderRadius.circular(8)
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                isExpanded: true,
                                hint: Text('Выберите поставщика', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Theme.of(context).hintColor,),),
                                items: (suplierList as List<dynamic>).map((item) => DropdownMenuItem<String>(
                                  value: item['name'],
                                  child: Text(item['name'], style: const TextStyle(fontSize: 16)),
                                )).toList(),
                                value: currentSuplier['name'],
                                onChanged: (value) {

                                  setState(() {  currentSuplier = (suplierList as List).firstWhere((element) => element["name"]==value);  });
                                  my_filters['suplier']=currentSuplier = (suplierList as List).firstWhere((element) => element["name"]==value);
                                },
                                dropdownStyleData: DropdownStyleData(maxHeight: 300, decoration: BoxDecoration(borderRadius: BorderRadius.circular(12))),
                                buttonStyleData: const ButtonStyleData(
                                  padding: EdgeInsets.symmetric(horizontal: 16), height: 48, width: 140,),
                                menuItemStyleData: const MenuItemStyleData(height: 40,),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Text("Бренд ",style: TextStyle(fontFamily: "SFPro",fontSize: 14,fontWeight: FontWeight.w500,color: Colors.black.withOpacity(0.66)),),
                          SizedBox(height: 12),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 0,vertical: 0),
                            decoration: BoxDecoration(
                                border: Border.all(width: 1,color: Colors.black26),
                                borderRadius: BorderRadius.circular(8)
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                isExpanded: true,
                                hint: Text('Выберите поставщика', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Theme.of(context).hintColor,),),
                                items: (developerList as List<dynamic>).map((item) => DropdownMenuItem<String>(
                                  value: item['name'],
                                  child: Text(item['name'], style: const TextStyle(fontSize: 16)),
                                )).toList(),
                                value: currentDeveloper['name'],
                                onChanged: (value) {

                                  setState(() {  currentDeveloper = (developerList as List).firstWhere((element) => element["name"]==value);  });
                                  my_filters['brand']=currentDeveloper = (developerList as List).firstWhere((element) => element["name"]==value);
                                },
                                dropdownStyleData: DropdownStyleData(maxHeight: 300, decoration: BoxDecoration(borderRadius: BorderRadius.circular(12))),
                                buttonStyleData: const ButtonStyleData(
                                  padding: EdgeInsets.symmetric(horizontal: 16), height: 48, width: 140,),
                                menuItemStyleData: const MenuItemStyleData(height: 40,),
                              ),
                            ),
                          ),
                          SizedBox(height: 24),
                          InkWell(
                            onTap: (){
                              Navigator.pop(context,true);
                            },
                            child: Container(
                              height: 56,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: mainColor,
                                borderRadius: BorderRadius.circular(12)
                              ),
                              child: Center(child: Text("Применить",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.white),)),
                            ),
                          )

                        ],
                      )
                  ),
                ),
              ),
            );
          },
        );
      }
  ).then((value) {
    print("Value "+value.toString());
    print("Filter value "+my_filters.toString());
    change_exist=value==null ? false : true;
  });

  return change_exist ? my_filters : {};
}

