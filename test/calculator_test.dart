import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/logic/calculator.dart';

void main() {
  group('Калькулятор', () {
    test('Сложение', () {
      final result = calculate('5', '+', '3');
      expect(result, isA<CalcSuccess>());
      expect((result as CalcSuccess).value, 8.0);
    });

    test('Вычитание', () {
      final result = calculate('10', '-', '4');
      expect(result, isA<CalcSuccess>());
      expect((result as CalcSuccess).value, 6.0);
    });

    test('Умножение', () {
      final result = calculate('7', '*', '6');
      expect(result, isA<CalcSuccess>());
      expect((result as CalcSuccess).value, 42.0);
    });

    test('Деление', () {
      final result = calculate('15', '/', '3');
      expect(result, isA<CalcSuccess>());
      expect((result as CalcSuccess).value, 5.0);
    });

    test('Деление на ноль', () {
      final result = calculate('10', '/', '0');
      expect(result, isA<CalcFailure>());
    });

    test('Некорректные числа', () {
      final result = calculate('abc', '+', '2');
      expect(result, isA<CalcFailure>());
    });

    test('Отсутствующий параметр', () {
      final result = calculate(null, '+', '2');
      expect(result, isA<CalcFailure>());
    });

    test('Неизвестная операция', () {
      final result = calculate('2', '^', '2');
      expect(result, isA<CalcFailure>());
    });

    test('Замена запятой на точку', () {
      final result = calculate('2,5', '*', '2');
      expect(result, isA<CalcSuccess>());
      expect((result as CalcSuccess).value, 5.0);
    });

    test('Слишком большие числа', () {
      final result = calculate('1e400', '+', '1');
      expect(result, isA<CalcFailure>());
    });
  });
}