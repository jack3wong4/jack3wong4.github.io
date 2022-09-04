import 'package:customer_calendar/screens/components/constants.dart';
import 'package:customer_calendar/models/email.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class EmailCard extends StatefulWidget {
  const EmailCard({
    Key? key,
    required this.isActive,
    required this.email,
    required this.press,
  }) : super(key: key);

  final bool isActive;
  final Email email;
  final VoidCallback press;

  @override
  State<EmailCard> createState() => _EmailCardState();
}

class _EmailCardState extends State<EmailCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(kDefaultPadding / 2,
          kDefaultPadding / 4, kDefaultPadding / 2, kDefaultPadding / 4),
      child: InkWell(
        onTap: widget.press,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(kDefaultPadding),
              decoration: BoxDecoration(
                  color: widget.isActive ? kPrimaryColor : kBgDarkColor,
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 32,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: AssetImage(widget.email.image),
                        ),
                      ),
                      const SizedBox(width: kDefaultPadding / 2),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            text: '${widget.email.name} \n',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: widget.isActive
                                    ? Colors.white
                                    : kTextColor),
                            children: [
                              TextSpan(
                                text: widget.email.subject,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: widget.isActive
                                        ? Colors.white
                                        : kTextColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            widget.email.time,
                            style: TextStyle(
                                color: widget.isActive ? Colors.white : null),
                          ),
                          const SizedBox(height: 10),
                          if (widget.email.isAttachmentAvailable)
                            WebsafeSvg.asset('assets/Icons/Paperclip.svg',
                                color:
                                    widget.isActive ? Colors.white : kGrayColor)
                        ],
                      ),
                    ],
                  ),
                  Text(
                    widget.email.body,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        height: 1.5,
                        color: widget.isActive ? Colors.white : null),
                  )
                ],
              ),
            ),
            if (!widget.email.isChecked)
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  height: 12,
                  width: 12,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: kBadgeColor,
                  ),
                ),
              ),
            if (widget.email.tagColor != null)
              Positioned(
                left: 8,
                top: 0,
                child: WebsafeSvg.asset('assets/Icons/Markup filled.svg',
                    height: 18, color: widget.email.tagColor),
              ),
          ],
        ),
      ),
    );
  }
}
