import 'package:flutter/material.dart';
import 'package:calculadora/colors.dart';

class IPv4SubnetCalculator extends StatefulWidget {
  const IPv4SubnetCalculator({super.key});

  @override
  State<IPv4SubnetCalculator> createState() => _IPv4SubnetCalculatorState();
}

class _IPv4SubnetCalculatorState extends State<IPv4SubnetCalculator> {
  final TextEditingController _ipController = TextEditingController();
  final TextEditingController _subnetController = TextEditingController();
  String _result = '';

  List<int> _parseIp(String ip) {
    return ip.split('.').map((e) => int.parse(e)).toList();
  }

 List<int> _parseSubnet(String subnet) {
  if (subnet.contains('.')) {
    return subnet.split('.').map((e) => int.parse(e)).toList();
  } else {
    // Convertir notación CIDR a máscara decimal
    int cidrValue = int.parse(subnet); // Cambiamos el nombre de la variable
    final mask = List<int>.filled(4, 0);
    for (int i = 0; i < 4; i++) {
      if (cidrValue > 8) {
        mask[i] = 255;
        cidrValue -= 8;
      } else {
        mask[i] = 256 - (1 << (8 - cidrValue));
        break;
      }
    }
    return mask;
  }
  }

  List<int> _calculateNetworkAddress(List<int> ip, List<int> mask) {
    return List.generate(4, (i) => ip[i] & mask[i]);
  }

  List<int> _calculateBroadcast(List<int> network, List<int> mask) {
    return List.generate(4, (i) => network[i] | (255 ^ mask[i]));
  }

  int _calculateTotalHosts(List<int> mask) {
    int hostBits = 0;
    for (int octet in mask) {
      hostBits += 8 - (octet.toRadixString(2).replaceAll('0', '').length);
    }
    return (1 << hostBits) - 2;
  }

  void _calculateSubnet() {
    try {
      final ip = _ipController.text.trim();
      final subnet = _subnetController.text.trim();

      if (ip.isEmpty || subnet.isEmpty) {
        setState(() {
          _result = 'Por favor ingrese una IP y máscara válida';
        });
        return;
      }

      // Validar formato IP
      if (!RegExp(r'^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$').hasMatch(ip)) {
        setState(() {
          _result = 'Formato de IP inválido';
        });
        return;
      }

      // Validar máscara
      final isCidr = RegExp(r'^\d{1,2}$').hasMatch(subnet);
      final isFullMask = RegExp(r'^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$').hasMatch(subnet);

      if (!isCidr && !isFullMask) {
        setState(() {
          _result = 'Formato de máscara inválido';
        });
        return;
      }

      // Parsear IP y máscara
      final ipOctets = _parseIp(ip);
      final maskOctets = _parseSubnet(subnet);

      // Validar valores
      for (int octet in [...ipOctets, ...maskOctets]) {
        if (octet < 0 || octet > 255) {
          setState(() {
            _result = 'Valores deben estar entre 0 y 255';
          });
          return;
        }
      }

      // Calcular información de la subred
      final network = _calculateNetworkAddress(ipOctets, maskOctets);
      final broadcast = _calculateBroadcast(network, maskOctets);
      final firstUsable = List.of(network)..[3] += 1;
      final lastUsable = List.of(broadcast)..[3] -= 1;
      final totalHosts = _calculateTotalHosts(maskOctets);

      setState(() {
        _result = '''
Dirección IP: ${ipOctets.join('.')}
Máscara de subred: ${maskOctets.join('.')}
Dirección de red: ${network.join('.')}
Primera dirección usable: ${firstUsable.join('.')}
Última dirección usable: ${lastUsable.join('.')}
Dirección de broadcast: ${broadcast.join('.')}
Total de hosts: $totalHosts
''';
      });
    } catch (e) {
      setState(() {
        _result = 'Error en el cálculo: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Calculadora de Subred IPv4',
          style: TextStyle(color: AppColors.darkWine)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _ipController,
              decoration: const InputDecoration(
                labelText: 'Dirección IP (ej. 192.168.1.1)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _subnetController,
              decoration: const InputDecoration(
                labelText: 'Máscara (ej. 24 o 255.255.255.0)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _calculateSubnet,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.pastelPink,
                foregroundColor: AppColors.darkWine,
              ),
              child: const Text('Calcular'),
            ),
            const SizedBox(height: 24),
            Text(
              _result,
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

  @override
  void dispose() {
    _ipController.dispose();
    _subnetController.dispose();
    super.dispose();
  }
}