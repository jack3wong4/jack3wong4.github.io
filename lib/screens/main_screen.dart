import 'package:customer_calendar/screens/components/list_of_emails.dart';
import 'package:customer_calendar/screens/responsive.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
      body: Responsive(
          mobile: ListOfEmails(),
          tablet: ListOfEmails(),
          desktop: ListOfEmails()),
    );
  }
}
