import 'dart:async';
import 'package:flutter/material.dart';
import 'aa_tooltip_types.dart';

/// Controller để quản lý tooltip
class AATooltipController extends ChangeNotifier {
  AATooltipController({
    required this.config,
  });

  final AATooltipConfig config;
  
  bool _isVisible = false;
  String? _message;
  Widget? _child;
  Timer? _hideTimer;
  
  /// Có đang hiển thị tooltip hay không
  bool get isVisible => _isVisible;
  
  /// Nội dung tooltip
  String? get message => _message;
  
  /// Widget child
  Widget? get child => _child;

  /// Hiển thị tooltip
  void show({
    String? message,
    Widget? child,
  }) {
    assert(message != null || child != null, 'Either message or child must be provided');
    
    print('AATooltipController.show() called with message: "$message", child: $child');
    
    _message = message;
    _child = child;

    final waitDuration = Duration.zero; // Always show immediately now
    print('Message and child set. waitDuration: $waitDuration');

    if (waitDuration == Duration.zero) {
      print('No wait duration, showing immediately');
      _showTooltip();
    } else {
      print('Waiting ${waitDuration.inMilliseconds}ms before showing');
      Timer(waitDuration, _showTooltip);
    }
    
    print('AATooltipController.show() completed');
  }
  
  void _showTooltip() {
    print('_showTooltip() called');
    _isVisible = true;
    print('_isVisible set to true, calling notifyListeners()');
    notifyListeners();
    print('notifyListeners() called, scheduling hide');
    _scheduleHide();
  }
  
  /// Ẩn tooltip
  void hide() {
    print('AATooltipController.hide() called');
    _hideTimer?.cancel();
    _isVisible = false;
    _message = null;
    _child = null;
    print('_isVisible set to false, calling notifyListeners()');
    notifyListeners();
    print('AATooltipController.hide() completed');
  }
  
  /// Lên lịch ẩn tooltip tự động
  void _scheduleHide() {
    print('_scheduleHide called: autoHide=${config.autoHide}, hideDelay=${config.hideDelay}');
    
    // Cancel existing timer
    _hideTimer?.cancel();
    
    if (config.autoHide) {
      print('Scheduling auto hide after ${config.hideDelay}');
      _hideTimer = Timer(config.hideDelay, () {
        print('Auto hide timer triggered');
        hide();
      });
    } else {
      print('Auto hide disabled');
    }
  }
  
  @override
  void dispose() {
    print('AATooltipController.dispose() called');
    _hideTimer?.cancel();
    super.dispose();
  }
} 