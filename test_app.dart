import 'package:flutter/material.dart';
import 'lib/aa_tooltip.dart';

void main() {
  runApp(const TestApp());
}

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tooltip Test',
      home: Scaffold(
        appBar: AppBar(title: const Text('Test AATooltip')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  print('Button pressed!');
                  AATooltip.show(
                    context: context,
                    message: 'Test tooltip - should be visible!',
                    config: const AATooltipConfig(
                      autoHide: false, // Không tự ẩn
                      backgroundColor: Colors.black87,
                      textStyle: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  );
                },
                child: const Text('Show Tooltip (No Auto Hide)'),
              ),
              
              const SizedBox(height: 20),
              
              ElevatedButton(
                onPressed: () {
                  AATooltip.hideAll();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Hide All'),
              ),
              
              const SizedBox(height: 20),
              
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text('Target area for tooltip'),
              ).tooltip(
                message: 'Extension tooltip!',
                config: const AATooltipConfig(
                  backgroundColor: Colors.green,
                  autoHide: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 