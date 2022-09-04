import 'package:customer_calendar/models/email.dart';
import 'package:customer_calendar/screens/responsive.dart';
import 'package:flutter/material.dart';

class EmailScreen extends StatelessWidget {
  const EmailScreen({Key? key, required this.email}) : super(key: key);
  final Email email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: SafeArea(
        child: Column(children: [
          Expanded(
              child: SingleChildScrollView(
            child: Row(
              children: [
                if (Responsive.isMobile(context)) const BackButton(),
              ],
            ),
          ))
        ]),
      )),
    );
  }
}
