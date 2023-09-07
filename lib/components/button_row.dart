import 'package:flutter/material.dart';
import 'button.dart';

/// Componente que será responsável por montar uma linha de botões.
class ButtonRow extends StatelessWidget {

  /// Lista de botões a serem buildados.
  final List<Button> buttons;

  /// Construtor do componente.
  const ButtonRow(this.buttons, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: buttons.fold(<Widget>[], (list, b) {
          list.isEmpty
              ? list.add(b)
              : list.addAll([
                  const SizedBox(
                    width: 1,
                  ),
                  b
                ]);
          return list;
        }),
      ),
    );
  }
}
