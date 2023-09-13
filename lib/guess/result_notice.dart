import 'package:flutter/material.dart';

class ResultNotice extends StatelessWidget {
  final Color color;
  final String info;
  const ResultNotice({Key? key, required this.color, required this.info})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            color: color,
            alignment: Alignment.center,
            child: Text(
              info,
              style: const TextStyle(
                  fontSize: 54,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )));
  }
}
