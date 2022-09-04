import 'package:customer_calendar/models/account.dart';
import 'package:customer_calendar/screens/main_screen.dart';
import 'package:customer_calendar/services/auth_service.dart';
import 'package:customer_calendar/views/event_form.dart';
import 'package:customer_calendar/views/pick_page.dart';
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
  //AppStatus? _appStatus;
  int _timeTillNextFree = 0;

  @override
  void initState() {
    super.initState();
    _timeTillNextFree =
        widget.account.nextFreeEvent?.difference((DateTime.now())).inSeconds ??
            0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MainScreen()),
                );
              },
              icon: const Icon(Icons.book_online),
              label: const Text('')),
          ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PickReceipt()),
                );
              },
              icon: const Icon(Icons.add_alert),
              label: const Text('')),
          TextButton.icon(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                    height: 500,
                    child: Center(
                        child: Column(
                      children: [
                        EventForm(account: widget.account),
                        ElevatedButton(
                            child: const Text('Close BottomSheet'),
                            onPressed: () => Navigator.pop(context))
                      ],
                    )),
                  );
                },
              );
            },
            icon: const Icon(Icons.shopping_bag, color: Colors.white),
            label: const Text('Setting', style: TextStyle(color: Colors.white)),
          )
        ],
      ),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Text('Post-it left: ${widget.account.detail_2}'),
              _nextFreeCountDown(),
              Text('${context.read<AuthService>().currentUser?.uid}'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _nextFreeCountDown() {
    return Column(
      children: [
        Countdown(
          seconds: _timeTillNextFree,
          build: (BuildContext context, double time) => Text('$time'),
          interval: const Duration(seconds: 1),
        ),
      ],
    );
  }
}
