import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../app_page.dart';
import '../app_settings.dart';
import '../logic/currency.dart';

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key});

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  late String _from;
  late String _to;

  @override
  void initState() {
    super.initState();
    final settings = AppSettings();
    _from = settings.lastFrom;
    _to = settings.lastTo;
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  String? _amountValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'Введите сумму';
    final v = double.tryParse(value.replaceAll(',', '.'));
    if (v == null) return 'Это не число';
    if (v < 0) return 'Сумма не может быть отрицательной';
    return null;
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final amount = _amountController.text.replaceAll(',', '.');
    AppSettings().setLastCurrency(_from, _to);
    context.go(
      '/converter/result?amount=$amount&from=$_from&to=$_to',
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'Конвертер валют',
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: 'Сумма',
                border: OutlineInputBorder(),
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              validator: _amountValidator,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _from,
              decoration: const InputDecoration(
                labelText: 'Из валюты',
                border: OutlineInputBorder(),
              ),
              items: ratesToRub.keys
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (v) => setState(() => _from = v ?? 'RUB'),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
                initialValue: _to,
              decoration: const InputDecoration(
                labelText: 'В валюту',
                border: OutlineInputBorder(),
              ),
              items: ratesToRub.keys
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (v) => setState(() => _to = v ?? 'USD'),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _submit,
                child: const Text('Конвертировать'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}