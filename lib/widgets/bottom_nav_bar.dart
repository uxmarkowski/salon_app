


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salon_app/pages/home_page.dart';
import 'package:salon_app/pages/profile.dart';

import '../main.dart';
import '../pages/order/cart.dart';
import '../pages/catalog/catalog.dart';
import '../pages/events.dart';
import 'custom_route.dart';

BottomNavigationBar MyBottomNavBar({required currentIndex,required context}) {
  return BottomNavigationBar(
    currentIndex: currentIndex,
    onTap: (index){
      if(index==0) { 
        final page = HomePage(); Navigator.of(context).pushAndRemoveUntil(CustomPageRoute(page),(Route<dynamic> route) => false);
        // Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
      }
      if(index==1) {
        final page = CatalogPage(); Navigator.of(context).pushAndRemoveUntil(CustomPageRoute(page),(Route<dynamic> route) => false);
        // Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => CatalogPage()), (route) => false);
      }
      if(index==2) {
        final page = CartPage(); Navigator.of(context).pushAndRemoveUntil(CustomPageRoute(page),(Route<dynamic> route) => false);
        // Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => CartPage()), (route) => false);
      }
      if(index==3) {
        final page = EventPage(); Navigator.of(context).pushAndRemoveUntil(CustomPageRoute(page),(Route<dynamic> route) => false);
        // Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => EventPage()), (route) => false);
      }
      if(index==4) {
        final page = ProfilePage(); Navigator.of(context).pushAndRemoveUntil(CustomPageRoute(page),(Route<dynamic> route) => false);
        // Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => ProfilePage()), (route) => false);
      }

    },
    items: [
      BottomNavigationBarItem(
        activeIcon: Padding(padding: const EdgeInsets.only(bottom: 2.0,top: 4.0), child: SvgPicture.asset("lib/assets/icons/bold/Home.svg",color: PrimaryColors,), ),
        icon: Padding(padding: const EdgeInsets.only(bottom: 2.0,top: 4.0), child: SvgPicture.asset("lib/assets/icons/bold/Home.svg"), ),
        label: "Главная",
      ),
      BottomNavigationBarItem(
          activeIcon: Padding(padding: const EdgeInsets.only(bottom: 2.0,top: 4.0), child: SvgPicture.asset("lib/assets/icons/bold/Document.svg",color: PrimaryColors,), ),
          icon: Padding(padding: const EdgeInsets.only(bottom: 2.0,top: 4.0), child: SvgPicture.asset("lib/assets/icons/bold/Document.svg"), ),
          label: "Каталог"
      ),
      BottomNavigationBarItem(
            activeIcon: Padding(padding: const EdgeInsets.only(bottom: 2.0,top: 4.0), child: SvgPicture.asset("lib/assets/icons/bold/Shopping Cart.svg",color: PrimaryColors,), ),
          icon: Padding(padding: const EdgeInsets.only(bottom: 2.0,top: 4.0), child: SvgPicture.asset("lib/assets/icons/bold/Shopping Cart.svg"), ),
          label: "Корзина"
      ),
      BottomNavigationBarItem(
          activeIcon: Padding(padding: const EdgeInsets.only(bottom: 2.0,top: 4.0), child: SvgPicture.asset("lib/assets/icons/bold/Notification.svg",color: PrimaryColors,), ),
          icon: Padding(padding: const EdgeInsets.only(bottom: 2.0,top: 4.0), child: SvgPicture.asset("lib/assets/icons/bold/Notification.svg"), ),
          label: "События"
      ),
      BottomNavigationBarItem(
          activeIcon: Padding(padding: const EdgeInsets.only(bottom: 2.0,top: 4.0), child: SvgPicture.asset("lib/assets/icons/bold/user.svg",color: PrimaryColors,), ),
          icon: Padding(padding: const EdgeInsets.only(bottom: 2.0,top: 4.0), child: SvgPicture.asset("lib/assets/icons/bold/user.svg"), ),
          label: "Профиль"
      ),
    ],
    selectedFontSize: 11,
    unselectedFontSize: 11,
    selectedLabelStyle: TextStyle(fontWeight: FontWeight.w700,color: Colors.black),
    unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500,color: Colors.black),
    type: BottomNavigationBarType.fixed,
    selectedItemColor: PrimaryColors,
    elevation: 0,
    backgroundColor: CupertinoColors.systemGrey6,

  );
}