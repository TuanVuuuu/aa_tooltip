import 'package:flutter/material.dart';

/// Vị trí hiển thị tooltip
enum AATooltipPosition {
  top,
  bottom,
  left,
  right,
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
}

/// Cấu hình cho tooltip
class AATooltipConfig {
  const AATooltipConfig({
    this.backgroundColor = const Color(0xDD000000),
    this.textStyle = const TextStyle(color: Colors.white, fontSize: 14),
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.margin = const EdgeInsets.all(0),
    this.borderRadius = const BorderRadius.all(Radius.circular(6)),
    this.elevation = 6.0,
    this.maxWidth = 300.0,
    this.position = AATooltipPosition.top,
    this.showArrow = true,
    this.arrowSize = 6.0,
    this.autoHide = true,
    this.hideDelay = const Duration(seconds: 2),
    this.animationDuration = const Duration(milliseconds: 300),
  });

  /// Màu nền
  final Color backgroundColor;

  /// Style text
  final TextStyle textStyle;

  /// Padding bên trong
  final EdgeInsets padding;

  /// Margin bên ngoài  
  final EdgeInsets margin;

  /// Bo góc
  final BorderRadius borderRadius;

  /// Độ cao bóng đổ
  final double elevation;

  /// Chiều rộng tối đa
  final double maxWidth;

  /// Vị trí hiển thị
  final AATooltipPosition position;

  /// Hiển thị mũi tên
  final bool showArrow;

  /// Kích thước mũi tên
  final double arrowSize;

  /// Tự động ẩn
  final bool autoHide;

  /// Thời gian tự động ẩn
  final Duration hideDelay;

  /// Thời gian animation
  final Duration animationDuration;

  /// Copy với các giá trị mới
  AATooltipConfig copyWith({
    Color? backgroundColor,
    TextStyle? textStyle,
    EdgeInsets? padding,
    EdgeInsets? margin,
    BorderRadius? borderRadius,
    double? elevation,
    double? maxWidth,
    AATooltipPosition? position,
    bool? showArrow,
    double? arrowSize,
    bool? autoHide,
    Duration? hideDelay,
    Duration? animationDuration,
  }) {
    return AATooltipConfig(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textStyle: textStyle ?? this.textStyle,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      borderRadius: borderRadius ?? this.borderRadius,
      elevation: elevation ?? this.elevation,
      maxWidth: maxWidth ?? this.maxWidth,
      position: position ?? this.position,
      showArrow: showArrow ?? this.showArrow,
      arrowSize: arrowSize ?? this.arrowSize,
      autoHide: autoHide ?? this.autoHide,
      hideDelay: hideDelay ?? this.hideDelay,
      animationDuration: animationDuration ?? this.animationDuration,
    );
  }
} 