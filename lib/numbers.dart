double? parseNumber(String? raw) {
  if (raw == null || raw.trim().isEmpty) return null;
  return double.tryParse(raw.replaceAll(',', '.'));
}

String formatNumber(double value) {
  if (value == value.truncateToDouble()) {
    return value.toInt().toString();
  }
  final result = value.toStringAsFixed(4);
  return result.replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
}

bool isFiniteNumber(double? value) {
  if (value == null) return false;
  return value.isFinite;
}