import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer_calendar/models/account.dart';
import 'package:customer_calendar/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class EventForm extends StatefulWidget {
  const EventForm({Key? key, required this.account}) : super(key: key);
  final Account account;

  @override
  State<EventForm> createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      children: [


        ElevatedButton(
            child: const Text('Use'),
            onPressed: () async {
              FirebaseFirestore.instance
                  .collection('users_c')
                  .doc(context.read<AuthService>().currentUser?.uid);
              widget.account.detail_2 += 1;
              
              await FirebaseFirestore.instance
                  .collection('users_c')
                  .doc(widget.account.uid)
                  .update(widget.account.toJson());
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            })
      ],
    ));
  }
}
