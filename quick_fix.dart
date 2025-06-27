// ========================================
// QUICK FIX: Copy-paste this into your app
// ========================================

// In your widget, use this EXACT code:
/*
ElevatedButton(
  onPressed: () {
    print('Showing tooltip with autoHide: false');
    AATooltip.show(
      context: context,
      message: 'Test tooltip - NOW VISIBLE!',
      config: const AATooltipConfig(
        autoHide: false,  // CRITICAL: Must be false!
        backgroundColor: Colors.black87,
        textStyle: TextStyle(color: Colors.white, fontSize: 16),
        animationDuration: Duration(milliseconds: 100), // Fast animation
      ),
    );
  },
  child: const Text('Show Tooltip (Fixed)'),
),

// Add this button to hide tooltip:
ElevatedButton(
  onPressed: () {
    AATooltip.hideAll();
  },
  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
  child: const Text('Hide All'),
),
*/

// ========================================
// EXPLANATION:
// 1. autoHide: false - Prevents auto-hiding
// 2. animationDuration: 100ms - Fast animation 
// 3. Must call AATooltip.hideAll() manually to hide
// ======================================== 