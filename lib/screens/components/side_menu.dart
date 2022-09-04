import 'package:customer_calendar/screens/components/constants.dart';
import 'package:customer_calendar/screens/components/side_menu_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      color: kBgLightColor,
      padding: const EdgeInsets.only(top: kIsWeb ? kDefaultPadding : 0),
      child: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(children: [
          Row(children: [
            Image.asset(
              "assets/images/Logo Outlook.png",
              width: 46,
            ),
            const Spacer(),
            const CloseButton(),
          ]),
          const SizedBox(height: kDefaultPadding / 2),
          TextButton.icon(
            style: TextButton.styleFrom(
              minimumSize: const Size.fromHeight(10),
              padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
              backgroundColor: kPrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {},
            icon: WebsafeSvg.asset("assets/Icons/Edit.svg", width: 16),
            label: const Text(
              'New message',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: kDefaultPadding / 2),
          TextButton.icon(
            style: TextButton.styleFrom(
              minimumSize: const Size.fromHeight(10),
              padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
              backgroundColor: kBgDarkColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {},
            icon: WebsafeSvg.asset("assets/Icons/Edit.svg", width: 16),
            label: const Text(
              'Get message',
              style: TextStyle(color: kTextColor),
            ),
          ),
          const SizedBox(height: kDefaultPadding / 2),
          SideMenuItem(
            press: () {
              print('Inbox');
            },
            title: "Inbox",
            iconSrc: "assets/Icons/Inbox.svg",
            isActive: true,
            itemCount: 10,
          ),
          const SizedBox(height: kDefaultPadding / 2),
          SideMenuItem(
            press: () {
              print('Sent');
            },
            title: "Sent",
            iconSrc: "assets/Icons/Send.svg",
            isActive: false,
            //itemCount: 10,
          ),
        ]),
      )),
    );
  }
}
