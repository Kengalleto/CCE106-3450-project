
import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() =>
      _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {

  // Controllers
  final firstNumberController = TextEditingController();
  final secondNumberController = TextEditingController();

  // State variables
  String result = '0';
  String operationLabel = 'Enter two numbers';

  // Calculation function
  void calculate(String operation) {
    final first =
        double.tryParse(firstNumberController.text.trim());

    final second =
        double.tryParse(secondNumberController.text.trim());

    if (first == null ||
        second == null ||
        !first.isFinite ||
        !second.isFinite) {
      setState(() {
        result = 'Invalid input';
        operationLabel = 'Please enter two valid numbers';
      });
      return;
    }

    if (operation == '÷' && second == 0) {
      setState(() {
        result = 'Cannot divide by zero';
        operationLabel = 'Please change the second number';
      });
      return;
    }

    double answer;

    switch (operation) {
      case '+':
        answer = first + second;
        break;

      case '-':
        answer = first - second;
        break;

      case '×':
        answer = first * second;
        break;

      case '÷':
        answer = first / second;
        break;

      default:
        return;
    }

   setState(() {
  result = answer.toStringAsFixed(1);
  operationLabel = '$first $operation $second';
});
  }

  // Clear function
  void clearCalculator() {
    firstNumberController.clear();
    secondNumberController.clear();

    setState(() {
      result = '0';
      operationLabel = 'Enter two numbers';
    });
  }

  // Release controllers
  @override
  void dispose() {
    firstNumberController.dispose();
    secondNumberController.dispose();
    super.dispose();
  }

  // Calculator interface
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Stateful Calculator'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            const Icon(
              Icons.calculate,
              size: 64,
              color: Colors.indigo,
            ),

            const SizedBox(height: 12),

            const Text(
              'BASIC CALCULATOR',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 24),

            // First number
            TextField(
              controller: firstNumberController,
              keyboardType:
                  const TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              ),
              decoration: const InputDecoration(
                labelText: 'First Number',
                hintText: 'Enter the first number',
                prefixIcon: Icon(Icons.looks_one),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            // Second number
            TextField(
              controller: secondNumberController,
              keyboardType:
                  const TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Second Number',
                hintText: 'Enter the second number',
                prefixIcon: Icon(Icons.looks_two),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 24),

            // Operation buttons
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 12,
              runSpacing: 12,
              children: [

                ElevatedButton(
                  onPressed: () => calculate('+'),
                  child: const Text(
                    '+',
                    style: TextStyle(fontSize: 24),
                  ),
                ),

                ElevatedButton(
                  onPressed: () => calculate('-'),
                  child: const Text(
                    '−',
                    style: TextStyle(fontSize: 24),
                  ),
                ),

                ElevatedButton(
                  onPressed: () => calculate('×'),
                  child: const Text(
                    '×',
                    style: TextStyle(fontSize: 24),
                  ),
                ),

                ElevatedButton(
                  onPressed: () => calculate('÷'),
                  child: const Text(
                    '÷',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Result container
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.indigo.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.indigo,
                ),
              ),

              child: Column(
                children: [

                  Text(
                    operationLabel,
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'RESULT',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    result,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Clear button
            OutlinedButton.icon(
              onPressed: clearCalculator,
              icon: const Icon(Icons.refresh),
              label: const Text('Clear'),
            ),

            const SizedBox(height: 24),

            // Student information
            const Text(
              'Jucris Galleto\nSection: CCE106(3450)',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
