import 'package:flutter/material.dart';
import 'package:calculadora/colors.dart';

class CurrencyConverter extends StatefulWidget {
  const CurrencyConverter({super.key});

  @override
  State<CurrencyConverter> createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  String fromCurrency = 'USD';
  String toCurrency = 'EUR';
  double inputValue = 0;
  double result = 0;

  final Map<String, String> currencyNames = {
    'USD': 'Dólar',
    'EUR': 'Euro',
    'GBP': 'Libra',
    'JPY': 'Yen',
    'MXN': 'Peso MX',
    'BRL': 'Real',
    'COP': 'Peso CO',
    'ARS': 'Peso AR',
    'CLP': 'Peso CL',
    'PEN': 'Sol',
  };

  final Map<String, double> exchangeRates = {
    'USD': 1.0,
    'EUR': 0.93,
    'GBP': 0.80,
    'JPY': 151.50,
    'MXN': 16.70,
    'BRL': 5.05,
    'COP': 3800.0,
    'ARS': 850.0,
    'CLP': 950.0,
    'PEN': 3.70,
  };

  void convertCurrency() {
    if (inputValue <= 0) {
      setState(() {
        result = 0;
      });
      return;
    }

    final fromRate = exchangeRates[fromCurrency] ?? 1.0;
    final toRate = exchangeRates[toCurrency] ?? 1.0;
    
    setState(() {
      result = inputValue * (toRate / fromRate);
    });
  }

  @override
  Widget build(BuildContext context) {
    final currencies = exchangeRates.keys.toList();
    
    return AlertDialog(
      title: const Text('Conversor de Monedas',
          style: TextStyle(color: AppColors.darkWine)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Cantidad a convertir',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                inputValue = double.tryParse(value) ?? 0;
              },
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    isExpanded: true, // Añadido para expandir el ancho
                    value: fromCurrency,
                    items: currencies.map((String currency) {
                      return DropdownMenuItem<String>(
                        value: currency,
                        child: Text(
                          '$currency - ${currencyNames[currency]}',
                          overflow: TextOverflow.ellipsis, // Para texto largo
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        fromCurrency = newValue!;
                      });
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(Icons.arrow_forward, size: 20),
                ),
                Expanded(
                  child: DropdownButton<String>(
                    isExpanded: true, // Añadido para expandir el ancho
                    value: toCurrency,
                    items: currencies.map((String currency) {
                      return DropdownMenuItem<String>(
                        value: currency,
                        child: Text(
                          '$currency - ${currencyNames[currency]}',
                          overflow: TextOverflow.ellipsis, // Para texto largo
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        toCurrency = newValue!;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: convertCurrency,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.pastelPink,
                foregroundColor: AppColors.darkWine,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Convertir'),
            ),
            const SizedBox(height: 20),
            Text(
              'Resultado: ${result.toStringAsFixed(2)} $toCurrency',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.darkWine,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '1 $fromCurrency = ${(exchangeRates[toCurrency]! / exchangeRates[fromCurrency]!).toStringAsFixed(4)} $toCurrency',
              style: const TextStyle(color: AppColors.darkWine),
            ),
            Text(
              '1 $toCurrency = ${(exchangeRates[fromCurrency]! / exchangeRates[toCurrency]!).toStringAsFixed(4)} $fromCurrency',
              style: const TextStyle(color: AppColors.darkWine),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cerrar',
              style: TextStyle(color: AppColors.darkWine)),
        ),
      ],
    );
  }
}