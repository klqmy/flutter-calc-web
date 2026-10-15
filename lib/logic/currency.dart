sealed class CurrencyResult {
  const CurrencyResult();
}

class CurrencySuccess extends CurrencyResult {
  final double converted;
  final String from;
  final String to;
  const CurrencySuccess(this.converted, this.from, this.to);
}

class CurrencyFailure extends CurrencyResult {
  final String message;
  const CurrencyFailure(this.message);
}

const Map<String, double> ratesToRub = {
  'RUB': 1.0,
  'USD': 92.5,
  'EUR': 100.2,
  'CNY': 12.8,
  'GBP': 117.4,
  'JPY': 0.62,
};

CurrencyResult convert(String? rawAmount, String? from, String? to) {
  if (from == null || to == null) {
    return const CurrencyFailure('Не выбрана валюта');
  }
  if (!ratesToRub.containsKey(from) || !ratesToRub.containsKey(to)) {
    return const CurrencyFailure('Неизвестная валюта');
  }

  final amount = double.tryParse(rawAmount?.replaceAll(',', '.') ?? '');
  if (amount == null) {
    return const CurrencyFailure('В адресе передано не число');
  }
  if (!amount.isFinite) {
    return const CurrencyFailure('Сумма слишком большая');
  }

  final inRub = amount * ratesToRub[from]!;
  final result = inRub / ratesToRub[to]!;
  return CurrencySuccess(result, from, to);
}