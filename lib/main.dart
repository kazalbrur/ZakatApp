import 'package:flutter/material.dart';

void main() => runApp(ZakatCalculatorApp());

class ZakatCalculatorApp extends StatelessWidget {
  const ZakatCalculatorApp({super.key});

  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zakat Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ZakatCalculatorScreen(),
    );
  }
}

class ZakatCalculatorScreen extends StatefulWidget {
  const ZakatCalculatorScreen({super.key});

  @override
  _ZakatCalculatorScreenState createState() => _ZakatCalculatorScreenState();
}

class _ZakatCalculatorScreenState extends State<ZakatCalculatorScreen> {
  final TextEditingController _cashInHandController = TextEditingController();
  final TextEditingController _savingsController = TextEditingController();
  final TextEditingController _businessInvestmentsController = TextEditingController();
  final TextEditingController _stockValueController = TextEditingController();
  final TextEditingController _liabilitiesController = TextEditingController();

  double _currentAssets = 0.0;
  double _zakatPayable = 0.0;

  void _calculateZakat() {
    double cashInHand = double.tryParse(_cashInHandController.text) ?? 0.0;
    double savings = double.tryParse(_savingsController.text) ?? 0.0;
    double businessInvestments = double.tryParse(_businessInvestmentsController.text) ?? 0.0;
    double stockValue = double.tryParse(_stockValueController.text) ?? 0.0;
    double liabilities = double.tryParse(_liabilitiesController.text) ?? 0.0;

    _currentAssets = cashInHand + savings + businessInvestments + stockValue;
    double nisab = 555500.00; // Base on Gold Nisab value
    if (_currentAssets > nisab) {
      _zakatPayable = (_currentAssets - liabilities) * 0.025;
    } else {
      _zakatPayable = 0.0;
    }

    setState(() {});
  }

  void _resetFields() {
    _cashInHandController.clear();
    _savingsController.clear();
    _businessInvestmentsController.clear();
    _stockValueController.clear();
    _liabilitiesController.clear();
    setState(() {
      _currentAssets = 0.0;
      _zakatPayable = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zakat Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'NISAB VALUES',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text('Gold Nisab: TK 555,500.00 (87.48g)'),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _cashInHandController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'In hand and in bank accounts (TK)'),
                    ),
                    TextField(
                      controller: _savingsController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Savings for the future (TK)'),
                    ),
                    TextField(
                      controller: _businessInvestmentsController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Business investments (TK)'),
                    ),
                    TextField(
                      controller: _stockValueController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Stock value (TK)'),
                    ),
                    TextField(
                      controller: _liabilitiesController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Liabilities (TK)'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'YOUR CURRENT ASSETS ARE WORTH: TK $_currentAssets',
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(
                      'THE VALUE OF YOUR PAYABLE ZAKAT IS: TK $_zakatPayable',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _resetFields,
                  child: const Text('Reset'),
                ),
                ElevatedButton(
                  onPressed: _calculateZakat,
                  child: const Text('Calculate'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}