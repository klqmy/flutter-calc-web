import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../app_page.dart';
import '../logic/currency.dart';
import '../numbers.dart';

class ConverterResultScreen extends StatelessWidget {
  final String? amount;
  final String? from;
  final String? to;

  const ConverterResultScreen({
    super.key,
    required this.amount,
    required this.from,
    required this.to,
  });

  @override
  Widget build(BuildContext context) {
    final result = convert(amount, from, to);
    final isSuccess = result is CurrencySuccess;

    return AppPage(
      title: 'Результат конвертации',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${amount ?? '?'} ${from ?? '?'} → ${to ?? '?'}',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          Text(
            isSuccess
                ? '${formatNumber(result.converted)} ${to ?? ''}'
                : (result as CurrencyFailure).message,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: isSuccess ? Colors.green : Colors.red,
                ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: FilledButton.tonal(
              onPressed: () => context.go('/converter'),
              child: const Text('К форме'),
            ),
          ),
        ],
      ),
    );
  }
}