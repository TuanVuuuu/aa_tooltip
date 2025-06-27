import 'package:flutter/material.dart';
import 'package:aa_tooltip/aa_tooltip.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AATooltip Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'AATooltip Demo'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ví dụ 1: Arrow Size Control
            const Text(
              '1. Arrow Size Control:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Builder(
                  builder: (btnContext) {
                    return ElevatedButton(
                      onPressed: () {
                        AATooltip.show(
                          context: btnContext,
                          message: 'Small Arrow (4px)',
                          config: const AATooltipConfig(
                            arrowSize: 4.0, // ⭐ Small arrow
                            backgroundColor: Colors.red,
                            textStyle: TextStyle(color: Colors.white),
                          ),
                          autoHide: false,
                        );
                      },
                      child: const Text('Small Arrow'),
                    );
                  },
                ),
                const SizedBox(width: 10),
                Builder(
                  builder: (btnContext) {
                    return ElevatedButton(
                      onPressed: () {
                        AATooltip.show(
                          context: btnContext,
                          message: 'Big Arrow (20px)',
                          config: const AATooltipConfig(
                            arrowSize: 20.0, // ⭐ Big arrow
                            backgroundColor: Colors.green,
                            textStyle: TextStyle(color: Colors.white),
                          ),
                          autoHide: false,
                        );
                      },
                      child: const Text('Big Arrow'),
                    );
                  },
                ),
              ],
            ),
            
            const SizedBox(height: 30),
            
            // Ví dụ 2: Auto-Hide Control
            const Text(
              '2. Auto-Hide Control:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Builder(
                  builder: (btnContext) {
                    return ElevatedButton(
                      onPressed: () {
                        AATooltip.showPersistent(
                          context: btnContext,
                          message: 'Persistent - Never auto-hide!',
                          config: const AATooltipConfig(
                            backgroundColor: Colors.purple,
                            textStyle: TextStyle(color: Colors.white),
                            arrowSize: 8.0,
                          ),
                        );
                      },
                      child: const Text('Never Hide'),
                    );
                  },
                ),
                const SizedBox(width: 10),
                Builder(
                  builder: (btnContext) {
                    return ElevatedButton(
                      onPressed: () {
                        AATooltip.showTimed(
                          context: btnContext,
                          message: 'Auto-hide after 1 second!',
                          duration: const Duration(seconds: 1),
                          config: const AATooltipConfig(
                            backgroundColor: Colors.orange,
                            textStyle: TextStyle(color: Colors.white),
                            arrowSize: 10.0,
                          ),
                        );
                      },
                      child: const Text('1 Second'),
                    );
                  },
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            Row(
              children: [
                Builder(
                  builder: (btnContext) {
                    return ElevatedButton(
                      onPressed: () {
                        AATooltip.showTimed(
                          context: btnContext,
                          message: 'Auto-hide after 5 seconds!',
                          duration: const Duration(seconds: 5),
                          config: const AATooltipConfig(
                            backgroundColor: Colors.blue,
                            textStyle: TextStyle(color: Colors.white),
                            arrowSize: 12.0,
                          ),
                        );
                      },
                      child: const Text('5 Seconds'),
                    );
                  },
                ),
                const SizedBox(width: 10),
                Builder(
                  builder: (btnContext) {
                    return ElevatedButton(
                      onPressed: () {
                        AATooltip.show(
                          context: btnContext,
                          message: 'Custom 10 seconds!',
                          hideAfter: const Duration(seconds: 10), // ⭐ Custom duration
                          config: const AATooltipConfig(
                            backgroundColor: Colors.teal,
                            textStyle: TextStyle(color: Colors.white),
                            arrowSize: 15.0,
                          ),
                        );
                      },
                      child: const Text('10 Seconds'),
                    );
                  },
                ),
              ],
            ),
            
            const SizedBox(height: 30),
            
            // Ví dụ 3: Position Examples
            const Text(
              '3. Position Examples:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Center(
              child: Builder(
                builder: (btnContext) {
                  return ElevatedButton(
                    onPressed: () {
                      AATooltip.show(
                        context: btnContext,
                        message: 'Bottom tooltip with arrow!',
                        config: const AATooltipConfig(
                          position: AATooltipPosition.bottom,
                          backgroundColor: Colors.indigo,
                          textStyle: TextStyle(color: Colors.white),
                          arrowSize: 8.0,
                        ),
                        autoHide: false,
                      );
                    },
                    child: const Text('Bottom Tooltip'),
                  );
                },
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Ví dụ 4: Arrow Pointing Test
            const Text(
              '4. Arrow Pointing Test (Arrows point to CENTER of target):',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Small button
                Builder(
                  builder: (btnContext) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(60, 30),
                        backgroundColor: Colors.amber,
                      ),
                      onPressed: () {
                        AATooltip.show(
                          context: btnContext,
                          message: 'Arrow points to small button center',
                          config: const AATooltipConfig(
                            position: AATooltipPosition.top,
                            backgroundColor: Colors.black87,
                            textStyle: TextStyle(color: Colors.white),
                            arrowSize: 6.0,
                          ),
                          autoHide: false,
                        );
                      },
                      child: const Text('Small'),
                    );
                  },
                ),
                // Large button
                Builder(
                  builder: (btnContext) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(150, 50),
                        backgroundColor: Colors.deepPurple,
                      ),
                      onPressed: () {
                        AATooltip.show(
                          context: btnContext,
                          message: 'Arrow points to large button center',
                          config: const AATooltipConfig(
                            position: AATooltipPosition.top,
                            backgroundColor: Colors.black87,
                            textStyle: TextStyle(color: Colors.white),
                            arrowSize: 8.0,
                          ),
                          autoHide: false,
                        );
                      },
                      child: const Text('Large Button'),
                    );
                  },
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Different positions test
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Builder(
                  builder: (btnContext) {
                    return IconButton(
                      iconSize: 30,
                      onPressed: () {
                        AATooltip.show(
                          context: btnContext,
                          message: 'Left tooltip points to icon center',
                          config: const AATooltipConfig(
                            position: AATooltipPosition.left,
                            backgroundColor: Colors.green,
                            textStyle: TextStyle(color: Colors.white),
                            arrowSize: 7.0,
                          ),
                          autoHide: false,
                        );
                      },
                      icon: const Icon(Icons.star, color: Colors.orange),
                    );
                  },
                ),
                Builder(
                  builder: (btnContext) {
                    return IconButton(
                      iconSize: 30,
                      onPressed: () {
                        AATooltip.show(
                          context: btnContext,
                          message: 'Right tooltip points to icon center',
                          config: const AATooltipConfig(
                            position: AATooltipPosition.right,
                            backgroundColor: Colors.red,
                            textStyle: TextStyle(color: Colors.white),
                            arrowSize: 7.0,
                          ),
                          autoHide: false,
                        );
                      },
                      icon: const Icon(Icons.favorite, color: Colors.pink),
                    );
                  },
                ),
              ],
            ),
            
            const SizedBox(height: 30),
            
            // Ví dụ 5: Custom Content Test
            const Text(
              '5. Custom Content Test (NOT just text!):',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Icon + Text tooltip
                Builder(
                  builder: (btnContext) {
                    return ElevatedButton(
                      onPressed: () {
                        AATooltip.show(
                          context: btnContext,
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.info, color: Colors.lightBlue, size: 20),
                              SizedBox(width: 8),
                              Text(
                                'Icon + Text',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          config: const AATooltipConfig(
                            backgroundColor: Colors.blueGrey,
                            arrowSize: 8.0,
                          ),
                          autoHide: false,
                        );
                      },
                      child: const Text('Icon + Text'),
                    );
                  },
                ),
                
                // Multi-line content
                Builder(
                  builder: (btnContext) {
                    return ElevatedButton(
                      onPressed: () {
                        AATooltip.show(
                          context: btnContext,
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '📱 Multi-line Content',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'This tooltip has multiple lines\nand custom layout!',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          config: const AATooltipConfig(
                            backgroundColor: Colors.deepOrange,
                            arrowSize: 10.0,
                            position: AATooltipPosition.bottom,
                          ),
                          autoHide: false,
                        );
                      },
                      child: const Text('Multi-line'),
                    );
                  },
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Rich content tooltip
            Center(
              child: Builder(
                builder: (btnContext) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      AATooltip.show(
                        context: btnContext,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.star, color: Colors.yellow, size: 16),
                                  Icon(Icons.star, color: Colors.yellow, size: 16),
                                  Icon(Icons.star, color: Colors.yellow, size: 16),
                                  Icon(Icons.star, color: Colors.yellow, size: 16),
                                  Icon(Icons.star, color: Colors.yellow, size: 16),
                                ],
                              ),
                              SizedBox(height: 8),
                              Text(
                                '⭐ Rich Content Tooltip',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'With stars, emojis, and custom widgets!\nArrow points exactly to button center.',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 11,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        config: const AATooltipConfig(
                          backgroundColor: Colors.indigo,
                          arrowSize: 12.0,
                          position: AATooltipPosition.top,
                          padding: EdgeInsets.all(16),
                        ),
                        autoHide: false,
                      );
                    },
                    child: const Text('🎨 Rich Content'),
                  );
                },
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Control buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: AATooltip.hideAll,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Hide All Tooltips'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
