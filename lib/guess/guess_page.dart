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
  bool? _isBig; //输入结果与随机数的比较结果
  bool _guessing = false; //游戏是否开始
  final TextEditingController _guessCtrl = TextEditingController();
  final _random = Random();
  void _onCheck() {
    print('==============onCheck${_guessCtrl.text}=============');
    int? guessValue = int.tryParse(_guessCtrl.text);
    // 游戏未开始，或者输入非整数，无视
    if (!_guessing || guessValue == null) return;

    //猜对了
    if (guessValue == _value) {
      setState(() {
        _isBig = null;
        _guessing = false;
      });
      return;
    }

    // 猜错了
    setState(() {
      _isBig = guessValue > _value;
    });
  }

  void _generateRandomValue() {
    setState(() {
      _guessing = true; // 点击按钮时，表示游戏开始
      _value = _random.nextInt(100);
    });
  }

  @override
  void dispose() {
    _guessCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GuessAppBar(
        controller: _guessCtrl,
        onCheck: _onCheck,
      ),
      body: Stack(children: [
        if (_isBig != null)
          Column(
            children: [
              if (_isBig!)
                const ResultNotice(
                  color: Colors.red,
                  info: '大了',
                ),
              const Spacer(),
              if (!_isBig!)
                const ResultNotice(
                  color: Colors.blue,
                  info: '小了',
                )
            ],
          ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (!_guessing)
                const Text(
                  '生成的随机数:',
                ),
              Text(
                _guessing ? '**' : '$_value',
                style:
                    const TextStyle(fontSize: 68, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        )
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: _guessing ? null : _generateRandomValue,
        backgroundColor: _guessing ? Colors.grey : Colors.blue,
        tooltip: 'Increment',
        child: const Icon(Icons.generating_tokens_outlined),
      ),
    );
  }
}
