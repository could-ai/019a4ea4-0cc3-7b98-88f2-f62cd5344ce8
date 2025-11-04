import "package:flutter/material.dart";

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Calculator",
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      debugShowCheckedModeBanner: false,
      home: const CalculatorHomePage(),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  const CalculatorHomePage({super.key});

  @override
  State<CalculatorHomePage> createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  String _output = "0";
  String _outputHistory = "";
  double _num1 = 0;
  double _num2 = 0;
  String _operand = "";

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _output = "0";
        _outputHistory = "";
        _num1 = 0;
        _num2 = 0;
        _operand = "";
      } else if (buttonText == "+" ||
          buttonText == "-" ||
          buttonText == "/" ||
          buttonText == "x") {
        _num1 = double.parse(_output);
        _operand = buttonText;
        _outputHistory = "$_output $_operand";
        _output = "0";
      } else if (buttonText == ".") {
        if (!_output.contains(".")) {
          _output += buttonText;
        }
      } else if (buttonText == "=") {
        _num2 = double.parse(_output);
        _outputHistory += " $_output";
        if (_operand == "+") {
          _output = (_num1 + _num2).toString();
        }
        if (_operand == "-") {
          _output = (_num1 - _num2).toString();
        }
        if (_operand == "x") {
          _output = (_num1 * _num2).toString();
        }
        if (_operand == "/") {
          _output = (_num1 / _num2).toString();
        }
        _num1 = 0;
        _num2 = 0;
        _operand = "";
      } else {
        if (_output == "0") {
          _output = buttonText;
        } else {
          _output += buttonText;
        }
      }
    });
  }

  Widget _buildButton(
      String buttonText, Color buttonColor, Color textColor) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          onPressed: () => _buttonPressed(buttonText),
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            padding: const EdgeInsets.all(24.0),
            shape: const CircleBorder(),
          ),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.symmetric(
                vertical: 24.0,
                horizontal: 12.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _outputHistory,
                    style: const TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w300,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _output,
                    style: const TextStyle(
                      fontSize: 60.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(height: 1, color: Colors.grey),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: <Widget>[
                      _buildButton("C", Colors.grey[800]!, Colors.orange),
                      _buildButton("+/-", Colors.grey[800]!, Colors.white),
                      _buildButton("%", Colors.grey[800]!, Colors.white),
                      _buildButton("/", Colors.orange, Colors.white),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      _buildButton("7", Colors.grey[850]!, Colors.white),
                      _buildButton("8", Colors.grey[850]!, Colors.white),
                      _buildButton("9", Colors.grey[850]!, Colors.white),
                      _buildButton("x", Colors.orange, Colors.white),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      _buildButton("4", Colors.grey[850]!, Colors.white),
                      _buildButton("5", Colors.grey[850]!, Colors.white),
                      _buildButton("6", Colors.grey[850]!, Colors.white),
                      _buildButton("-", Colors.orange, Colors.white),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      _buildButton("1", Colors.grey[850]!, Colors.white),
                      _buildButton("2", Colors.grey[850]!, Colors.white),
                      _buildButton("3", Colors.grey[850]!, Colors.white),
                      _buildButton("+", Colors.orange, Colors.white),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ElevatedButton(
                            onPressed: () => _buttonPressed("0"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[850]!,
                              padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
                              shape: const StadiumBorder(),
                            ),
                            child: const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 16.0),
                                child: Text(
                                  "0",
                                  style: TextStyle(
                                    fontSize: 28.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      _buildButton(".", Colors.grey[850]!, Colors.white),
                      _buildButton("=", Colors.orange, Colors.white),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
