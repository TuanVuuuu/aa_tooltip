// ========================================
// FIX POSITIONING: Use Builder to get correct context
// ========================================

// WRONG WAY (context is too large):
/*
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElevatedButton(
        onPressed: () {
          // ❌ WRONG: context here is Scaffold context
          AATooltip.show(context: context, message: 'Wrong position');
        },
        child: Text('Button'),
      ),
    );
  }
}
*/

// ✅ CORRECT WAY: Use Builder to get button's specific context
/*
ElevatedButton(
  onPressed: () {
    // Use Builder to get the button's specific context
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (dialogContext) {
        return Builder(
          builder: (buttonContext) {
            // ✅ CORRECT: buttonContext is specific to this button
            AATooltip.show(
              context: buttonContext,
              message: 'Correct position!',
              config: const AATooltipConfig(
                autoHide: false,
                backgroundColor: Colors.black87,
                textStyle: TextStyle(color: Colors.white, fontSize: 16),
              ),
            );
            return Container(); // Return empty container
          },
        );
      },
    );
  },
  child: const Text('Show Tooltip'),
)
*/

// ========================================
// ALTERNATIVE: Wrap button in Builder
// ========================================
/*
Builder(
  builder: (buttonContext) {
    return ElevatedButton(
      onPressed: () {
        // ✅ CORRECT: buttonContext is specific to this button
        AATooltip.show(
          context: buttonContext,
          message: 'Correct position!',
          config: const AATooltipConfig(
            autoHide: false,
            backgroundColor: Colors.black87,
            textStyle: TextStyle(color: Colors.white, fontSize: 16),
          ),
        );
      },
      child: const Text('Show Tooltip'),
    );
  },
)
*/ 