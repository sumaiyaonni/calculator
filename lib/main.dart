import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _output = '0';
  String _currentNumber = '';
  double _num1 = 0;
  String _operator = '';
  bool _operatorClicked = false;

  void _handleButtonPress(String buttonText) {
    if (buttonText == 'C') {
      _clear();
    } else if (buttonText == '=') {
      _calculate();
    } else if (buttonText == '+' || buttonText == '-' || buttonText == '*' || buttonText == '/') {
      _handleOperator(buttonText);
    } else {
      _handleNumber(buttonText);
    }
  }

  void _clear() {
    setState(() {
      _output = '0';
      _currentNumber = '';
      _num1 = 0;
      _operator = '';
      _operatorClicked = false;
    });
  }

  void _handleOperator(String newOperator) {
    if (_operatorClicked) {
      _calculate();
    } else {
      _num1 = double.parse(_currentNumber);
      _currentNumber = '';
      _operatorClicked = true;
      _operator = newOperator;
      setState(() {
        _output = _output + newOperator;
      });
    }
  }

  void _handleNumber(String digit) {
    setState(() {
      _currentNumber += digit;
      _output = _currentNumber;
    });
  }

  void _calculate() {
    double num2 = double.parse(_currentNumber);
    double result;

    switch (_operator) {
      case '+':
        result = _num1 + num2;
        break;
      case '-':
        result = _num1 - num2;
        break;
      case '*':
        result = _num1 * num2;
        break;
      case '/':
        result = _num1 / num2;
        break;
      default:
        result = num2;
    }

    setState(() {
      _output = result.toString();
      _currentNumber = result.toString();
      _num1 = result;
      _operator = '';
      _operatorClicked = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<List<String>> buttonRows = [
      ['7', '8', '9', '/'],
      ['4', '5', '6', '*'],
      ['1', '2', '3', '-'],
      ['C', '0', '=', '+'],
    ];

    List<Widget> buttons = [];

    for (List<String> row in buttonRows) {
      List<Widget> rowWidgets = [];
      for (String buttonText in row) {
        rowWidgets.add(
          Expanded(
            child: InkWell(
              onTap: () {
                _handleButtonPress(buttonText);
              },
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  buttonText,
                  style: TextStyle(fontSize: 24.0),
                ),
              ),
            ),
          ),
        );
      }
      buttons.add(
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: rowWidgets,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _output,
                style: TextStyle(fontSize: 48.0),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: Column(
                children: buttons,
              ),
            ),
          ),
        ],
      ),
    );
  }
}