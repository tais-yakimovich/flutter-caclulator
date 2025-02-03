import 'package:flutter/material.dart';

class calcButton extends StatelessWidget {
  final String value;
  final Function(String) onPressed;

  calcButton({required this.value, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => onPressed(value),
        style: ElevatedButton.styleFrom(
          backgroundColor: value == 'C' ? Colors.amber[500] : Colors.brown[300],
          shape: CircleBorder(),
          padding: EdgeInsets.all(20.0),
          
        ),
        child: Text(
          value,
          style: TextStyle(
            fontSize: 24, 
            fontWeight: FontWeight.bold, 
            color: Colors.white),
        ),
      ),
    );
  }
}