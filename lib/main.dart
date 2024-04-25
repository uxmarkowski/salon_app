import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:salon_app/pages/catalog/catalog.dart';
import 'package:salon_app/pages/catalog/product.dart';
import 'package:salon_app/pages/profile.dart';
import 'package:salon_app/pages/sign/sign_up.dart';
import 'package:salon_app/widgets/hive_metod.dart';

import 'firebase_options.dart';

Color PrimaryColors=Color.fromRGBO(153, 0, 255, 1);
FirebaseAuth auth = FirebaseAuth.instance;
DatabaseReference db = FirebaseDatabase.instance.ref();
var model=hive_example();

void main() async{
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  var UserStatus=await FirebaseAuth.instance.currentUser;
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
      MyApp(user_status: UserStatus,)
  );
}

class MyApp extends StatelessWidget {
  final user_status;
  const MyApp({super.key,required this.user_status});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "OpenSans"
      ),
      home: user_status==null ? SignUpPage(is_sign_up: true,) : ProfilePage(),
    );
  }
}

