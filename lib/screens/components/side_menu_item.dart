import 'package:customer_calendar/screens/components/constants.dart';
import 'package:customer_calendar/screens/components/counter_badge.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class SideMenuItem extends StatelessWidget {
  const SideMenuItem(
      {Key? key,
      required this.isActive,
      this.isHover = false,
      this.showBorder = true,
      this.itemCount,
      required this.iconSrc,
      required this.title,
      required this.press})
      : super(key: key);

  final bool isActive, isHover, showBorder;
  final int? itemCount;
  final String iconSrc, title;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Row(
        children: [
          (isActive || isHover)
              ? WebsafeSvg.asset(
                  "assets/Icons/Angle right.svg",
                  width: 15,
                )
              : const SizedBox(width: 15),
          Expanded(
              child: Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: showBorder
                ? const BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: Color(0xFFDFE2EF))))
                : null,
            child: Row(
              children: [
                WebsafeSvg.asset(
                  iconSrc,
                  height: 20,
                  color: (isActive || isHover) ? kPrimaryColor : kGrayColor,
                ),
                const SizedBox(width: kDefaultPadding),
                Text(
                  title,
                  style: Theme.of(context).textTheme.button?.copyWith(
                        color: (isActive || isHover) ? kTextColor : kGrayColor,
                      ),
                ),
                const Spacer(),
                if (itemCount != null) CounterBadge(count: itemCount!)
              ],
            ),
          ))
        ],
      ),
    );
  }
}
