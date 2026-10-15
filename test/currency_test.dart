import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/logic/currency.dart';

void main() {
  group('Конвертер валют', () {
    test('Конвертация RUB в USD', () {
      final result = convert('925', 'RUB', 'USD');
      expect(result, isA<CurrencySuccess>());
      expect((result as CurrencySuccess).converted, closeTo(10.0, 0.1));
    });

    test('Конвертация USD в RUB', () {
      final result = convert('10', 'USD', 'RUB');
      expect(result, isA<CurrencySuccess>());
      expect((result as CurrencySuccess).converted, 925.0);
    });

    test('Некорректная сумма', () {
      final result = convert('abc', 'USD', 'RUB');
      expect(result, isA<CurrencyFailure>());
    });

    test('Отсутствует валюта', () {
      final result = convert('100', null, 'RUB');
      expect(result, isA<CurrencyFailure>());
    });

    test('Неизвестная валюта', () {
      final result = convert('100', 'XYZ', 'RUB');
      expect(result, isA<CurrencyFailure>());
    });

    test('Отрицательная сумма', () {
      final result = convert('-100', 'USD', 'RUB');
      expect(result, isA<CurrencySuccess>());
    });
  });
}