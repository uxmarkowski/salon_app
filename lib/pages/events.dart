import 'package:flutter/material.dart';
import 'package:salon_app/widgets/bottom_nav_bar.dart';
import 'package:salon_app/widgets/my_app_bar.dart';



class EventPage extends StatefulWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "События", context: context, showFilter: (){}),
      body: SingleChildScrollView(
        child: Column(),
      ),
      bottomNavigationBar: MyBottomNavBar(currentIndex: 3, context: context),
    );
  }
}
