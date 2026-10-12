import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'segmented_item.dart';

/// An interactive, fluid segmented bar featuring smooth spring drag physics,
/// dynamic scale expansion, adaptive light/dark theming, and full RTL support.
class BeautySegmentedBar extends StatefulWidget {
  /// The list of items displayed in the segmented bar.
  final List<BeautySegmentedItem> items;

  /// The index of the currently active/selected item.
  final int currentIndex;

  /// Callback fired whenever a segment is tapped or dragged into.
  final ValueChanged<int> onChanged;

  /// The total height of the segmented bar. Defaults to `46.0`.
  final double height;

  /// Background color of the segmented bar track.
  /// If null, automatically adapts to the current [Theme.of(context).brightness].
  final Color? trackColor;

  /// Optional border color for the track container.
  final Color? trackBorderColor;

  /// Color of the active sliding pill.
  /// If null, automatically adapts to the current [Theme.of(context).brightness].
  final Color? pillColor;

  /// Optional border color for the active sliding pill.
  final Color? pillBorderColor;

  /// Color of the label and icon when the segment is active.
  /// If null, defaults to cyan in dark mode and primary in light mode.
  final Color? activeColor;

  /// Color of the label and icon when the segment is inactive.
  /// If null, uses subtle neutral tone matching dark/light mode.
  final Color? inactiveColor;

  /// Padding around the segmented bar widget.
  final EdgeInsetsGeometry padding;

  /// Corner radius of the track and pill. Defaults to `100.0` (pill-shaped).
  final double borderRadius;

  /// Whether to trigger subtle haptic vibrations on tap and drag transitions.
  final bool enableHaptics;

  /// Optional custom box shadows for the active pill.
  final List<BoxShadow>? pillShadows;

  /// Fixed width of the segmented bar.
  ///
  /// When `null` (default), the bar expands to fill the available width.
  /// When set, the bar renders at exactly this width and is aligned
  /// horizontally according to [alignment].
  final double? width;

  /// Alignment of the bar when a fixed [width] is set. Defaults to
  /// [Alignment.center].
  final AlignmentGeometry alignment;

  /// Creates a [BeautySegmentedBar].
  const BeautySegmentedBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onChanged,
    this.height = 46.0,
    this.trackColor,
    this.trackBorderColor,
    this.pillColor,
    this.pillBorderColor,
    this.activeColor,
    this.inactiveColor,
    this.padding = EdgeInsets.zero,
    this.borderRadius = 100.0,
    this.enableHaptics = true,
    this.pillShadows,
    this.width,
    this.alignment = Alignment.center,
  });

  /// Convenient constructor that builds segments from a simple list of strings.
  factory BeautySegmentedBar.fromStrings({
    Key? key,
    required List<String> items,
    required int currentIndex,
    required ValueChanged<int> onChanged,
    double height = 46.0,
    Color? trackColor,
    Color? trackBorderColor,
    Color? pillColor,
    Color? pillBorderColor,
    Color? activeColor,
    Color? inactiveColor,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    double borderRadius = 100.0,
    bool enableHaptics = true,
    List<BoxShadow>? pillShadows,
    double? width,
    AlignmentGeometry alignment = Alignment.center,
  }) {
    return BeautySegmentedBar(
      key: key,
      items: items.map((e) => BeautySegmentedItem(label: e)).toList(),
      currentIndex: currentIndex,
      onChanged: onChanged,
      height: height,
      trackColor: trackColor,
      trackBorderColor: trackBorderColor,
      pillColor: pillColor,
      pillBorderColor: pillBorderColor,
      activeColor: activeColor,
      inactiveColor: inactiveColor,
      padding: padding,
      borderRadius: borderRadius,
      enableHaptics: enableHaptics,
      pillShadows: pillShadows,
      width: width,
      alignment: alignment,
    );
  }

  @override
  State<BeautySegmentedBar> createState() => _BeautySegmentedBarState();
}

class _BeautySegmentedBarState extends State<BeautySegmentedBar> {
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

    // Theme-adaptive color resolution
    final effectiveTrackColor = widget.trackColor ??
        (isDark ? const Color(0xFF161821) : const Color(0xFFEAEBED));

    final effectiveTrackBorder = widget.trackBorderColor;

    final effectivePillColor =
        widget.pillColor ?? (isDark ? const Color(0xFF1E222D) : Colors.white);

    final effectivePillBorder = widget.pillBorderColor;

    final effectiveActiveColor = widget.activeColor ??
        (isDark ? const Color(0xFF22D3EE) : theme.colorScheme.primary);

    final effectiveInactiveColor = widget.inactiveColor ??
        (isDark ? const Color(0xFF8E919E) : const Color(0xFF64748B));

    final isRtl = Directionality.of(context) == TextDirection.rtl;

    Widget segmentedBar = LayoutBuilder(
      builder: (context, constraints) {
        final double totalWidth = constraints.maxWidth;
        final int count = widget.items.length;
        final double tabWidth = count > 0 ? (totalWidth / count) : totalWidth;
        final double minX = 0;
        final double maxX = (totalWidth - tabWidth).clamp(0.0, totalWidth);
        final int safeCurrentIndex = widget.currentIndex.clamp(0, count - 1);
        final double baseX = safeCurrentIndex * tabWidth;
        final double pillX = _dragging ? _dragX : baseX;

        return SizedBox(
          height: widget.height,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              // 1. Track Background Container
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: effectiveTrackColor,
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    border: effectiveTrackBorder != null
                        ? Border.all(color: effectiveTrackBorder, width: 1)
                        : null,
                  ),
                ),
              ),

              // 2. Draggable Animated Active Pill
              AnimatedPositioned(
                duration: _dragging
                    ? Duration.zero
                    : const Duration(milliseconds: 320),
                curve: _springCurve,
                left: isRtl
                    ? (totalWidth - (pillX + tabWidth - 3))
                        .clamp(0.0, totalWidth)
                    : (pillX + 3).clamp(0.0, totalWidth),
                top: _dragging ? -4 : 4,
                bottom: _dragging ? -4 : 4,
                width: (tabWidth - 6).clamp(0.0, totalWidth),
                child: AnimatedScale(
                  scale: _dragging ? 1.08 : 1.0,
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOutCubic,
                  child: Container(
                    decoration: BoxDecoration(
                      color: effectivePillColor,
                      borderRadius: BorderRadius.circular(
                        _dragging ? 30 : widget.borderRadius,
                      ),
                      border: effectivePillBorder != null
                          ? Border.all(color: effectivePillBorder, width: 1)
                          : null,
                      boxShadow: widget.pillShadows ??
                          [
                            BoxShadow(
                              color: Colors.black.withValues(
                                alpha: isDark
                                    ? (_dragging ? 0.35 : 0.25)
                                    : (_dragging ? 0.12 : 0.06),
                              ),
                              blurRadius: _dragging ? 10 : 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                    ),
                  ),
                ),
              ),

              // 3. Tab Items & Gesture Interaction Layer
              Positioned.fill(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onHorizontalDragStart: (_) {
                    if (widget.enableHaptics) HapticFeedback.selectionClick();
                    setState(() {
                      _dragging = true;
                      _dragX = baseX;
                    });
                  },
                  onHorizontalDragUpdate: (details) {
                    final double delta =
                        details.primaryDelta ?? details.delta.dx;
                    final double dx = isRtl ? -delta : delta;
                    final double next = _dragX + dx;
                    setState(() {
                      if (next < minX || next > maxX) {
                        _dragX += dx * 0.18;
                      } else {
                        _dragX = next;
                      }
                      _dragX = _dragX.clamp(minX - 16, maxX + 16);
                    });
                  },
                  onHorizontalDragEnd: (details) {
                    final double rawVelocity =
                        details.velocity.pixelsPerSecond.dx;
                    final double velocity = isRtl ? -rawVelocity : rawVelocity;
                    final double frac = tabWidth > 0 ? (_dragX / tabWidth) : 0;

                    int index;
                    if (velocity > 500) {
                      index = frac.floor() + 1;
                    } else if (velocity < -500) {
                      index = frac.ceil() - 1;
                    } else {
                      index = frac.round();
                    }
                    index = index.clamp(0, widget.items.length - 1);

                    if (index != widget.currentIndex && widget.enableHaptics) {
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
                      final bool active = i == widget.currentIndex;
                      final color = active
                          ? effectiveActiveColor
                          : effectiveInactiveColor;

                      return Expanded(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            if (widget.enableHaptics) {
                              HapticFeedback.lightImpact();
                            }
                            widget.onChanged(i);
                          },
                          child: SizedBox(
                            height: double.infinity,
                            child: Center(
                              child: item.customWidget ??
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (item.icon != null) ...[
                                        Icon(
                                          item.icon,
                                          size: 17,
                                          color: color,
                                        ),
                                        const SizedBox(width: 6),
                                      ],
                                      Flexible(
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            item.label,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 13.5,
                                              fontWeight: active
                                                  ? FontWeight.w600
                                                  : FontWeight.w500,
                                              color: color,
                                              letterSpacing: -0.2,
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
    );

    if (widget.width != null) {
      segmentedBar = Align(
        alignment: widget.alignment,
        heightFactor: 1.0,
        child: SizedBox(
          width: widget.width,
          child: segmentedBar,
        ),
      );
    }

    if (widget.padding != EdgeInsets.zero) {
      segmentedBar = Padding(
        padding: widget.padding,
        child: segmentedBar,
      );
    }

    return segmentedBar;
  }
}
