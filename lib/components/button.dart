import 'package:flutter/material.dart';

/// Componente que será responsável por exibir os botões presentes em nossa calculadora.
class Button extends StatelessWidget {

  /// Cor mais escura do botão
  static const dark = Color.fromRGBO(82, 82, 82, 1);

  /// Cor padrão do botão
  static const defaultColor = Color.fromRGBO(112, 112, 112, 1);

  /// Cor dos botões de operação
  static const operationColor = Color.fromRGBO(250, 158, 13, 1);

  /// Texto do botão
  final String text;

  /// Se o botão será maior que os demais
  final bool big;

  /// Cor do botão
  final Color color;

  /// Callback do botão
  final void Function(String) cb;

  /// Construtor padrão do botão.
  const Button({
    super.key,
    this.color = defaultColor,
    required this.text,
    this.big = false,
    required this.cb,
  });

  /// Construtor quando o botão precisar ser um pouco maior que os demais
  /// utilizado no botão [AC e 0].
  const Button.big({
    super.key,
    this.color = defaultColor,
    required this.text,
    this.big = true,
    required this.cb,
  });

  /// Construtor para os botões de operações, eles possuem uma cor diferente
  /// dos demais botões.
  const Button.operation({
    super.key,
    this.color = operationColor,
    required this.text,
    this.big = false,
    required this.cb,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: big ? 2 : 1,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(color),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
            ),
          ),
        ),
        onPressed: () => cb(text),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.w200,
          ),
        ),
      ),
    );
  }
}
