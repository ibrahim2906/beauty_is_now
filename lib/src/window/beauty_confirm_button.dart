import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A vibrant circular confirm / checkmark button with smooth tap physics
/// and subtle elevation shadow.
class BeautyConfirmButton extends StatefulWidget {
  /// Callback triggered when the confirm button is tapped.
  final VoidCallback? onTap;

  /// Diameter of the circular button. Defaults to `36.0`.
  final double size;

  /// Background color of the button. Defaults to `Colors.blueAccent`.
  final Color backgroundColor;

  /// Icon color. Defaults to `Colors.white`.
  final Color iconColor;

  /// Icon to display. Defaults to [CupertinoIcons.checkmark].
  final IconData icon;

  /// Whether to play haptic feedback on tap. Defaults to true.
  final bool enableHaptics;

  /// Creates a [BeautyConfirmButton].
  const BeautyConfirmButton({
    super.key,
    required this.onTap,
    this.size = 36.0,
    this.backgroundColor = Colors.blueAccent,
    this.iconColor = Colors.white,
    this.icon = CupertinoIcons.checkmark,
    this.enableHaptics = true,
  });

  @override
  State<BeautyConfirmButton> createState() => _BeautyConfirmButtonState();
}

class _BeautyConfirmButtonState extends State<BeautyConfirmButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: () {
        if (widget.enableHaptics) {
          HapticFeedback.lightImpact();
        }
        widget.onTap?.call();
      },
      child: AnimatedScale(
        scale: _isPressed ? 0.90 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOutCubic,
        child: Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.backgroundColor,
            boxShadow: [
              BoxShadow(
                color: widget.backgroundColor.withValues(alpha: 0.38),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Icon(
              widget.icon,
              color: widget.iconColor,
              size: widget.size * 0.52,
            ),
          ),
        ),
      ),
    );
  }
}
