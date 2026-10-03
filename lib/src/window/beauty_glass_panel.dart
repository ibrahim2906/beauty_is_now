import 'dart:ui';
import 'package:flutter/material.dart';

/// A sleek frosted-glass container with backdrop blur, subtle borders,
/// and adaptive light/dark mode shadows.
class BeautyGlassPanel extends StatelessWidget {
  /// The widget rendered inside the glass panel.
  final Widget child;

  /// Explicit width for the panel.
  final double? width;

  /// Explicit height for the panel.
  final double? height;

  /// Padding inside the glass panel.
  final EdgeInsetsGeometry? padding;

  /// Margin outside the glass panel.
  final EdgeInsetsGeometry? margin;

  /// Corner radius of the panel. Defaults to `24.0`.
  final double borderRadius;

  /// Horizontal blur sigma for the backdrop filter. Defaults to `30.0`.
  final double blurX;

  /// Vertical blur sigma for the backdrop filter. Defaults to `30.0`.
  final double blurY;

  /// Panel background color.
  /// If null, automatically uses translucent dark or light frost.
  final Color? fillColor;

  /// Panel border color.
  /// If null, automatically uses translucent hairline border.
  final Color? borderColor;

  /// Panel border width. Defaults to `1.0`.
  final double borderWidth;

  /// Custom box shadows.
  final List<BoxShadow>? customShadows;

  /// Creates a [BeautyGlassPanel].
  const BeautyGlassPanel({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.borderRadius = 24.0,
    this.blurX = 30.0,
    this.blurY = 30.0,
    this.fillColor,
    this.borderColor,
    this.borderWidth = 1.0,
    this.customShadows,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final defaultFill = isDark
        ? const Color(0xFF1C1C1E).withValues(alpha: 0.75)
        : Colors.white.withValues(alpha: 0.78);

    final defaultBorder = isDark
        ? Colors.white.withValues(alpha: 0.08)
        : Colors.white.withValues(alpha: 0.6);

    final defaultShadows = [
      BoxShadow(
        color: Colors.black.withValues(alpha: isDark ? 0.45 : 0.10),
        blurRadius: 30,
        offset: const Offset(0, 10),
      ),
    ];

    Widget content = Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: fillColor ?? defaultFill,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: borderColor ?? defaultBorder,
          width: borderWidth,
        ),
        boxShadow: customShadows ?? defaultShadows,
      ),
      child: child,
    );

    content = ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurX, sigmaY: blurY),
        child: content,
      ),
    );

    if (margin != null) {
      content = Padding(padding: margin!, child: content);
    }

    return content;
  }
}
