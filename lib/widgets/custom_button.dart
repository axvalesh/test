

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  final String text;
  final Function() onPressed;

  const CustomButton({
    required this.text,
    required this.onPressed,
  });


  @override
  Widget build(BuildContext context) {

    return (
      ElevatedButton(
        onPressed: onPressed,
        child: Text(text),
      )
    );
  }
}
