import 'dart:math' as math;
import 'package:flutter/material.dart';

import 'beauty_close_button.dart';
import 'beauty_confirm_button.dart';
import 'beauty_glass_panel.dart';

/// A glassmorphic modal window featuring a drag-to-dismiss handle,
/// header with an 'X' close button and a vibrant blue checkmark button,
/// smooth spring gesture physics, and adaptive dark/light themes.
class BeautyWindow extends StatefulWidget {
  /// The main content inside the window.
  final Widget child;

  /// Optional title displayed in the window header.
  final String? title;

  /// Maximum width of the window dialog on tablet and desktop screens. Defaults to `480.0`.
  final double maxWidth;

  /// Callback when the blue checkmark button is pressed.
  /// If provided, displays the circular blue checkmark button in the header.
  final VoidCallback? onConfirm;

  /// Callback when the close button is pressed. Defaults to `Navigator.of(context).pop()`.
  final VoidCallback? onClose;

  /// Whether to display the circular 'X' close button. Defaults to `true`.
  final bool showCloseButton;

  /// Whether to display the blue confirm button. Defaults to `true` when [onConfirm] is non-null.
  final bool? showConfirmButton;

  /// Optional custom leading widget in the header.
  final Widget? leading;

  /// Optional custom action widgets in the header.
  final List<Widget>? customActions;

  /// Whether to show the top drag-to-dismiss handle. Defaults to `true`.
  final bool showDragHandle;

  /// Padding inside the window. Defaults to `16.0`.
  final EdgeInsetsGeometry padding;

  /// Corner radius of the window. Defaults to `28.0`.
  final double borderRadius;

  /// Creates a [BeautyWindow].
  const BeautyWindow({
    super.key,
    required this.child,
    this.title,
    this.maxWidth = 480.0,
    this.onConfirm,
    this.onClose,
    this.showCloseButton = true,
    this.showConfirmButton,
    this.leading,
    this.customActions,
    this.showDragHandle = true,
    this.padding = const EdgeInsets.all(20.0),
    this.borderRadius = 28.0,
  });

  @override
  State<BeautyWindow> createState() => _BeautyWindowState();
}

class _BeautyWindowState extends State<BeautyWindow>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  Animation<double>? _anim;
  double _dragOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    )..addListener(() {
        if (_anim != null) {
          setState(() {
            _dragOffset = _anim!.value;
          });
        }
      });
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _onDragStart(DragStartDetails details) {
    if (_animController.isAnimating) {
      _animController.stop();
    }
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (details.primaryDelta != null) {
      setState(() {
        _dragOffset = math.max(0.0, _dragOffset + details.primaryDelta!);
      });
    }
  }

  void _onDragEnd(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0.0;
    if (_dragOffset > 80.0 || velocity > 320.0) {
      if (widget.onClose != null) {
        widget.onClose!();
      } else {
        Navigator.of(context).maybePop();
      }
    } else {
      _anim = Tween<double>(begin: _dragOffset, end: 0.0).animate(
        CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic),
      );
      _animController.forward(from: 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isMobile = mediaQuery.size.width < 600;
    final bottomInset = mediaQuery.viewInsets.bottom;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final shouldShowConfirm = widget.showConfirmButton ?? (widget.onConfirm != null);

    return AnimatedPadding(
      padding: EdgeInsets.only(bottom: bottomInset),
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOutCubic,
      child: GestureDetector(
        onTap: () {
          if (widget.onClose != null) {
            widget.onClose!();
          } else {
            Navigator.of(context).maybePop();
          }
        },
        behavior: HitTestBehavior.opaque,
        child: Align(
          alignment: isMobile ? Alignment.bottomCenter : Alignment.center,
          child: GestureDetector(
            onTap: () {}, // Prevent tap propagation inside the window
            child: Transform.translate(
              offset: Offset(0, _dragOffset),
              child: Opacity(
                opacity: (1.0 - (_dragOffset / 400.0)).clamp(0.4, 1.0),
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: widget.maxWidth,
                    maxHeight: mediaQuery.size.height -
                        bottomInset -
                        (isMobile ? 24.0 : 80.0),
                  ),
                  margin: isMobile
                      ? EdgeInsets.fromLTRB(
                          12,
                          0,
                          12,
                          math.max(12, mediaQuery.padding.bottom + 8),
                        )
                      : const EdgeInsets.all(24.0),
                  child: Material(
                    color: Colors.transparent,
                    child: BeautyGlassPanel(
                      borderRadius: widget.borderRadius,
                      padding: widget.padding,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // 1. Top Drag Handle
                          if (widget.showDragHandle)
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onVerticalDragStart: _onDragStart,
                              onVerticalDragUpdate: _onDragUpdate,
                              onVerticalDragEnd: _onDragEnd,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 2, bottom: 12),
                                  child: Container(
                                    width: 48,
                                    height: 5,
                                    decoration: BoxDecoration(
                                      color: isDark
                                          ? Colors.white30
                                          : Colors.black26,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                          // 2. Window Header (Title, Close 'X' button & Blue Confirm button)
                          if (widget.title != null ||
                              widget.leading != null ||
                              widget.showCloseButton ||
                              shouldShowConfirm ||
                              widget.customActions != null) ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                if (widget.leading != null) ...[
                                  widget.leading!,
                                  const SizedBox(width: 12),
                                ],
                                if (widget.title != null)
                                  Expanded(
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onVerticalDragStart: _onDragStart,
                                      onVerticalDragUpdate: _onDragUpdate,
                                      onVerticalDragEnd: _onDragEnd,
                                      child: Text(
                                        widget.title!,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: isDark
                                              ? Colors.white
                                              : const Color(0xFF1E293B),
                                          letterSpacing: -0.3,
                                        ),
                                      ),
                                    ),
                                  ),
                                if (widget.title == null && widget.leading == null)
                                  const Spacer(),

                                // Action Buttons (X close button and/or Blue Check button)
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (widget.customActions != null)
                                      ...widget.customActions!,
                                    if (widget.showCloseButton) ...[
                                      BeautyCloseButton(
                                        size: 34,
                                        onTap: widget.onClose,
                                      ),
                                      if (shouldShowConfirm)
                                        const SizedBox(width: 8),
                                    ],
                                    if (shouldShowConfirm)
                                      BeautyConfirmButton(
                                        size: 34,
                                        onTap: widget.onConfirm,
                                      ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                          ],

                          // 3. Main Window Body / Content
                          Flexible(
                            child: NotificationListener<ScrollNotification>(
                              onNotification: (notification) {
                                if (notification is OverscrollNotification) {
                                  if (notification.overscroll < 0) {
                                    setState(() {
                                      _dragOffset = math.max(
                                        0.0,
                                        _dragOffset - notification.overscroll * 0.7,
                                      );
                                    });
                                  }
                                } else if (notification is ScrollEndNotification) {
                                  if (_dragOffset > 0) {
                                    if (_dragOffset > 80.0) {
                                      if (widget.onClose != null) {
                                        widget.onClose!();
                                      } else {
                                        Navigator.of(context).maybePop();
                                      }
                                    } else {
                                      _anim = Tween<double>(
                                        begin: _dragOffset,
                                        end: 0.0,
                                      ).animate(
                                        CurvedAnimation(
                                          parent: _animController,
                                          curve: Curves.easeOutCubic,
                                        ),
                                      );
                                      _animController.forward(from: 0.0);
                                    }
                                  }
                                }
                                return false;
                              },
                              child: widget.child,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Helper function to display [BeautyWindow] with animated slide, fade, and scale transitions.
Future<T?> showBeautyWindow<T>(
  BuildContext context, {
  required Widget child,
  String? title,
  double maxWidth = 480.0,
  VoidCallback? onConfirm,
  VoidCallback? onClose,
  bool showCloseButton = true,
  bool? showConfirmButton,
  Widget? leading,
  List<Widget>? customActions,
  bool showDragHandle = true,
  EdgeInsetsGeometry padding = const EdgeInsets.all(20.0),
  double borderRadius = 28.0,
  bool barrierDismissible = true,
  Color? barrierColor,
}) {
  return showGeneralDialog<T>(
    context: context,
    useRootNavigator: true,
    barrierDismissible: barrierDismissible,
    barrierLabel: 'Dismiss Beauty Window',
    barrierColor: barrierColor ?? Colors.black.withValues(alpha: 0.40),
    transitionDuration: const Duration(milliseconds: 340),
    pageBuilder: (dialogContext, anim1, anim2) {
      return BeautyWindow(
        title: title,
        maxWidth: maxWidth,
        onConfirm: onConfirm,
        onClose: onClose,
        showCloseButton: showCloseButton,
        showConfirmButton: showConfirmButton,
        leading: leading,
        customActions: customActions,
        showDragHandle: showDragHandle,
        padding: padding,
        borderRadius: borderRadius,
        child: child,
      );
    },
    transitionBuilder: (context, anim1, anim2, childWidget) {
      final isExiting = anim1.status == AnimationStatus.reverse;
      final curve = isExiting ? Curves.easeInCubic : Curves.easeOutQuart;

      final slideAnimation = Tween<Offset>(
        begin: const Offset(0.0, 0.16),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: anim1, curve: curve));

      final fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: anim1,
          curve: isExiting
              ? const Interval(0.0, 0.75, curve: Curves.easeIn)
              : const Interval(0.0, 0.85, curve: Curves.easeOut),
        ),
      );

      final scaleAnimation = Tween<double>(
        begin: 0.94,
        end: 1.0,
      ).animate(CurvedAnimation(parent: anim1, curve: curve));

      return FadeTransition(
        opacity: fadeAnimation,
        child: SlideTransition(
          position: slideAnimation,
          child: ScaleTransition(
            scale: scaleAnimation,
            alignment: Alignment.bottomCenter,
            child: childWidget,
          ),
        ),
      );
    },
  );
}
