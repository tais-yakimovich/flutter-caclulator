import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart'; // External package for expression evaluation
import 'calculator_button.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _expression = '';
  String _result = '';

  void _onPressed(String value) {
    setState(() {
      if (value == '=') {
        try {
          final expression = Expression.parse(_expression);
          final evaluator = const ExpressionEvaluator();
          _result = evaluator.eval(expression, {}).toString();
          _expression += ' = $_result';
        } catch (e) {
          _result = 'Error';
        }
      } else if (value == 'C') {
        _expression = '';
        _result = '';
      } else if (value == '^2') {
        try {
          final expression = Expression.parse('($_expression) * ($_expression)');
          final evaluator = const ExpressionEvaluator();
          _result = evaluator.eval(expression, {}).toString();
          _expression += '^2 = $_result';
        } catch (e) {
          _result = 'Error';
        }
      } else if (value == '%') {
        _expression += '%';
      } else {
        _expression += value;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator Taisa Yakimovich',
        style: TextStyle(
          color: Colors.white,
        ), ),
        backgroundColor: Colors.brown[500],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(16),
              child: Text(
                _expression,
                style: TextStyle(
                  fontSize: 32, 
                  fontWeight: FontWeight.bold),
                textAlign: TextAlign.right,
              ),
            ),
          ),
          Divider(),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                _buildRow(['7', '8', '9', '/']),
                _buildRow(['4', '5', '6', '*']),
                _buildRow(['1', '2', '3', '-']),
                _buildRow(['C', '0', '=', '+']),
                _buildRow(['^2', '%']),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(List<String> values) {
    return Row(
      children: values
          .map((value) => calcButton(value: value, onPressed: _onPressed))
          .toList(),
    );
  }
}
