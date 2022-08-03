import 'package:beginner/models/account.dart';
import 'package:beginner/services/auth_service.dart';
import 'package:beginner/views/home_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await AuthService().getOrCreateUser();
  runApp(MultiProvider(
    providers: [Provider.value(value: AuthService())],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(context.read<AuthService>().currentUser?.uid)
            .snapshots(),
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
