import 'package:intl/intl.dart';
import 'package:beginner/extensions/string_extension.dart';
import 'package:beginner/models/question.dart';
import 'package:flutter/material.dart';

class QuestCard extends StatelessWidget {
  const QuestCard(this._question, {Key? key}) : super(key: key);
  final Question _question;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text('Should I ${_question.query}?'),
                ),
              ],
            ),
            Row(
              children: [
                Text(_question.answer!.capitalize()),
                const Spacer(),
                Text(DateFormat('yyyy-MM-dd').format(_question.created!)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
