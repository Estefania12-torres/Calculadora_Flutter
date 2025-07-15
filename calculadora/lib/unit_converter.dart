import 'package:flutter/material.dart';
import 'package:calculadora/colors.dart';

class UnitConverter extends StatefulWidget {
  const UnitConverter({super.key});

  @override
  State<UnitConverter> createState() => _UnitConverterState();
}

class _UnitConverterState extends State<UnitConverter> {
  String selectedCategory = 'Longitud';
  String fromUnit = 'Metros';
  String toUnit = 'Pies';
  double inputValue = 0;
  double result = 0;

  final Map<String, Map<String, double>> conversionFactors = {
    'Longitud': {
      'Metros': 1.0,
      'Pies': 3.28084,
      'Pulgadas': 39.3701,
      'Centímetros': 100.0,
      'Kilómetros': 0.001,
      'Millas': 0.000621371,
    },
    'Área': {
      'Metros cuadrados': 1.0,
      'Pies cuadrados': 10.7639,
      'Pulgadas cuadradas': 1550.0,
      'Hectáreas': 0.0001,
      'Acres': 0.000247105,
    },
    'Volumen': {
      'Litros': 1.0,
      'Mililitros': 1000.0,
      'Galones': 0.264172,
      'Pulgadas cúbicas': 61.0237,
      'Pies cúbicos': 0.0353147,
    },
    'Tiempo': {
      'Segundos': 1.0,
      'Minutos': 1/60,
      'Horas': 1/3600,
      'Días': 1/86400,
      'Semanas': 1/604800,
    },
    'Temperatura': {
      'Celsius': 1.0,
      'Fahrenheit': 1.0, // Se manejará diferente
      'Kelvin': 1.0,    // Se manejará diferente
    },
    'Peso': {
      'Kilogramos': 1.0,
      'Gramos': 1000.0,
      'Libras': 2.20462,
      'Onzas': 35.274,
      'Toneladas': 0.001,
    },
  };

  void convert() {
    if (selectedCategory == 'Temperatura') {
      _convertTemperature();
    } else {
      final factorFrom = conversionFactors[selectedCategory]![fromUnit]!;
      final factorTo = conversionFactors[selectedCategory]![toUnit]!;
      setState(() {
        result = inputValue * factorTo / factorFrom;
      });
    }
  }

  void _convertTemperature() {
    if (fromUnit == 'Celsius') {
      if (toUnit == 'Fahrenheit') {
        result = inputValue * 9/5 + 32;
      } else if (toUnit == 'Kelvin') {
        result = inputValue + 273.15;
      } else {
        result = inputValue;
      }
    } else if (fromUnit == 'Fahrenheit') {
      if (toUnit == 'Celsius') {
        result = (inputValue - 32) * 5/9;
      } else if (toUnit == 'Kelvin') {
        result = (inputValue - 32) * 5/9 + 273.15;
      } else {
        result = inputValue;
      }
    } else if (fromUnit == 'Kelvin') {
      if (toUnit == 'Celsius') {
        result = inputValue - 273.15;
      } else if (toUnit == 'Fahrenheit') {
        result = (inputValue - 273.15) * 9/5 + 32;
      } else {
        result = inputValue;
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final units = conversionFactors[selectedCategory]?.keys.toList() ?? [];

    return AlertDialog(
      title: const Text('Conversor de Unidades', 
          style: TextStyle(color: AppColors.darkWine)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButton<String>(
              value: selectedCategory,
              items: conversionFactors.keys.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCategory = newValue!;
                  fromUnit = conversionFactors[selectedCategory]!.keys.first;
                  toUnit = conversionFactors[selectedCategory]!.keys.elementAt(1);
                  result = 0;
                });
              },
            ),
            const SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Valor a convertir',
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
                    value: fromUnit,
                    items: units.map((String unit) {
                      return DropdownMenuItem<String>(
                        value: unit,
                        child: Text(unit),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        fromUnit = newValue!;
                      });
                    },
                  ),
                ),
                const Icon(Icons.arrow_forward),
                Expanded(
                  child: DropdownButton<String>(
                    value: toUnit,
                    items: units.map((String unit) {
                      return DropdownMenuItem<String>(
                        value: unit,
                        child: Text(unit),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        toUnit = newValue!;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: convert,
              child: const Text('Convertir'),
            ),
            const SizedBox(height: 20),
            Text(
              'Resultado: ${result.toStringAsFixed(6).replaceAll(RegExp(r'\.0+$'), '')}',
              style: const TextStyle(fontSize: 18),
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