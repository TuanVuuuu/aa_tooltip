import 'package:flutter/material.dart';
import 'aa_tooltip_types.dart';
import 'aa_tooltip_controller.dart';

/// Widget hiển thị tooltip
class AATooltipWidget extends StatefulWidget {
  const AATooltipWidget({
    super.key,
    required this.controller,
    required this.targetContext,
  });

  final AATooltipController controller;
  final BuildContext targetContext;

  @override
  State<AATooltipWidget> createState() => _AATooltipWidgetState();
}

class _AATooltipWidgetState extends State<AATooltipWidget>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    widget.controller.addListener(_handleControllerChange);
    
    // Start animation immediately if controller is already visible
    if (widget.controller.isVisible) {
      print('Controller already visible on initState, starting animation');
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _animationController.forward();
      });
    }
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: widget.controller.config.animationDuration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    ));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
  }

  void _handleControllerChange() {
    print('_handleControllerChange: isVisible=${widget.controller.isVisible}');
    if (widget.controller.isVisible) {
      print('Starting animation forward');
      _animationController.forward();
    } else {
      print('Starting animation reverse');
      _animationController.reverse();
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleControllerChange);
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('AATooltipWidget.build() called');
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
        print('AnimatedBuilder: isVisible=${widget.controller.isVisible}, message="${widget.controller.message}"');
        if (!widget.controller.isVisible) {
          print('Widget not visible, returning SizedBox.shrink()');
          return const SizedBox.shrink();
        }

        print('Widget visible, building _TooltipOverlay');
        return _TooltipOverlay(
          controller: widget.controller,
          targetContext: widget.targetContext,
          scaleAnimation: _scaleAnimation,
          opacityAnimation: _opacityAnimation,
        );
      },
    );
  }
}

/// Overlay chứa tooltip
class _TooltipOverlay extends StatelessWidget {
  const _TooltipOverlay({
    required this.controller,
    required this.targetContext,
    required this.scaleAnimation,
    required this.opacityAnimation,
  });

  final AATooltipController controller;
  final BuildContext targetContext;
  final Animation<double> scaleAnimation;
  final Animation<double> opacityAnimation;

  @override
  Widget build(BuildContext context) {
    print('_TooltipOverlay.build() called');
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          // Invisible overlay để catch tap events
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                print('Overlay tapped, hiding tooltip');
                controller.hide();
              },
              child: Container(color: Colors.transparent),
            ),
          ),
          // Tooltip content
          _buildTooltipContent(context),
        ],
      ),
    );
  }

  Widget _buildTooltipContent(BuildContext context) {
    print('_buildTooltipContent() called');
    final renderBox = targetContext.findRenderObject() as RenderBox?;
    if (renderBox == null) {
      print('RenderBox is null, returning SizedBox.shrink()');
      return const SizedBox.shrink();
    }

    final targetPosition = renderBox.localToGlobal(Offset.zero);
    final targetSize = renderBox.size;
    final screenSize = MediaQuery.of(context).size;
    
    print('Target position: $targetPosition, size: $targetSize, screen: $screenSize');

    return AnimatedBuilder(
      animation: Listenable.merge([scaleAnimation, opacityAnimation]),
      builder: (context, child) {
        print('AnimatedBuilder: scale=${scaleAnimation.value}, opacity=${opacityAnimation.value}');
        return _PositionedTooltip(
          message: controller.message,
          child: controller.child,
          targetPosition: targetPosition,
          targetSize: targetSize,
          screenSize: screenSize,
          config: controller.config,
          scaleAnimation: scaleAnimation,
          opacityAnimation: opacityAnimation,
        );
      },
    );
  }
}

/// Positioned tooltip with accurate size measurement
class _PositionedTooltip extends StatelessWidget {
  const _PositionedTooltip({
    this.message,
    this.child,
    required this.targetPosition,
    required this.targetSize,
    required this.screenSize,
    required this.config,
    required this.scaleAnimation,
    required this.opacityAnimation,
  }) : assert(message != null || child != null, 'Either message or child must be provided');

  final String? message;
  final Widget? child;
  final Offset targetPosition;
  final Size targetSize;
  final Size screenSize;
  final AATooltipConfig config;
  final Animation<double> scaleAnimation;
  final Animation<double> opacityAnimation;

  @override
  Widget build(BuildContext context) {
    print('_PositionedTooltip.build() called');
    
    return _MeasuredTooltip(
      message: message,
      child: child,
      config: config,
      targetPosition: targetPosition,
      targetSize: targetSize,
      screenSize: screenSize,
      scaleAnimation: scaleAnimation,
      opacityAnimation: opacityAnimation,
    );
  }
}

/// Widget that measures content and positions tooltip accordingly
class _MeasuredTooltip extends StatefulWidget {
  const _MeasuredTooltip({
    this.message,
    this.child,
    required this.config,
    required this.targetPosition,
    required this.targetSize,
    required this.screenSize,
    required this.scaleAnimation,
    required this.opacityAnimation,
  }) : assert(message != null || child != null, 'Either message or child must be provided');

  final String? message;
  final Widget? child;
  final AATooltipConfig config;
  final Offset targetPosition;
  final Size targetSize;
  final Size screenSize;
  final Animation<double> scaleAnimation;
  final Animation<double> opacityAnimation;

  @override
  State<_MeasuredTooltip> createState() => _MeasuredTooltipState();
}

class _MeasuredTooltipState extends State<_MeasuredTooltip> {
  final GlobalKey _contentKey = GlobalKey();
  Size? _contentSize;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _measureContent();
    });
  }

  void _measureContent() {
    final renderBox = _contentKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final size = renderBox.size;
      if (mounted && size != _contentSize) {
        setState(() {
          _contentSize = size;
        });
        print('Measured actual tooltip content size: $size');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_contentSize == null) {
      // First render: measure content off-screen
      return Positioned(
        left: -9999, // Off screen
        top: -9999,
        child: _TooltipContent(
          key: _contentKey,
          message: widget.message,
          child: widget.child,
          config: widget.config,
        ),
      );
    }

    // Second render: position tooltip with actual measured size
    final position = _calculatePosition(
      widget.targetPosition,
      widget.targetSize,
      widget.screenSize,
      widget.config,
      _contentSize!,
    );
    
    print('Positioning tooltip at $position with measured size $_contentSize');

    return Positioned(
      left: position.dx,
      top: position.dy,
      child: Transform.scale(
        scale: widget.scaleAnimation.value,
        child: Opacity(
          opacity: widget.opacityAnimation.value,
          child: _TooltipBubble(
            message: widget.message,
            child: widget.child,
            config: widget.config,
            arrowDirection: _getArrowDirection(widget.config.position),
            targetPosition: widget.targetPosition,
            targetSize: widget.targetSize,
            tooltipPosition: position,
            measuredSize: _contentSize!,
          ),
        ),
      ),
    );
  }

  Offset _calculatePosition(
    Offset targetPosition,
    Size targetSize,
    Size screenSize,
    AATooltipConfig config,
    Size measuredSize,
  ) {
    // Use exact arrow size as specified by user
    double actualArrowSize = config.arrowSize;
    
    print('Calculating position for target at $targetPosition with size $targetSize');
    print('Using measured size: $measuredSize, arrow size: $actualArrowSize');

    // Calculate target center
    final targetCenter = Offset(
      targetPosition.dx + targetSize.width / 2,
      targetPosition.dy + targetSize.height / 2,
    );

    switch (config.position) {
      case AATooltipPosition.top:
        // Center tooltip with target horizontally
        double tooltipX = targetCenter.dx - (measuredSize.width / 2);
        double tooltipY = targetPosition.dy - measuredSize.height - actualArrowSize - 4;
        
        // Only adjust if tooltip goes outside screen bounds
        tooltipX = tooltipX.clamp(8.0, screenSize.width - measuredSize.width - 8.0);
        
        return Offset(tooltipX, tooltipY);
        
      case AATooltipPosition.bottom:
        // Center tooltip with target horizontally
        double tooltipX = targetCenter.dx - (measuredSize.width / 2);
        double tooltipY = targetPosition.dy + targetSize.height + actualArrowSize + 4;
        
        // Only adjust if tooltip goes outside screen bounds
        tooltipX = tooltipX.clamp(8.0, screenSize.width - measuredSize.width - 8.0);
        
        return Offset(tooltipX, tooltipY);
        
      case AATooltipPosition.left:
        // Center tooltip with target vertically
        double tooltipX = targetPosition.dx - measuredSize.width - actualArrowSize - 4;
        double tooltipY = targetCenter.dy - (measuredSize.height / 2);
        
        // Only adjust if tooltip goes outside screen bounds
        tooltipY = tooltipY.clamp(8.0, screenSize.height - measuredSize.height - 8.0);
        
        return Offset(tooltipX, tooltipY);
        
      case AATooltipPosition.right:
        // Center tooltip with target vertically
        double tooltipX = targetPosition.dx + targetSize.width + actualArrowSize + 4;
        double tooltipY = targetCenter.dy - (measuredSize.height / 2);
        
        // Only adjust if tooltip goes outside screen bounds
        tooltipY = tooltipY.clamp(8.0, screenSize.height - measuredSize.height - 8.0);
        
        return Offset(tooltipX, tooltipY);
        
      case AATooltipPosition.topLeft:
        return Offset(
          targetPosition.dx,
          targetPosition.dy - measuredSize.height - actualArrowSize - 4,
        );
      case AATooltipPosition.topRight:
        return Offset(
          targetPosition.dx + targetSize.width - measuredSize.width,
          targetPosition.dy - measuredSize.height - actualArrowSize - 4,
        );
      case AATooltipPosition.bottomLeft:
        return Offset(
          targetPosition.dx,
          targetPosition.dy + targetSize.height + actualArrowSize + 4,
        );
      case AATooltipPosition.bottomRight:
        return Offset(
          targetPosition.dx + targetSize.width - measuredSize.width,
          targetPosition.dy + targetSize.height + actualArrowSize + 4,
        );
    }
  }

  ArrowDirection _getArrowDirection(AATooltipPosition position) {
    print('_getArrowDirection called with position: $position');
    ArrowDirection direction;
    switch (position) {
      case AATooltipPosition.top:
      case AATooltipPosition.topLeft:
      case AATooltipPosition.topRight:
        direction = ArrowDirection.down;
        break;
      case AATooltipPosition.bottom:
      case AATooltipPosition.bottomLeft:
      case AATooltipPosition.bottomRight:
        direction = ArrowDirection.up;
        break;
      case AATooltipPosition.left:
        direction = ArrowDirection.right;
        break;
      case AATooltipPosition.right:
        direction = ArrowDirection.left;
        break;
    }
    print('Arrow direction calculated as: $direction');
    return direction;
  }
}

/// Standalone content widget for measurement
class _TooltipContent extends StatelessWidget {
  const _TooltipContent({
    super.key,
    this.message,
    this.child,
    required this.config,
  }) : assert(message != null || child != null, 'Either message or child must be provided');

  final String? message;
  final Widget? child;
  final AATooltipConfig config;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        constraints: BoxConstraints(maxWidth: config.maxWidth),
        margin: config.margin,
        padding: config.padding,
        decoration: BoxDecoration(
          color: config.backgroundColor,
          borderRadius: config.borderRadius,
        ),
        child: child ?? Text(
          message ?? '',
          style: config.textStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

/// Bubble chứa nội dung tooltip
class _TooltipBubble extends StatelessWidget {
  const _TooltipBubble({
    this.message,
    this.child,
    required this.config,
    required this.arrowDirection,
    required this.targetPosition,
    required this.targetSize,
    required this.tooltipPosition,
    required this.measuredSize,
  }) : assert(message != null || child != null, 'Either message or child must be provided');

  final String? message;
  final Widget? child;
  final AATooltipConfig config;
  final ArrowDirection arrowDirection;
  final Offset targetPosition;
  final Size targetSize;
  final Offset tooltipPosition;
  final Size measuredSize;

  @override
  Widget build(BuildContext context) {
    print('_TooltipBubble.build() - showArrow: ${config.showArrow}, arrowDirection: $arrowDirection');
    return Material(
      color: Colors.transparent,
      child: Container(
        constraints: BoxConstraints(maxWidth: config.maxWidth),
        margin: config.margin,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: config.padding,
              decoration: BoxDecoration(
                color: config.backgroundColor,
                borderRadius: config.borderRadius,
                boxShadow: [
                  if (config.elevation > 0)
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: config.elevation,
                      offset: const Offset(0, 2),
                    ),
                ],
              ),
              child: child ?? Text(
                message ?? '',
                style: config.textStyle,
                textAlign: TextAlign.center,
              ),
            ),
            if (config.showArrow) ...[
              _buildArrow(context),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildArrow(BuildContext context) {
    print('_buildArrow() called - direction: $arrowDirection, arrowSize: ${config.arrowSize}');
    
    // Use normal background color
    Color arrowColor = config.backgroundColor;
    print('Using tooltip background color for arrow: $arrowColor');
    
    // Use the exact arrow size specified by user
    double actualArrowSize = config.arrowSize;
    print('Using exact arrow size: $actualArrowSize');
    
    Widget arrow = CustomPaint(
      size: Size(actualArrowSize * 2, actualArrowSize),
      painter: _ArrowPainter(
        color: arrowColor,
        direction: arrowDirection,
      ),
    );

    // Calculate target center
    final targetCenter = Offset(
      targetPosition.dx + targetSize.width / 2,
      targetPosition.dy + targetSize.height / 2,
    );
    
    print('Target center: $targetCenter, tooltip position: $tooltipPosition');
    print('Using measured tooltip size: $measuredSize for arrow bounds checking');

    // Calculate arrow position to point to target center
    Widget positionedArrow;
    switch (arrowDirection) {
      case ArrowDirection.up:
        // Arrow points UP - should be at BOTTOM of tooltip
        double arrowX = targetCenter.dx - tooltipPosition.dx - actualArrowSize;
        // Constrain arrow within tooltip bounds using measured size
        arrowX = arrowX.clamp(4.0, measuredSize.width - actualArrowSize * 2 - 4.0);
        print('Positioning arrow UP at x=$arrowX (constrained within measured width ${measuredSize.width})');
        positionedArrow = Positioned(
          bottom: -actualArrowSize + 1,
          left: arrowX,
          child: arrow,
        );
        break;
      case ArrowDirection.down:
        // Arrow points DOWN - should be at BOTTOM of tooltip
        double arrowX = targetCenter.dx - tooltipPosition.dx - actualArrowSize;
        // Constrain arrow within tooltip bounds using measured size
        arrowX = arrowX.clamp(4.0, measuredSize.width - actualArrowSize * 2 - 4.0);
        print('Positioning arrow DOWN at x=$arrowX (constrained within measured width ${measuredSize.width})');
        positionedArrow = Positioned(
          bottom: -actualArrowSize + 1,
          left: arrowX,
          child: arrow,
        );
        break;
      case ArrowDirection.left:
        // Arrow points LEFT - should be at RIGHT side of tooltip
        double arrowY = targetCenter.dy - tooltipPosition.dy - actualArrowSize / 2;
        // Constrain arrow within tooltip bounds using measured size
        arrowY = arrowY.clamp(4.0, measuredSize.height - actualArrowSize - 4.0);
        print('Positioning arrow LEFT at y=$arrowY (constrained within measured height ${measuredSize.height})');
        positionedArrow = Positioned(
          right: -actualArrowSize + 1,
          top: arrowY,
          child: arrow,
        );
        break;
      case ArrowDirection.right:
        // Arrow points RIGHT - should be at LEFT side of tooltip  
        double arrowY = targetCenter.dy - tooltipPosition.dy - actualArrowSize / 2;
        // Constrain arrow within tooltip bounds using measured size
        arrowY = arrowY.clamp(4.0, measuredSize.height - actualArrowSize - 4.0);
        print('Positioning arrow RIGHT at y=$arrowY (constrained within measured height ${measuredSize.height})');
        positionedArrow = Positioned(
          left: -actualArrowSize + 1,
          top: arrowY,
          child: arrow,
        );
        break;
    }
    
    print('Arrow positioned to point to target center using measured dimensions');
    return positionedArrow;
  }
}

/// Painter để vẽ mũi tên
class _ArrowPainter extends CustomPainter {
  const _ArrowPainter({
    required this.color,
    required this.direction,
  });

  final Color color;
  final ArrowDirection direction;

  @override
  void paint(Canvas canvas, Size size) {
    print('_ArrowPainter.paint() called - direction: $direction, color: $color, size: $size');
    
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();

    switch (direction) {
      case ArrowDirection.up:
        print('Drawing UP arrow');
        path.moveTo(size.width / 2, 0);
        path.lineTo(0, size.height);
        path.lineTo(size.width, size.height);
        break;
      case ArrowDirection.down:
        print('Drawing DOWN arrow');
        path.moveTo(0, 0);
        path.lineTo(size.width, 0);
        path.lineTo(size.width / 2, size.height);
        break;
      case ArrowDirection.left:
        print('Drawing LEFT arrow');
        path.moveTo(0, size.height / 2);
        path.lineTo(size.width, 0);
        path.lineTo(size.width, size.height);
        break;
      case ArrowDirection.right:
        print('Drawing RIGHT arrow');
        path.moveTo(0, 0);
        path.lineTo(0, size.height);
        path.lineTo(size.width, size.height / 2);
        break;
    }

    path.close();
    canvas.drawPath(path, paint);
    print('Arrow painted successfully');
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Hướng của mũi tên
enum ArrowDirection { up, down, left, right }

/// Custom ScrollView để tránh overflow
class CustomSingleChildScrollView extends StatelessWidget {
  const CustomSingleChildScrollView({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: child,
    );
  }
}

 