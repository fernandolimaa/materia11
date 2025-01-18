import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora Flutter Web',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String displayText = '';
  String result = '';

  void appendToDisplay(String value) {
    setState(() {
      displayText += value;
    });
  }

  void clearDisplay() {
    setState(() {
      displayText = '';
      result = '';
    });
  }

  void calculateResult() {
    try {
      final expression = Expression.parse(displayText);
      final evaluator = ExpressionEvaluator();
      final resultValue = evaluator.eval(expression, {});
      setState(() {
        result = resultValue.toString();
      });
    } catch (e) {
      setState(() {
        result = 'Erro';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora Flutter Web'),
      ),
      body: Center(
        child: Container(
          width: 400,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: Colors.grey, blurRadius: 10, offset: Offset(0, 5))
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Exibição do resultado (mais visível)
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 10),
                color: Colors.black,
                child: Text(
                  result,
                  style: TextStyle(fontSize: 48, color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.right,
                ),
              ),
              SizedBox(height: 10),
              
              // Exibição da expressão sendo digitada (cinza)
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 10),
                color: Colors.grey[200],
                child: Text(
                  displayText,
                  style: TextStyle(fontSize: 32, color: Colors.grey[700]),
                  textAlign: TextAlign.right,
                ),
              ),
              SizedBox(height: 20),

              // Grade de botões
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 16,
                itemBuilder: (context, index) {
                  String label = '';
                  if (index == 0) label = '7';
                  if (index == 1) label = '8';
                  if (index == 2) label = '9';
                  if (index == 3) label = '/';
                  if (index == 4) label = '4';
                  if (index == 5) label = '5';
                  if (index == 6) label = '6';
                  if (index == 7) label = '*';
                  if (index == 8) label = '1';
                  if (index == 9) label = '2';
                  if (index == 10) label = '3';
                  if (index == 11) label = '-';
                  if (index == 12) label = '0';
                  if (index == 13) label = '.';
                  if (index == 14) label = '=';
                  if (index == 15) label = '+';

                  return _buildButton(label);
                },
              ),
              SizedBox(height: 20),

              // Botão de clear
              ElevatedButton(
                onPressed: clearDisplay,
                child: Text('C'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: Size(double.infinity, 60),
                  textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String label) {
    Color buttonColor = (label == '=' || label == '/' || label == '*' || label == '-' || label == '+')
        ? Colors.orange
        : Colors.blue;

    return InkWell(
      onTap: () {
        if (label == '=') {
          calculateResult();
        } else {
          appendToDisplay(label);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
