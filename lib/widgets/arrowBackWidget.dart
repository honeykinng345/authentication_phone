import 'package:flutter/material.dart';

class ArrowBackWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Image.asset(
        'images/arrow.png',
        height: 20,
      ),
    );
  }
}
