import 'dart:math';
import 'package:beginner/extensions/string_extension.dart';
import 'package:beginner/models/account.dart';
import 'package:beginner/models/question.dart';
import 'package:beginner/services/auth_service.dart';
import 'package:beginner/views/history_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timer_count_down/timer_count_down.dart';

enum AppStatus { ready, waiting }

class HomeView extends StatefulWidget {
  const HomeView({Key? key, required this.account}) : super(key: key);
  final Account account;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _questionController = TextEditingController();
  String _answer = "";
  bool _askButtonActive = false;
  final Question _question = Question();
  AppStatus? _appStatus;
  int _timeTillNextFree = 0;

  @override
  void initState() {
    super.initState();
    _timeTillNextFree = widget.account.nextFreeQuestion
            ?.difference((DateTime.now()))
            .inSeconds ??
        0;
    _giveFreeDecision(widget.account.bank, _timeTillNextFree);
  }

  @override
  Widget build(BuildContext context) {
    _setAppStatus();
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: [
            GestureDetector(
              onTap: () {},
              child: const Icon(Icons.shopping_bag),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const HistoryView()));
              },
              child: const Icon(Icons.history),
            ),
          ],
        ),
        body: SafeArea(
            child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Text('Decisions left: ${widget.account.bank}'),
              _nextFreeCountDown(),
              _buildQuestionForm(),
              const Spacer(),
              const Text('Account Type: Free'),
              Text("${context.read<AuthService>().currentUser?.uid}")
            ],
          ),
        )),
      ),
    );
  }

  Widget _buildQuestionForm() {
    if (_appStatus == AppStatus.ready) {
      return Column(
        children: [
          Text(
            'Should I',
            style: Theme.of(context).textTheme.headline4,
          ),
          TextField(
            decoration: const InputDecoration(helperText: 'Enter A Question'),
            maxLines: null,
            keyboardType: TextInputType.multiline,
            controller: _questionController,
            textInputAction: TextInputAction.done,
            onChanged: (value) {
              setState(() {
                _askButtonActive = value.isNotEmpty ? true : false;
              });
            },
          ),
          ElevatedButton(
            onPressed: _askButtonActive == true ? _answerQuestion : null,
            child: const Text('Ask'),
          ),
          _questionAndAnswer(),
        ],
      );
    } else {
      return _questionAndAnswer();
    }
  }

  String _getAnswer() {
    var answerOptions = ['yes', 'no', 'definitely', 'not right now'];
    return answerOptions[Random().nextInt(answerOptions.length)];
  }

  Widget _questionAndAnswer() {
    if (_answer != "") {
      return Column(children: [
        Text("Should I ${_question.query}?"),
        Text("Answer: ${_answer.capitalize()}"),
      ]);
    } else {
      return Container();
    }
  }

  Widget _nextFreeCountDown() {
    if (_appStatus == AppStatus.waiting) {
      return Column(
        children: [
          const Text('You will get one free decision in'),
          Countdown(
            seconds: _timeTillNextFree,
            build: (BuildContext context, double time) => Text('$time'),
            interval: const Duration(seconds: 1),
            onFinished: () {
              _giveFreeDecision(widget.account.bank, 0);
              setState(() {
                _timeTillNextFree = 0;
                _appStatus = AppStatus.ready;
              });
            },
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  void _setAppStatus() {
    if (widget.account.bank > 0) {
      setState(() {
        _appStatus = AppStatus.ready;
      });
    } else {
      setState(() {
        _appStatus = AppStatus.waiting;
      });
    }
  }

  void _giveFreeDecision(currentBank, timeTillNextFree) {
    if (currentBank <= 0 && timeTillNextFree <= 0) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(widget.account.uid)
          .update({'bank': 1});
    }
  }

  void _answerQuestion() async {
    setState(() {
      _answer = _getAnswer();
    });

    _question.query = _questionController.text;
    _question.answer = _answer;
    _question.created = DateTime.now();

    await FirebaseFirestore.instance
        .collection('users')
        .doc(context.read<AuthService>().currentUser?.uid)
        .collection('question')
        .add(_question.toJson());

    widget.account.bank -= 1;
    widget.account.nextFreeQuestion =
        DateTime.now().add(const Duration(seconds: 20));
    setState(() {
      _timeTillNextFree = widget.account.nextFreeQuestion
              ?.difference((DateTime.now()))
              .inSeconds ??
          0;
      if (widget.account.bank == 0) {
        _appStatus = AppStatus.waiting;
      }
    });

    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.account.uid)
        .update(widget.account.toJson());

    _questionController.text = "";
  }
}
