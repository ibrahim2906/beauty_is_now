import 'package:flutter/material.dart';

/// A circular close 'X' button designed with soft shadow and adaptive dark/light styling.
class BeautyCloseButton extends StatelessWidget {
  /// Callback triggered when tapped. Defaults to popping the current navigator route.
  final VoidCallback? onTap;

  /// Diameter of the button circle. Defaults to `34.0`.
  final double size;

  /// Custom background color.
  /// If null, adapts to light/dark mode.
  final Color? backgroundColor;

  /// Custom icon color.
  final Color? iconColor;

  /// Creates a [BeautyCloseButton].
  const BeautyCloseButton({
    super.key,
    this.onTap,
    this.size = 34.0,
    this.backgroundColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final defaultBg = isDark ? const Color(0xFF2C2C2E) : Colors.white;
    final defaultIcon = isDark ? Colors.white70 : Colors.black87;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap ?? () => Navigator.of(context).maybePop(),
        customBorder: const CircleBorder(),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: backgroundColor ?? defaultBg,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.40 : 0.12),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Icon(
              Icons.close,
              size: size * 0.52,
              color: iconColor ?? defaultIcon,
            ),
          ),
        ),
      ),
    );
  }
}
