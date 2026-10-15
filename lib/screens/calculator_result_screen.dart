import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../app_page.dart';
import '../logic/calculator.dart';
import '../numbers.dart';

class CalculatorResultScreen extends StatelessWidget {
  final String? rawA;
  final String? rawOp;
  final String? rawB;

  const CalculatorResultScreen({
    super.key,
    required this.rawA,
    required this.rawOp,
    required this.rawB,
  });

  @override
  Widget build(BuildContext context) {
    final result = calculate(rawA, rawOp, rawB);
    final isSuccess = result is CalcSuccess;
    final displayValue = isSuccess ? formatNumber(result.value) : null;

    
    return AppPage(
      title: 'Результат',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${rawA ?? '?'} ${rawOp ?? '?'} ${rawB ?? '?'} =',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          Text(
            isSuccess ? displayValue! : (result as CalcFailure).message,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: isSuccess ? Colors.green : Colors.red,
                ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: FilledButton.tonal(
              onPressed: () => context.go('/calculator'),
              child: const Text('К форме'),
            ),
          ),
        ],
      ),
    );
  }
}