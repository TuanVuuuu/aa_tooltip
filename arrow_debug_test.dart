// ========================================
// ARROW DEBUG TEST - Copy vào code của bạn
// ========================================

// Thử code này để debug arrow:
/*
Builder(
  builder: (btnContext) {
    return ElevatedButton(
      onPressed: () {
        print('=== ARROW DEBUG TEST ===');
        AATooltip.show(
          context: btnContext,
          message: 'Arrow Test',
          config: const AATooltipConfig(
            autoHide: false,
            backgroundColor: Colors.red,  // Màu đỏ để dễ thấy
            textStyle: TextStyle(color: Colors.white, fontSize: 16),
            position: AATooltipPosition.top,  // Tooltip ở trên
            showArrow: true,  // ⭐ QUAN TRỌNG: Phải có dòng này!
            arrowSize: 10.0,  // Tăng kích thước arrow
            padding: EdgeInsets.all(12),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        );
      },
      child: const Text('Test Arrow'),
    );
  },
)
*/

// ========================================
// EXPECTED DEBUG OUTPUT:
// ========================================
// _getArrowDirection called with position: AATooltipPosition.top
// Arrow direction calculated as: ArrowDirection.down
// _TooltipBubble.build() - showArrow: true, arrowDirection: ArrowDirection.down
// _buildArrow() called - direction: ArrowDirection.down, arrowSize: 10.0
// Positioning arrow DOWN
// Arrow positioned successfully
// _ArrowPainter.paint() called - direction: ArrowDirection.down, color: Color(0xfff44336), size: Size(20.0, 10.0)
// Drawing DOWN arrow
// Arrow painted successfully
// ========================================

// Nếu không thấy debug output từ arrow, có nghĩa là:
// 1. showArrow: false (hoặc không được set)
// 2. ArrowDirection calculation sai
// 3. Widget không được build

// ========================================
// ALTERNATIVE TEST - No arrow:
// ========================================
/*
AATooltip.show(
  context: btnContext,
  message: 'No Arrow Test',
  config: const AATooltipConfig(
    autoHide: false,
    backgroundColor: Colors.blue,
    textStyle: TextStyle(color: Colors.white, fontSize: 16),
    position: AATooltipPosition.top,
    showArrow: false,  // ❌ Không có arrow
  ),
);
*/ 