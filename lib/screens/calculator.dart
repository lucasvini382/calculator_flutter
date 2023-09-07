import 'package:calculator_flutter/components/display.dart';
import 'package:calculator_flutter/components/keyboard.dart';
import 'package:calculator_flutter/models/memory.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Tela que une o display com o teclado da calculadora.
class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final Memory memory = Memory();

  _onPressed(String command) {
    setState(() {
      memory.applyCommand(command);
    });
  }

  @override
  Widget build(BuildContext context) {

    /// Seta a orientação da aplicação como retrato.
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);

    return MaterialApp(
      home: Column(
        children: [
          Display(memory.value),
          Keyboard(_onPressed),
        ],
      ),
    );
  }
}
