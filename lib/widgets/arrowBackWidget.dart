import 'package:flutter/material.dart';

class ArrowBackWidget extends StatelessWidget {
  final Function function;

  ArrowBackWidget({this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function != null ? function : () => Navigator.pop(context),
      child: Image.asset(
        'images/arrow.png',
        height: 20,
      ),
    );
  }
}
