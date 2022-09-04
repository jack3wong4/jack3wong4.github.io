import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer_calendar/models/account.dart';
import 'package:customer_calendar/services/auth_service.dart';
import 'package:customer_calendar/views/home_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await AuthService().getOrCreateUser();
  runApp(
    MultiProvider(
      providers: [Provider.value(value: AuthService())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calendar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users_c')
            .doc(context.read<AuthService>().currentUser?.uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Account account = Account.fromSnapshot(
                snapshot.data, context.read<AuthService>().currentUser?.uid);
            return HomeView(account: account);
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
