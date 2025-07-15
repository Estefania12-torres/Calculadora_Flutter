import 'dart:math';
import 'package:flutter/material.dart';
import 'package:calculadora/colors.dart';
import 'package:calculadora/unit_converter.dart';
import 'package:calculadora/ipv4_subnet_calculator.dart';
import 'package:calculadora/currency_converter.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State createState() => CalculatorPageState();
}

class CalculatorPageState extends State<CalculatorPage> {
  String conjuntoUno = "0";
  String conjuntoDos = "0";
  String conjunto = "0";

  bool estaSumando = false;
  bool estaRestando = false;
  bool estaDividiendo = false;
  bool estaMultiplicando = false;
  bool estaNegativo = false;
  bool isConjuntoUno = true;
  bool esDecimal = false;

  List<String> historial = [];

  void agregarAlHistorial(String operacion) {
    historial.add(operacion);
  }

  Function funcionBoton(String numero) {
    if (isConjuntoUno) {
      conjunto = conjuntoUno;
    } else {
      conjunto = conjuntoDos;
    }

    if (conjunto.length < 10) {
      conjunto = (conjunto == "0") ? numero : conjunto + numero;
    }

    if (isConjuntoUno) {
      conjuntoUno = conjunto;
    } else {
      conjuntoDos = conjunto;
    }

    setState(() {});
    return () {};
  }

  Function funcionMenosMas() {
    if (isConjuntoUno) {
      conjunto = conjuntoUno;
    } else {
      conjunto = conjuntoDos;
    }

    if (!estaNegativo) {
      conjunto = "-$conjunto";
      estaNegativo = true;
    } else {
      conjunto = conjunto.substring(1);
      estaNegativo = false;
    }

    if (isConjuntoUno) {
      conjuntoUno = conjunto;
    } else {
      conjuntoDos = conjunto;
    }

    setState(() {});
    return () {};
  }

  Function funcionDecimal() {
    if (isConjuntoUno) {
      conjunto = conjuntoUno;
    } else {
      conjunto = conjuntoDos;
    }

    if (!conjunto.contains('.')) {
      conjunto += ".";
    }

    if (isConjuntoUno) {
      conjuntoUno = conjunto;
    } else {
      conjuntoDos = conjunto;
    }

    setState(() {});
    return () {};
  }

  void _aplicarOperacion(double Function(double) operacion) {
    if (isConjuntoUno) {
      conjunto = conjuntoUno;
    } else {
      conjunto = conjuntoDos;
    }

    double aux = operacion(double.parse(conjunto));
    
    if (aux % 1 == 0) {
      conjunto = aux.toInt().toString();
    } else {
      conjunto = aux.toStringAsFixed(6).replaceAll(RegExp(r'\.0+$'), '');
    }

    if (isConjuntoUno) {
      conjuntoUno = conjunto;
    } else {
      conjuntoDos = conjunto;
    }

    setState(() {});
  }

  Function cuadrado() => () => _aplicarOperacion((x) => x * x);
  Function cubo() => () => _aplicarOperacion((x) => x * x * x);
  Function raiz() => () => _aplicarOperacion((x) => sqrt(x));

  void calcularResultado() {
    double numeroUno = double.parse(conjuntoUno);
    double numeroDos = double.parse(conjuntoDos);
    double total = 0;
    String operacion = "";

    if (estaSumando) {
      total = numeroUno + numeroDos;
      operacion = "$numeroUno + $numeroDos = ${_formatearResultado(total)}";
    } else if (estaRestando) {
      total = numeroUno - numeroDos;
      operacion = "$numeroUno - $numeroDos = ${_formatearResultado(total)}";
    } else if (estaMultiplicando) {
      total = numeroUno * numeroDos;
      operacion = "$numeroUno × $numeroDos = ${_formatearResultado(total)}";
    } else if (estaDividiendo) {
      total = numeroUno / numeroDos;
      operacion = "$numeroUno ÷ $numeroDos = ${_formatearResultado(total)}";
    }

    agregarAlHistorial(operacion);
    isConjuntoUno = true;
    conjuntoDos = "0";
    conjuntoUno = _formatearResultado(total);
    conjunto = conjuntoUno;

    if (conjunto.length > 10) {
      conjunto = conjunto.substring(0, 10);
    }

    setState(() {});
  }

  String _formatearResultado(double resultado) {
    if (resultado % 1 == 0) {
      return resultado.toInt().toString();
    } else {
      return resultado.toStringAsFixed(6).replaceAll(RegExp(r'\.0+$'), '');
    }
  }

  void limpiarTodo() {
    conjunto = "0";
    conjuntoUno = "0";
    conjuntoDos = "0";
    estaSumando = estaRestando = estaDividiendo = estaMultiplicando = estaNegativo = false;
    isConjuntoUno = true;
    esDecimal = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora"),
        actions: [
          IconButton(
            icon: const Icon(Icons.currency_exchange),
            onPressed: () => _mostrarConversorMonedas(context),
            tooltip: 'Conversor de Monedas',
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: AppColors.darkWine),
              child: Text('',
                  style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: const Icon(Icons.calculate, color: AppColors.darkWine),
              title: const Text('Calculadora', style: TextStyle(color: AppColors.darkWine)),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.history, color: AppColors.darkWine),
              title: const Text('Historial', style: TextStyle(color: AppColors.darkWine)),
              onTap: () {
                Navigator.pop(context);
                _mostrarHistorial(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.swap_horiz, color: AppColors.darkWine),
              title: const Text('Conversor de Unidades', style: TextStyle(color: AppColors.darkWine)),
              onTap: () {
                Navigator.pop(context);
                _mostrarConversor(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.computer, color: AppColors.darkWine),
              title: const Text('Subred IPv4', style: TextStyle(color: AppColors.darkWine)),
              onTap: () {
                Navigator.pop(context);
                _mostrarSubnetCalculator(context);
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: _buildCalculadora(),
      ),
      bottomNavigationBar: BottomAppBar(
        color: AppColors.lightPink,
        elevation: 0,
        child: const Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(
            '- Mi Calculadora Flutter-',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: AppColors.darkWine),
          ),
        ),
      ),
    );
  }

  Widget _buildCalculadora() {
    return Container(
      width: 350,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(178, 112, 146, 0.3),
            blurRadius: 15,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildPantalla(),
            const SizedBox(height: 15),
            _buildFilaBotones(["-/+", "x²", "x³", "√"], [
              funcionMenosMas,
              cuadrado(),
              cubo(),
              raiz(),
            ]),
            _buildFilaBotones(["7", "8", "9", "÷"], [
              () => funcionBoton("7"),
              () => funcionBoton("8"),
              () => funcionBoton("9"),
              () {
                estaSumando = estaRestando = estaMultiplicando = false;
                estaDividiendo = true;
                isConjuntoUno = false;
              },
            ]),
            _buildFilaBotones(["4", "5", "6", "x"], [
              () => funcionBoton("4"),
              () => funcionBoton("5"),
              () => funcionBoton("6"),
              () {
                estaSumando = estaRestando = estaDividiendo = false;
                estaMultiplicando = true;
                isConjuntoUno = false;
              },
            ]),
            _buildFilaBotones(["1", "2", "3", "-"], [
              () => funcionBoton("1"),
              () => funcionBoton("2"),
              () => funcionBoton("3"),
              () {
                estaSumando = estaMultiplicando = estaDividiendo = false;
                estaRestando = true;
                isConjuntoUno = false;
              },
            ]),
            _buildFilaBotones(["0", ".", "C", "+"], [
              () => funcionBoton("0"),
              funcionDecimal,
              limpiarTodo,
              () {
                estaRestando = estaMultiplicando = estaDividiendo = false;
                estaSumando = true;
                isConjuntoUno = false;
              },
            ]),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: calcularResultado,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.darkWine,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              child: const Text("="),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPantalla() {
    return Container(
      width: double.infinity,
      height: 100,
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.lightPink,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(178, 112, 146, 0.2),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        conjunto,
        style: const TextStyle(
          fontSize: 42,
          fontWeight: FontWeight.bold,
          color: AppColors.darkWine),
        textAlign: TextAlign.right,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildFilaBotones(List<String> textos, List<Function> funciones) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(textos.length, (i) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: ElevatedButton(
                onPressed: () => funciones[i](),
                child: Text(textos[i]),
              ),
            ),
          );
        }),
      ),
    );
  }

  void _mostrarHistorial(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Historial", style: TextStyle(color: AppColors.darkWine)),
        content: SizedBox(
          width: double.maxFinite,
          child: historial.isEmpty
              ? const Center(child: Text("No hay historial aún.", style: TextStyle(color: AppColors.darkWine)))
              : ListView(
                  children: historial.map((e) => Text(e, style: const TextStyle(color: AppColors.darkWine))).toList(),
                ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), 
              child: const Text("Cerrar", style: TextStyle(color: AppColors.darkWine)))
        ],
      ),
    );
  }

  void _mostrarConversor(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const UnitConverter(),
    );
  }

  void _mostrarSubnetCalculator(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const IPv4SubnetCalculator(),
    );
  }

  void _mostrarConversorMonedas(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const CurrencyConverter(),
    );
  }
}