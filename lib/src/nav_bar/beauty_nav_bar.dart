import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'beauty_nav_item.dart';

/// A sleek draggable floating pill navigation bar featuring spring physics,
/// touch drag-tracking with dynamic scale expansion, adaptive light/dark theming,
/// and haptic feedback.
class BeautyNavBar extends StatefulWidget {
  /// The navigation destination items.
  final List<BeautyNavItem> items;

  /// Index of the currently selected navigation item.
  final int currentIndex;

  /// Callback triggered whenever an item is tapped or dragged onto.
  final ValueChanged<int> onChanged;

  /// The height of the navigation bar. Defaults to `64.0`.
  final double height;

  /// Corner radius of the navigation bar container. Defaults to `28.0`.
  final double containerRadius;

  /// Corner radius of the active floating pill. Defaults to `22.0`.
  final double pillRadius;

  /// Background color of the navigation bar container.
  /// If null, automatically resolves based on [Theme.of(context).brightness].
  final Color? backgroundColor;

  /// Border color for the navigation bar container.
  /// If null, automatically resolves based on [Theme.of(context).brightness].
  final Color? borderColor;

  /// Color of the active floating/draggable pill.
  /// If null, automatically resolves based on theme.
  final Color? pillColor;

  /// Color of active icon.
  /// If null, automatically resolves based on theme.
  final Color? activeColor;

  /// Color of unselected/inactive icons.
  /// If null, defaults to subtle slate gray.
  final Color? inactiveColor;

  /// Custom box shadow for the active sliding pill.
  final List<BoxShadow>? pillShadow;

  /// Custom box shadow for the whole navigation bar container.
  final List<BoxShadow>? containerShadow;

  /// Optional builder to customize the rendering of icons or add badges.
  final Widget? Function(
    BuildContext context,
    int index,
    BeautyNavItem item,
    bool isSelected,
    Color color,
  )? customIconBuilder;

  /// Whether haptic clicks are triggered during interactions. Defaults to `true`.
  final bool enableHaptics;

  /// Optional margin around the nav bar.
  final EdgeInsetsGeometry? margin;

  /// Fixed width of the nav bar.
  ///
  /// When `null` (default), the bar expands to fill the available width.
  /// When set, the bar renders at exactly this width and is centered
  /// horizontally within its parent.
  final double? width;

  /// Alignment of the bar when a fixed [width] is set. Defaults to
  /// [Alignment.center].
  final AlignmentGeometry alignment;

  /// Creates a [BeautyNavBar].
  const BeautyNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onChanged,
    this.height = 64.0,
    this.containerRadius = 28.0,
    this.pillRadius = 22.0,
    this.backgroundColor,
    this.borderColor,
    this.pillColor,
    this.activeColor,
    this.inactiveColor,
    this.pillShadow,
    this.containerShadow,
    this.customIconBuilder,
    this.enableHaptics = true,
    this.margin,
    this.width,
    this.alignment = Alignment.center,
  });

  @override
  State<BeautyNavBar> createState() => _BeautyNavBarState();
}

class _BeautyNavBarState extends State<BeautyNavBar> {
  bool _dragging = false;
  double _dragX = 0;

  static const Curve _springCurve = Cubic(0.34, 1.3, 0.64, 1);

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primary = theme.colorScheme.primary;

    // Theme adaptive colors
    final effectiveBg = widget.backgroundColor ??
        (isDark
            ? const Color(0xFF141620).withValues(alpha: 0.95)
            : Colors.white.withValues(alpha: 0.96));

    final effectiveBorder = widget.borderColor ??
        (isDark ? const Color(0xFF222634) : const Color(0xFFE2E8F0));

    final effectivePillColor = widget.pillColor ??
        (isDark
            ? Colors.white.withValues(alpha: 0.16)
            : primary.withValues(alpha: 0.14));

    final effectiveActiveColor =
        widget.activeColor ?? (isDark ? Colors.white : primary);

    final effectiveInactiveColor = widget.inactiveColor ??
        (isDark
            ? Colors.white.withValues(alpha: 0.45)
            : const Color(0xFF64748B));

    final defaultContainerShadow = [
      BoxShadow(
        color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.08),
        blurRadius: 16,
        offset: const Offset(0, 4),
      ),
    ];

    Widget navBarWidget = Directionality(
      textDirection: TextDirection.ltr,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double totalWidth = constraints.maxWidth;
          final int count = widget.items.length;
          final double tabWidth = count > 0 ? (totalWidth / count) : totalWidth;
          const double minX = 0;
          final double maxX = (totalWidth - tabWidth).clamp(0.0, totalWidth);
          final bool hasSelection =
              widget.currentIndex >= 0 && widget.currentIndex < count;
          final double baseX =
              hasSelection ? (widget.currentIndex * tabWidth) : -tabWidth * 2;
          final double pillX = _dragging ? _dragX : baseX;

          return SizedBox(
            height: widget.height,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                // 1. Navigation Bar Outer Track
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: effectiveBg,
                      borderRadius:
                          BorderRadius.circular(widget.containerRadius),
                      border: Border.all(color: effectiveBorder, width: 1.0),
                      boxShadow:
                          widget.containerShadow ?? defaultContainerShadow,
                    ),
                  ),
                ),

                // 2. Active Draggable Pill (Scales up & expands during drag)
                AnimatedPositioned(
                  duration: _dragging
                      ? Duration.zero
                      : const Duration(milliseconds: 450),
                  curve: _springCurve,
                  left: pillX,
                  top: _dragging ? -7 : 5,
                  bottom: _dragging ? -7 : 5,
                  width: tabWidth,
                  child: AnimatedOpacity(
                    opacity: (hasSelection || _dragging) ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 200),
                    child: AnimatedScale(
                      scale: _dragging ? 1.14 : 1.0,
                      duration: const Duration(milliseconds: 180),
                      curve: Curves.easeOutCubic,
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: _dragging ? 3 : 5,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          color: effectivePillColor,
                          borderRadius:
                              BorderRadius.circular(widget.pillRadius),
                          boxShadow: widget.pillShadow ??
                              (isDark
                                  ? [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: _dragging ? 0.28 : 0.18,
                                        ),
                                        blurRadius: _dragging ? 12 : 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ]
                                  : [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: _dragging ? 0.10 : 0.05,
                                        ),
                                        blurRadius: _dragging ? 10 : 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ]),
                        ),
                      ),
                    ),
                  ),
                ),

                // 3. Gesture Layer & Icon Buttons
                Positioned.fill(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onHorizontalDragStart: (details) {
                      if (widget.enableHaptics) {
                        HapticFeedback.selectionClick();
                      }
                      setState(() {
                        _dragging = true;
                        _dragX = hasSelection ? baseX : 0;
                      });
                    },
                    onHorizontalDragUpdate: (details) {
                      final double delta =
                          details.primaryDelta ?? details.delta.dx;
                      final double next = _dragX + delta;
                      setState(() {
                        if (next < minX || next > maxX) {
                          _dragX += delta * 0.18;
                        } else {
                          _dragX = next;
                        }
                        _dragX = _dragX.clamp(minX - 16, maxX + 16);
                      });
                    },
                    onHorizontalDragEnd: (details) {
                      final double velocity =
                          details.velocity.pixelsPerSecond.dx;
                      final double frac =
                          tabWidth > 0 ? (_dragX / tabWidth) : 0;

                      int index;
                      if (velocity > 700) {
                        index = frac.floor() + 1;
                      } else if (velocity < -700) {
                        index = frac.ceil() - 1;
                      } else {
                        index = frac.round();
                      }

                      index = index.clamp(0, widget.items.length - 1);

                      if (index != widget.currentIndex &&
                          widget.enableHaptics) {
                        HapticFeedback.selectionClick();
                      }
                      setState(() => _dragging = false);
                      widget.onChanged(index);
                    },
                    onHorizontalDragCancel: () {
                      setState(() => _dragging = false);
                    },
                    child: Row(
                      children: List.generate(widget.items.length, (i) {
                        final item = widget.items[i];
                        final bool active =
                            hasSelection && (i == widget.currentIndex);
                        final Color color = active
                            ? effectiveActiveColor
                            : effectiveInactiveColor;

                        final customIcon = widget.customIconBuilder?.call(
                          context,
                          i,
                          item,
                          active,
                          color,
                        );

                        final iconData = (active && item.activeIcon != null)
                            ? item.activeIcon!
                            : item.icon;

                        return Expanded(
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              if (widget.enableHaptics) {
                                HapticFeedback.selectionClick();
                              }
                              widget.onChanged(i);
                            },
                            child: SizedBox(
                              height: double.infinity,
                              child: Center(
                                child: customIcon ??
                                    Stack(
                                      alignment: Alignment.center,
                                      clipBehavior: Clip.none,
                                      children: [
                                        Icon(iconData, size: 24, color: color),
                                        if (item.badge != null)
                                          Positioned(
                                            top: -4,
                                            right: -8,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 5,
                                                vertical: 1.5,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.redAccent,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              constraints: const BoxConstraints(
                                                minWidth: 16,
                                                minHeight: 16,
                                              ),
                                              child: Text(
                                                item.badge!,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    if (widget.width != null) {
      navBarWidget = Align(
        alignment: widget.alignment,
        heightFactor: 1.0,
        child: SizedBox(
          width: widget.width,
          child: navBarWidget,
        ),
      );
    }

    if (widget.margin != null) {
      navBarWidget = Padding(
        padding: widget.margin!,
        child: navBarWidget,
      );
    }

    return navBarWidget;
  }
}
