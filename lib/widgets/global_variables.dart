import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';


class GlobalProvider extends ChangeNotifier {

  List Cart = [];

  void updateCart(List cart) {
    Cart = cart;
    notifyListeners();
  }


}



