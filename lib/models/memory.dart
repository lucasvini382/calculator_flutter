/// Classe responsável por realizar toda a parte lógica da calculadora.
class Memory {
  /// Operações possíveis de serem realizadas na calculadora
  static const operations = ['%', '/', 'x', '-', '+', '='];

  /// Buffer que contém os números que serão calculados
  final _buffer = [0.0, 0.0];

  /// Indice atual do buffer (0 ou 1)
  int _bufferIndex = 0;

  /// Operação que está sendo realizada
  String? _operation;

  /// Valor que será exibido no display
  String _value = '0';

  /// Variável que será utilizada para limpar o valor exibido no display
  bool _wipeValue = false;

  /// Último comando que foi tocado no teclado
  String? _lastCommand;

  /// Função responsável por aplicar o comando que foi pressionado no Keyboard.
  void applyCommand(String command) {
    if (_isReplacingOperation(command)) {
      _operation = command;
      return;
    }

    if (command == 'AC') {
      _allClear();
    } else if (operations.contains(command)) {
      _setOperation(command);
    } else {
      _addDigit(command);
    }

    _lastCommand = command;
  }

  /// Função responsável por retornar se uma operação foi teclada por cima de
  /// outra operação
  _isReplacingOperation(String command) {
    return operations.contains(_lastCommand)
        && operations.contains(command)
        && _lastCommand != '='
        && command != '=';
  }

  /// Função responsável por setar a operação que foi teclada
  _setOperation(String newOperation) {
    if (_bufferIndex == 0) {
      _operation = newOperation;
      _bufferIndex = 1;
    } else {
      _buffer[0] = _calculate();
      _buffer[1] = 0.0;
      _value = _buffer[0].toString();
      _value = _value.endsWith('.0') ? _value.split('.')[0] : _value;

      bool isEqualSign = newOperation == '=';
      _operation = isEqualSign ? null : newOperation;
      _bufferIndex = isEqualSign ? 0 : 1;
    }

    _wipeValue = true;
  }

  /// Função responsável por adicionar um dígito no valor à ser exibido no display
  _addDigit(String digit) {
    final isDot = digit == ',';
    final wipeValue = (_value == '0' && !isDot) || _wipeValue;

    if (isDot && _value.contains(',') && !wipeValue) {
      return;
    }

    final emptyValue = isDot ? '0' : '';
    final currentValue = wipeValue ? emptyValue : _value;
    _value = currentValue + digit;
    _wipeValue = false;

    _buffer[_bufferIndex] = double.tryParse(_value) ?? 0;
  }

  /// Função responsável por limpar o valor exibido no display, quando o botão
  /// AC for pressionado
  _allClear() {
    _value = '0';
    _buffer.setAll(0, [0.0, 0.0]);
    _operation = null;
    _bufferIndex = 0;
    _wipeValue = false;
  }

  /// Função responsável por realizar as operações matemáticas
  _calculate() {
    switch (_operation) {
      case '%':
        return _buffer[0] % _buffer[1];
      case '/':
        return _buffer[0] / _buffer[1];
      case 'x':
        return _buffer[0] * _buffer[1];
      case '-':
        return _buffer[0] - _buffer[1];
      case '+':
        return _buffer[0] + _buffer[1];
      default:
        return _buffer[0];
    }
  }

  /// Getter da variável _value
  String get value {
    return _value;
  }
}
