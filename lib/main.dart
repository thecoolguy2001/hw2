import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String display = '0'; // Display value of the calculator
  String operand = ''; // Stores the selected operator
  double firstNumber = 0; // Stores the first number
  double secondNumber = 0; // Stores the second number

  void onButtonClick(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        // Clear everything
        display = '0';
        operand = '';
        firstNumber = 0;
        secondNumber = 0;
      } else if (buttonText == '+' ||
          buttonText == '-' ||
          buttonText == '*' ||
          buttonText == '/') {
        // Set operator and store first number
        operand = buttonText;
        firstNumber = double.parse(display);
        display = '0';
      } else if (buttonText == '=') {
        // Calculate result based on the operator
        secondNumber = double.parse(display);
        switch (operand) {
          case '+':
            display = (firstNumber + secondNumber).toString();
            break;
          case '-':
            display = (firstNumber - secondNumber).toString();
            break;
          case '*':
            display = (firstNumber * secondNumber).toString();
            break;
          case '/':
            display = secondNumber == 0
                ? 'Error' // Handle division by zero
                : (firstNumber / secondNumber).toString();
            break;
        }
        operand = ''; // Reset operator
      } else if (buttonText == '.') {
        // Handle decimal point
        if (!display.contains('.')) {
          display += '.';
        }
      } else {
        // Concatenate numbers for multi-digit inputs
        display = display == '0' ? buttonText : display + buttonText;
      }
    });
  }

  Widget buildButton(String text, Color color) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(20.0), backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          onPressed: () => onButtonClick(text),
          child: Text(
            text,
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calculator')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Text(
              display,
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(),
          Row(
            children: <Widget>[
              buildButton('7', Colors.grey),
              buildButton('8', Colors.grey),
              buildButton('9', Colors.grey),
              buildButton('/', Colors.orange),
            ],
          ),
          Row(
            children: <Widget>[
              buildButton('4', Colors.grey),
              buildButton('5', Colors.grey),
              buildButton('6', Colors.grey),
              buildButton('*', Colors.orange),
            ],
          ),
          Row(
            children: <Widget>[
              buildButton('1', Colors.grey),
              buildButton('2', Colors.grey),
              buildButton('3', Colors.grey),
              buildButton('-', Colors.orange),
            ],
          ),
          Row(
            children: <Widget>[
              buildButton('0', Colors.grey),
              buildButton('.', Colors.grey),
              buildButton('C', Colors.red),
              buildButton('+', Colors.orange),
            ],
          ),
          Row(
            children: <Widget>[
              buildButton('=', Colors.green),
            ],
          ),
        ],
      ),
    );
  }
}
