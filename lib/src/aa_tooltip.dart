import 'package:flutter/material.dart';
import 'aa_tooltip_types.dart';
import 'aa_tooltip_controller.dart';
import 'aa_tooltip_widget.dart';

/// Lớp chính để hiển thị tooltip
class AATooltip {
  static final Map<String, AATooltipController> _controllers = {};
  static final Map<String, OverlayEntry> _overlayEntries = {};

  /// Hiển thị tooltip
  /// 
  /// [message] - Nội dung tooltip
  /// [child] - Widget để hiển thị tooltip (nếu có)
  /// [config] - Cấu hình tooltip
  /// [id] - ID duy nhất cho tooltip (mặc định là 'default')
  /// [autoHide] - Tự động ẩn tooltip (override config.autoHide)
  /// [hideAfter] - Thời gian tự động ẩn (override config.hideDelay)
  static void show({
    required BuildContext context,
    String? message,
    Widget? child,
    AATooltipConfig config = const AATooltipConfig(),
    String id = 'default',
    bool? autoHide,
    Duration? hideAfter,
  }) {
    assert(message != null || child != null, 'Either message or child must be provided');
    print('show tooltip $id');
    // Ẩn tooltip hiện tại nếu có
    hide(id: id);

    // Override config với parameters nếu có
    if (autoHide != null || hideAfter != null) {
      config = config.copyWith(
        autoHide: autoHide,
        hideDelay: hideAfter,
      );
    }

    print('Creating controller for $id');
    // Tạo controller mới
    final controller = AATooltipController(config: config);
    _controllers[id] = controller;

    print('Creating overlay entry for $id');
    // Tạo overlay entry với targetContext là context được truyền vào
    final overlayEntry = OverlayEntry(
      builder: (overlayContext) {
        print('Building overlay entry for $id');
        return AATooltipWidget(
          controller: controller,
          targetContext: context,  // Sử dụng context gốc, không phải overlay context
        );
      },
    );

    _overlayEntries[id] = overlayEntry;

    print('Getting overlay from context');
    // Thêm vào overlay
    final overlay = Overlay.of(context);
    print('Overlay found: ${overlay != null}');
    
    print('Inserting overlay entry');
    overlay.insert(overlayEntry);
    print('Overlay entry inserted successfully');

    // Hiển thị tooltip
    print('Calling controller.show()');
    controller.show(message: message, child: child);
    print('Controller.show() completed');
  }

  /// Hiển thị tooltip không tự ẩn
  static void showPersistent({
    required BuildContext context,
    required String message,
    AATooltipConfig config = const AATooltipConfig(),
    String id = 'default',
  }) {
    show(
      context: context,
      message: message,
      config: config,
      id: id,
      autoHide: false, // Force không tự ẩn
    );
  }

  /// Hiển thị tooltip với thời gian tự ẩn tùy chỉnh
  static void showTimed({
    required BuildContext context,
    required String message,
    required Duration duration,
    AATooltipConfig config = const AATooltipConfig(),
    String id = 'default',
  }) {
    show(
      context: context,
      message: message,
      config: config,
      id: id,
      autoHide: true,
      hideAfter: duration,
    );
  }

  /// Ẩn tooltip
  static void hide({String id = 'default'}) {
    final controller = _controllers[id];
    final overlayEntry = _overlayEntries[id];

    if (controller != null && overlayEntry != null) {
      controller.hide();
      
      // Sử dụng addPostFrameCallback thay vì Timer để tránh pending timer issues
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_overlayEntries.containsKey(id)) {
          overlayEntry.remove();
          _overlayEntries.remove(id);
          controller.dispose();
          _controllers.remove(id);
        }
      });
    }
  }

  /// Ẩn tất cả tooltip
  static void hideAll() {
    final ids = List<String>.from(_controllers.keys);
    for (final id in ids) {
      hide(id: id);
    }
  }

  /// Kiểm tra tooltip có đang hiển thị hay không
  static bool isVisible({String id = 'default'}) {
    return _controllers[id]?.isVisible ?? false;
  }
}

/// Widget wrapper để hiển thị tooltip dễ dàng hơn
class AATooltipWrapper extends StatefulWidget {
  const AATooltipWrapper({
    super.key,
    required this.child,
    required this.message,
    this.config = const AATooltipConfig(),
    this.showOnTap = true,
    this.showOnLongPress = false,
    this.id = 'default',
  });

  final Widget child;
  final String message;
  final AATooltipConfig config;
  final bool showOnTap;
  final bool showOnLongPress;
  final String id;

  @override
  State<AATooltipWrapper> createState() => _AATooltipWrapperState();
}

class _AATooltipWrapperState extends State<AATooltipWrapper> {
  @override
  Widget build(BuildContext context) {
    print('build tooltip ${widget.child}');
    return GestureDetector(
      onTap: widget.showOnTap ? _showTooltip : null,
      onLongPress: widget.showOnLongPress ? _showTooltip : null,
      child: widget.child,
    );
  }

  void _showTooltip() {
    AATooltip.show(
      context: context,
      message: widget.message,
      config: widget.config,
      id: widget.id,
    );
  }

  @override
  void dispose() {
    AATooltip.hide(id: widget.id);
    super.dispose();
  }
}

/// Extension để dễ dàng thêm tooltip vào widget
extension AATooltipExtension on Widget {
  /// Thêm tooltip vào widget
  Widget tooltip({
    required String message,
    AATooltipConfig config = const AATooltipConfig(),
    bool showOnTap = true,
    bool showOnLongPress = false,
    String id = 'default',
  }) {
    return AATooltipWrapper(
      message: message,
      config: config,
      showOnTap: showOnTap,
      showOnLongPress: showOnLongPress,
      id: id,
      child: this,
    );
  }
} 