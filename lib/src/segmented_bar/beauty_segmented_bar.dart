import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'segmented_item.dart';

/// An interactive, fluid segmented bar featuring smooth spring drag physics,
/// dynamic scale expansion, adaptive light/dark theming, and full RTL support.
///
/// Every visual and behavioural aspect can be tuned: size ([width], [height],
/// [pillPadding], [segmentPadding]), typography ([textStyle],
/// [activeTextStyle], [iconSize], [iconSpacing]), colors, borders, shadows,
/// drag physics ([dragEnabled], [dragScale], [dragExpand]) and animation
/// timing ([animationDuration], [animationCurve]).
class BeautySegmentedBar extends StatefulWidget {
  /// The list of items displayed in the segmented bar.
  final List<BeautySegmentedItem> items;

  /// The index of the currently active/selected item.
  final int currentIndex;

  /// Callback fired whenever a segment is tapped or dragged into.
  final ValueChanged<int> onChanged;

  /// The total height of the segmented bar. Defaults to `46.0`.
  ///
  /// The active pill is inset from the track by [pillPadding], so the usable
  /// content height is `height - pillPadding.vertical`.
  final double height;

  /// Fixed width of the segmented bar.
  ///
  /// When `null` (default), the bar expands to fill the available width.
  /// When set, the bar renders at exactly this width and is aligned
  /// horizontally according to [alignment].
  final double? width;

  /// Optional maximum width of the bar.
  ///
  /// Useful together with a `null` [width] to keep a responsive bar from
  /// becoming too wide on tablets and desktop. Ignored when [width] is set.
  final double? maxWidth;

  /// Alignment of the bar when a fixed [width] (or [maxWidth]) is applied.
  /// Defaults to [Alignment.center].
  final AlignmentGeometry alignment;

  /// Background color of the segmented bar track.
  /// If null, automatically adapts to the current [Theme.of(context).brightness].
  final Color? trackColor;

  /// Optional border color for the track container.
  final Color? trackBorderColor;

  /// Width of the track border in logical pixels. Defaults to `1.0`.
  /// Only drawn when [trackBorderColor] is set.
  final double trackBorderWidth;

  /// Color of the active sliding pill.
  /// If null, automatically adapts to the current [Theme.of(context).brightness].
  final Color? pillColor;

  /// Optional border color for the active sliding pill.
  final Color? pillBorderColor;

  /// Width of the pill border in logical pixels. Defaults to `1.0`.
  /// Only drawn when [pillBorderColor] is set.
  final double pillBorderWidth;

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

  /// Inset of the active pill inside the track. Defaults to
  /// `EdgeInsets.symmetric(horizontal: 3, vertical: 4)`.
  ///
  /// Increase it for a floating pill that sits further from the track edge,
  /// set it to [EdgeInsets.zero] for a pill that fills the segment exactly.
  final EdgeInsetsGeometry pillPadding;

  /// Padding applied inside every segment, around its label/icon. Defaults to
  /// `EdgeInsets.symmetric(horizontal: 4)`.
  final EdgeInsetsGeometry segmentPadding;

  /// Base text style for segment labels.
  ///
  /// Defaults to a 13.5px, medium-weight label with slight negative letter
  /// spacing. The segment's active/inactive [Color] is applied on top, unless
  /// the provided style already defines a `color`, in which case it is kept.
  final TextStyle? textStyle;

  /// Additional text style merged over [textStyle] for the active segment only.
  /// Use it to emphasise the selected label (weight, size, color...).
  final TextStyle? activeTextStyle;

  /// Size of the leading icon in logical pixels. Defaults to `17.0`.
  final double iconSize;

  /// Horizontal gap between the icon and the label. Defaults to `6.0`.
  final double iconSpacing;

  /// Whether to trigger subtle haptic vibrations on tap and drag transitions.
  final bool enableHaptics;

  /// Whether the user can drag the pill across segments. Defaults to `true`.
  /// When `false`, the bar still responds to taps.
  final bool dragEnabled;

  /// Whether the pill grows beyond the track while being dragged.
  /// Defaults to `4.0`; set to `0` to keep the pill inside the track.
  final double dragExpand;

  /// Scale of the pill while it is being dragged. Defaults to `1.08`.
  final double dragScale;

  /// Corner radius of the pill while it is being dragged.
  /// Defaults to [borderRadius] (fully pill-shaped).
  final double? dragBorderRadius;

  /// Whether the bar accepts taps and drags. Defaults to `true`.
  /// When `false`, the bar renders its current selection as a static,
  /// non-interactive display.
  final bool enabled;

  /// Duration of the pill snap animation. Defaults to `320ms`.
  final Duration animationDuration;

  /// Curve of the pill snap animation.
  /// Defaults to a spring-like [Cubic] overshoot.
  final Curve animationCurve;

  /// Optional custom box shadows for the active pill.
  final List<BoxShadow>? pillShadows;

  /// Creates a [BeautySegmentedBar].
  const BeautySegmentedBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onChanged,
    this.height = 46.0,
    this.width,
    this.maxWidth,
    this.alignment = Alignment.center,
    this.trackColor,
    this.trackBorderColor,
    this.trackBorderWidth = 1.0,
    this.pillColor,
    this.pillBorderColor,
    this.pillBorderWidth = 1.0,
    this.activeColor,
    this.inactiveColor,
    this.padding = EdgeInsets.zero,
    this.borderRadius = 100.0,
    this.pillPadding = const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
    this.segmentPadding = const EdgeInsets.symmetric(horizontal: 4),
    this.textStyle,
    this.activeTextStyle,
    this.iconSize = 17.0,
    this.iconSpacing = 6.0,
    this.enableHaptics = true,
    this.dragEnabled = true,
    this.dragExpand = 4.0,
    this.dragScale = 1.08,
    this.dragBorderRadius,
    this.enabled = true,
    this.animationDuration = const Duration(milliseconds: 320),
    this.animationCurve = const Cubic(0.34, 1.3, 0.64, 1),
    this.pillShadows,
  });

  /// Convenient constructor that builds segments from a simple list of strings.
  factory BeautySegmentedBar.fromStrings({
    Key? key,
    required List<String> items,
    required int currentIndex,
    required ValueChanged<int> onChanged,
    double height = 46.0,
    double? width,
    double? maxWidth,
    AlignmentGeometry alignment = Alignment.center,
    Color? trackColor,
    Color? trackBorderColor,
    double trackBorderWidth = 1.0,
    Color? pillColor,
    Color? pillBorderColor,
    double pillBorderWidth = 1.0,
    Color? activeColor,
    Color? inactiveColor,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    double borderRadius = 100.0,
    EdgeInsetsGeometry pillPadding =
        const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
    EdgeInsetsGeometry segmentPadding =
        const EdgeInsets.symmetric(horizontal: 4),
    TextStyle? textStyle,
    TextStyle? activeTextStyle,
    double iconSize = 17.0,
    double iconSpacing = 6.0,
    bool enableHaptics = true,
    bool dragEnabled = true,
    double dragExpand = 4.0,
    double dragScale = 1.08,
    double? dragBorderRadius,
    bool enabled = true,
    Duration animationDuration = const Duration(milliseconds: 320),
    Curve animationCurve = const Cubic(0.34, 1.3, 0.64, 1),
    List<BoxShadow>? pillShadows,
  }) {
    return BeautySegmentedBar(
      key: key,
      items: items.map((e) => BeautySegmentedItem(label: e)).toList(),
      currentIndex: currentIndex,
      onChanged: onChanged,
      height: height,
      width: width,
      maxWidth: maxWidth,
      alignment: alignment,
      trackColor: trackColor,
      trackBorderColor: trackBorderColor,
      trackBorderWidth: trackBorderWidth,
      pillColor: pillColor,
      pillBorderColor: pillBorderColor,
      pillBorderWidth: pillBorderWidth,
      activeColor: activeColor,
      inactiveColor: inactiveColor,
      padding: padding,
      borderRadius: borderRadius,
      pillPadding: pillPadding,
      segmentPadding: segmentPadding,
      textStyle: textStyle,
      activeTextStyle: activeTextStyle,
      iconSize: iconSize,
      iconSpacing: iconSpacing,
      enableHaptics: enableHaptics,
      dragEnabled: dragEnabled,
      dragExpand: dragExpand,
      dragScale: dragScale,
      dragBorderRadius: dragBorderRadius,
      enabled: enabled,
      animationDuration: animationDuration,
      animationCurve: animationCurve,
      pillShadows: pillShadows,
    );
  }

  @override
  State<BeautySegmentedBar> createState() => _BeautySegmentedBarState();
}

class _BeautySegmentedBarState extends State<BeautySegmentedBar> {
  bool _dragging = false;
  double _dragX = 0;

  static const TextStyle _defaultTextStyle = TextStyle(
    fontSize: 13.5,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.2,
  );

  TextStyle _resolveTextStyle({
    required bool active,
    required Color color,
  }) {
    TextStyle resolved = _defaultTextStyle
        .merge(widget.textStyle)
        .copyWith(fontWeight: active ? FontWeight.w600 : FontWeight.w500);

    if (active) {
      resolved = resolved.merge(widget.activeTextStyle);
    }

    return resolved.copyWith(color: resolved.color ?? color);
  }

  void _handleTap(int index) {
    if (!widget.enabled) return;
    if (widget.enableHaptics) {
      HapticFeedback.lightImpact();
    }
    widget.onChanged(index);
  }

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

        final double pillHorizontalInset =
            widget.pillPadding.horizontal / 2;
        final double pillVerticalInset = widget.pillPadding.vertical / 2;

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
                        ? Border.all(
                            color: effectiveTrackBorder,
                            width: widget.trackBorderWidth,
                          )
                        : null,
                  ),
                ),
              ),

              // 2. Draggable Animated Active Pill
              AnimatedPositioned(
                duration:
                    _dragging ? Duration.zero : widget.animationDuration,
                curve: widget.animationCurve,
                left: isRtl
                    ? (totalWidth - (pillX + tabWidth - pillHorizontalInset))
                        .clamp(0.0, totalWidth)
                    : (pillX + pillHorizontalInset).clamp(0.0, totalWidth),
                top: _dragging ? -widget.dragExpand : pillVerticalInset,
                bottom: _dragging ? -widget.dragExpand : pillVerticalInset,
                width: (tabWidth - widget.pillPadding.horizontal)
                    .clamp(0.0, totalWidth),
                child: AnimatedScale(
                  scale: _dragging ? widget.dragScale : 1.0,
                  duration: widget.animationDuration,
                  curve: Curves.easeOutCubic,
                  child: Container(
                    decoration: BoxDecoration(
                      color: effectivePillColor,
                      borderRadius: BorderRadius.circular(
                        _dragging
                            ? (widget.dragBorderRadius ?? widget.borderRadius)
                            : widget.borderRadius,
                      ),
                      border: effectivePillBorder != null
                          ? Border.all(
                              color: effectivePillBorder,
                              width: widget.pillBorderWidth,
                            )
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
                  onHorizontalDragStart: !widget.enabled || !widget.dragEnabled
                      ? null
                      : (_) {
                          if (widget.enableHaptics) {
                            HapticFeedback.selectionClick();
                          }
                          setState(() {
                            _dragging = true;
                            _dragX = baseX;
                          });
                        },
                  onHorizontalDragUpdate:
                      !widget.enabled || !widget.dragEnabled
                          ? null
                          : (details) {
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
                  onHorizontalDragEnd: !widget.enabled || !widget.dragEnabled
                      ? null
                      : (details) {
                          final double rawVelocity =
                              details.velocity.pixelsPerSecond.dx;
                          final double velocity =
                              isRtl ? -rawVelocity : rawVelocity;
                          final double frac =
                              tabWidth > 0 ? (_dragX / tabWidth) : 0;

                          int index;
                          if (velocity > 500) {
                            index = frac.floor() + 1;
                          } else if (velocity < -500) {
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
                  onHorizontalDragCancel:
                      !widget.enabled || !widget.dragEnabled
                          ? null
                          : () {
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
                          onTap: widget.enabled ? () => _handleTap(i) : null,
                          child: SizedBox(
                            height: double.infinity,
                            child: Padding(
                              padding: widget.segmentPadding,
                              child: Center(
                                child: item.customWidget ??
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        if (item.icon != null) ...[
                                          Icon(
                                            item.icon,
                                            size: widget.iconSize,
                                            color: color,
                                          ),
                                          SizedBox(width: widget.iconSpacing),
                                        ],
                                        Flexible(
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              item.label,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: _resolveTextStyle(
                                                active: active,
                                                color: color,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
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
    } else if (widget.maxWidth != null) {
      segmentedBar = Align(
        alignment: widget.alignment,
        heightFactor: 1.0,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: widget.maxWidth!),
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
