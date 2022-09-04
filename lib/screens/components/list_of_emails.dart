import 'package:customer_calendar/screens/components/constants.dart';
import 'package:customer_calendar/models/email.dart';
import 'package:customer_calendar/screens/components/email_card.dart';
import 'package:customer_calendar/screens/components/side_menu.dart';
import 'package:customer_calendar/screens/email_screen.dart';
import 'package:customer_calendar/screens/responsive.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class ListOfEmails extends StatefulWidget {
  const ListOfEmails({Key? key}) : super(key: key);

  @override
  State<ListOfEmails> createState() => _ListOfEmailsState();
}

class _ListOfEmailsState extends State<ListOfEmails> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      drawer: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 250),
        child: const SideMenu(),
      ),
      body: Container(
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      _scaffoldkey.currentState?.openDrawer();
                    },
                    icon: const Icon(Icons.menu),
                  ),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        hintText: 'Search',
                        fillColor: kBgLightColor,
                        filled: true,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(8),
                          child: WebsafeSvg.asset(
                            'assets/Icons/Search.svg',
                            width: 24,
                          ),
                        ),
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: kDefaultPadding / 2),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Row(
                  children: [
                    WebsafeSvg.asset('assets/Icons/Angle down.svg',
                        width: 16, color: Colors.black),
                    const SizedBox(width: 5),
                    const Text('Sort by date'),
                    const Spacer(),
                    MaterialButton(
                      minWidth: 20,
                      onPressed: () {},
                      child:
                          WebsafeSvg.asset('assets/Icons/Sort.svg', width: 15),
                    )
                  ],
                ),
              ),
              //const SizedBox(height: kDefaultPadding / 2),
              Expanded(
                child: ListView.builder(
                  itemCount: emails.length,
                  itemBuilder: ((context, index) => EmailCard(
                        isActive:
                            Responsive.isMobile(context) ? false : index == 0,
                        email: emails[index],
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EmailScreen(email: emails[index]),
                            ),
                          );
                        },
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
