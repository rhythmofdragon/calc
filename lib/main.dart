import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String displayTxt = '0';
  String result = '';
  double numOne = 0;
  double numTwo = 0;
  String operation = '';
  String previousOperation = '';

  void calculate(String buttonText) {
    try {
      if (buttonText == 'AC') {
        displayTxt = '0';
        numOne = 0;
        numTwo = 0;
        result = '';
        operation = '';
        previousOperation = '';
      } else if (buttonText == '+/-') {
        displayTxt.startsWith('-')
            ? displayTxt = displayTxt.substring(1)
            : displayTxt = '-$displayTxt';
      } else if (buttonText == '%') {
        numOne = double.parse(displayTxt);
        result = (numOne / 100).toString();
        displayTxt = doesContainDecimal(result);
      } else if (buttonText == '+' ||
          buttonText == '-' ||
          buttonText == 'x' ||
          buttonText == '/') {
        if (result.isNotEmpty) {
          numOne = double.parse(result);
        } else {
          numOne = double.parse(displayTxt);
        }
        operation = buttonText;
        displayTxt = '';
      } else if (buttonText == '=') {
        numTwo = double.parse(displayTxt);
        if (operation == '+') {
          result = (numOne + numTwo).toString();
        } else if (operation == '-') {
          result = (numOne - numTwo).toString();
        } else if (operation == 'x') {
          result = (numOne * numTwo).toString();
        } else if (operation == '/') {
          if (numTwo == 0) {
            displayTxt = 'Error';
            return;
          }
          result = (numOne / numTwo).toString();
        }
        displayTxt = doesContainDecimal(result);
        operation = '';
      } else {
        if (displayTxt == '0' || operation.isNotEmpty) {
          displayTxt = buttonText;
        } else {
          displayTxt += buttonText;
        }
      }
    } on FormatException {
      displayTxt = 'Error';
    }

    setState(() {});
  }

  String doesContainDecimal(String result) {
    if (result.contains('.')) {
      List<String> splitDecimal = result.split('.');
      if (!(int.parse(splitDecimal[1]) > 0)) return splitDecimal[0];
    }
    return result;
  }

  Widget calcButton(String btnText, Color? color, Color textColor) {
    return Container(
      child: ElevatedButton(
        onPressed: () {
          calculate(btnText);
        },
        child: Text(
          '$btnText',
          style: TextStyle(
            fontSize: 35,
            color: textColor,
          ),
        ),
        style: ButtonStyle(
          backgroundColor: color != null ? MaterialStateProperty.all(color) : null,
          shape: MaterialStateProperty.all(CircleBorder()),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Calculator'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      '$displayTxt',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 100,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcButton('AC', Colors.grey, Colors.black),
                calcButton('+/-', Colors.grey, Colors.black),
                calcButton('%', Colors.grey, Colors.black),
                calcButton('/', Colors.amber[700], Colors.white),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcButton('7', Colors.grey[850], Colors.white),
                calcButton('8', Colors.grey[850], Colors.white),
                calcButton('9', Colors.grey[850], Colors.white),
                calcButton('x', Colors.amber[700], Colors.white),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcButton('4', Colors.grey[850], Colors.white),
                calcButton('5', Colors.grey[850], Colors.white),
                calcButton('6', Colors.grey[850], Colors.white),
                calcButton('-', Colors.amber[700], Colors.white),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcButton('1', Colors.grey[850], Colors.white),
                calcButton('2', Colors.grey[850], Colors.white),
                calcButton('3', Colors.grey[850], Colors.white),
                calcButton('+', Colors.amber[700], Colors.white),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    calculate('0');
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.grey[850]),
                    shape: MaterialStateProperty.all(StadiumBorder()),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(34, 20, 128, 20),
                    child: Text(
                      '0',
                      style: TextStyle(fontSize: 35, color: Colors.white),
                    ),
                  ),
                ),
                calcButton('.', Colors.grey[850], Colors.white),
                calcButton('=', Colors.amber[700], Colors.white),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}



