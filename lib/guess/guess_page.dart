import 'package:flutter/material.dart';
import 'dart:math';
import './result_notice.dart';
import './guess_app_bar.dart';

class GuessPage extends StatefulWidget {
  const GuessPage({super.key, required this.title});
  final String title;

  @override
  State<GuessPage> createState() => _GuessPageState();
}

class _GuessPageState extends State<GuessPage> {
  int _value = 0;
  final _random = Random();
  void _generateRandomValue() {
    setState(() {
      _value = _random.nextInt(100);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GuessAppBar(),
      body: Stack(children: [
        const Column(
          children: [
            ResultNotice(
              color: Colors.red,
              info: '大了',
            ),
            ResultNotice(
              color: Colors.blue,
              info: '小了',
            )
          ],
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                '生成的随机数:',
              ),
              Text(
                '$_value',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        )
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: _generateRandomValue,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
