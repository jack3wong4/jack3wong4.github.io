import 'package:beginner/models/question.dart';
import 'package:beginner/services/auth_service.dart';
import 'package:beginner/views/helpers/question_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  List<Object> _historyList = [];

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    getUserQuestionsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Past Decisions')),
      body: SafeArea(
        child: ListView.builder(
          itemCount: _historyList.length,
          itemBuilder: (context, index) {
            return QuestCard(_historyList[index] as Question);
          },
        ),
      ),
    );
  }

  Future getUserQuestionsList() async {
    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc(context.read<AuthService>().currentUser?.uid)
        .collection('question')
        .orderBy('created', descending: true)
        .get();

    setState(() {
      _historyList =
          List.from(data.docs.map((doc) => Question.fromSnapshot(doc)));
    });
    
    print(_historyList.toList());
  }
}
