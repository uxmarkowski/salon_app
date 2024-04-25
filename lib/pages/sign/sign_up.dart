import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salon_app/pages/catalog/catalog.dart';
import 'package:salon_app/pages/sign/sign_verifiction_page.dart';
import 'package:salon_app/widgets/grey_button.dart';

import '../../main.dart';
import '../../widgets/basic_widgets/scaffold_message.dart';
import '../../widgets/custom_route.dart';
import '../../widgets/profile_field.dart';
import '../../widgets/sign/sign_phone_field.dart';




class SignUpPage extends StatefulWidget {
  final is_sign_up;
  const SignUpPage({Key? key,required this.is_sign_up}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  TextEditingController NameController=TextEditingController();
  TextEditingController PhoneController=TextEditingController();

  FocusNode NameFocus=FocusNode();
  FocusNode PhoneFocus=FocusNode();

  bool is_account_exist=false;
  bool wait_bool=false;
  bool is_user_exist=false;


  @override
  void initState() {

    is_user_exist=!widget.is_sign_up;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Color.fromRGBO(67, 0, 166, 1),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: InkWell(
          onTap: (){
            NameFocus.hasFocus ? NameFocus.unfocus() : null;
            PhoneFocus.hasFocus ? PhoneFocus.unfocus() : null;
          },
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset("lib/assets/Logo.svg"),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        SizedBox(height: 24,),
                        Text(!is_account_exist ? "Регистрация" : "Вход в сообщество",style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.w600),),
                        SizedBox(height: 24),
                        if(!is_account_exist) ...[
                          ProfileFiled(controller: NameController,node: NameFocus,icon_name: "User information", hint: "Имя", onchanged: (){}),
                          SizedBox(height: 16),
                        ],
                        SignPhoneFiled(controller: PhoneController,node: PhoneFocus,icon_name: "Phone", hint: "Номер телефона"),
                        SizedBox(height: 16),
                        SignButton(text: !is_account_exist ? "Создать аккаунт" : "Войти",color: Color.fromRGBO(238, 0, 255, 1) ,func: (){

                          if(NameController.text.length==0&&!is_account_exist) ScaffoldMessage(context: context, message: "Заполните имя");
                          else if(PhoneController.text.length==0) ScaffoldMessage(context: context, message: "Заполните телефон");
                          else {
                            final page = SignVerificationPage(nomber: PhoneController.text, name: NameController.text, is_sign_in: is_account_exist);
                            Navigator.of(context).push(CustomPageRoute(page));
                          }

                        }),
                        SizedBox(height: 8),
                        GestureDetector(
                          onTap: (){
                            setState(() { is_account_exist=!is_account_exist; });
                          },
                          child: Container(
                            height: 40,
                            width: double.infinity,
                            child: Center(
                                child: Text("Уже есть аккаунт?",style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w500),)
                            ),
                          ),
                        )

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


}
