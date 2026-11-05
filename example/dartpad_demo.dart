// beauty_is_now 1.3.0 - standalone DartPad demo
//
// DartPad only supports a small, pre-approved set of pub.dev packages, so it
// cannot import beauty_is_now directly. This file inlines the package sources
// and is ready to run on https://dartpad.dev:
//
//   1. Open https://dartpad.dev and choose "Flutter".
//   2. Select all of the default code and replace it with this file.
//   3. Press Run.
//
// Optional: save this file as main.dart in a public GitHub gist and open
// https://dartpad.dev/?id=<gist-id> to share a runnable link.
// ---------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// An individual item/tab within [BeautySegmentedBar].
class BeautySegmentedItem {
  /// The text label displayed on the tab.
  final String label;

  /// Optional leading icon displayed before the label.
  final IconData? icon;

  /// Optional custom widget to completely override the default label & icon layout.
  final Widget? customWidget;

  /// Creates a segmented item.
  const BeautySegmentedItem({
    required this.label,
    this.icon,
    this.customWidget,
  });
}

/// An interactive, fluid segmented bar featuring smooth spring drag physics,
/// dynamic pill and whole-bar scale expansion, adaptive light/dark theming, and
/// full RTL support.
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

  /// Scale applied to the whole segmented bar while the pill is being dragged.
  /// Defaults to `1.03`.
  ///
  /// The bar smoothly grows to this scale when a drag starts and eases back to
  /// `1.0` when the pill is released. Set to `1.0` to disable the effect.
  final double dragBarScale;

  /// Duration of the smooth grow/shrink animation of the bar while dragging.
  /// Defaults to `240ms`.
  final Duration dragBarScaleDuration;

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
    this.dragBarScale = 1.03,
    this.dragBarScaleDuration = const Duration(milliseconds: 240),
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
    double dragBarScale = 1.03,
    Duration dragBarScaleDuration = const Duration(milliseconds: 240),
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
      dragBarScale: dragBarScale,
      dragBarScaleDuration: dragBarScaleDuration,
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

        final double pillHorizontalInset = widget.pillPadding.horizontal / 2;
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
                duration: _dragging ? Duration.zero : widget.animationDuration,
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
                  onHorizontalDragUpdate: !widget.enabled || !widget.dragEnabled
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
                  onHorizontalDragCancel: !widget.enabled || !widget.dragEnabled
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

    // Smoothly grow the whole bar while the pill is being pulled, then ease
    // back to its resting size once it is released.
    segmentedBar = AnimatedScale(
      scale: _dragging ? widget.dragBarScale : 1.0,
      duration: widget.dragBarScaleDuration,
      curve: Curves.easeOutCubic,
      child: segmentedBar,
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

/// Representation of an individual destination item in [BeautyNavBar].
class BeautyNavItem {
  /// The title / accessibility label for the navigation item.
  final String label;

  /// The icon displayed when the item is inactive or unselected.
  final IconData icon;

  /// Optional different icon to display when this item is selected.
  final IconData? activeIcon;

  /// Optional route or identifier string.
  final String? route;

  /// Optional badge count or text (e.g. '3' or 'NEW').
  final String? badge;

  /// Creates a [BeautyNavItem].
  const BeautyNavItem({
    required this.label,
    required this.icon,
    this.activeIcon,
    this.route,
    this.badge,
  });
}

/// A sleek draggable floating pill navigation bar featuring spring physics,
/// touch drag-tracking with dynamic pill and whole-bar scale expansion,
/// adaptive light/dark theming, and haptic feedback.
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

  /// Scale applied to the whole navigation bar while its pill is being
  /// dragged. Defaults to `1.03`.
  ///
  /// The bar smoothly grows to this scale when a drag starts and eases back to
  /// `1.0` when the pill is released. Set to `1.0` to disable the effect.
  final double dragBarScale;

  /// Duration of the smooth grow/shrink animation of the bar while dragging.
  /// Defaults to `240ms`.
  final Duration dragBarScaleDuration;

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
    this.dragBarScale = 1.03,
    this.dragBarScaleDuration = const Duration(milliseconds: 240),
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

    // Smoothly grow the whole bar while the pill is being pulled, then ease
    // back to its resting size once it is released.
    navBarWidget = AnimatedScale(
      scale: _dragging ? widget.dragBarScale : 1.0,
      duration: widget.dragBarScaleDuration,
      curve: Curves.easeOutCubic,
      child: navBarWidget,
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

// ---------------------------------------------------------------------------
// Demo app
// ---------------------------------------------------------------------------

void main() {
  runApp(const BeautyDartPadApp());
}

class BeautyDartPadApp extends StatefulWidget {
  const BeautyDartPadApp({super.key});

  @override
  State<BeautyDartPadApp> createState() => _BeautyDartPadAppState();
}

class _BeautyDartPadAppState extends State<BeautyDartPadApp> {
  ThemeMode _themeMode = ThemeMode.dark;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'beauty_is_now — DartPad demo',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3B82F6),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F1117),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF38BDF8),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: _DartPadDemoScreen(
        isDark: _themeMode == ThemeMode.dark,
        onToggleTheme: _toggleTheme,
      ),
    );
  }
}

class _DartPadDemoScreen extends StatefulWidget {
  const _DartPadDemoScreen({
    required this.isDark,
    required this.onToggleTheme,
  });

  final bool isDark;
  final VoidCallback onToggleTheme;

  @override
  State<_DartPadDemoScreen> createState() => _DartPadDemoScreenState();
}

class _DartPadDemoScreenState extends State<_DartPadDemoScreen> {
  int _segmentIndex = 1;
  int _navIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'beauty_is_now',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: -0.5),
        ),
        actions: [
          IconButton(
            tooltip: 'Toggle theme',
            onPressed: widget.onToggleTheme,
            icon: Icon(
              widget.isDark
                  ? Icons.light_mode_rounded
                  : Icons.dark_mode_rounded,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Whole-bar scale during drag',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Pull the pill horizontally. The whole bar grows smoothly '
                    'by 3% while dragging and eases back to its resting size '
                    'when you release it.',
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.4,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 28),
                  _SectionLabel('BeautySegmentedBar'),
                  const SizedBox(height: 12),
                  Center(
                    child: BeautySegmentedBar.fromStrings(
                      items: const ['Overview', 'Analytics', 'Settings'],
                      width: 340,
                      currentIndex: _segmentIndex,
                      onChanged: (index) {
                        setState(() => _segmentIndex = index);
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: BeautySegmentedBar(
                      width: 340,
                      currentIndex: _segmentIndex,
                      onChanged: (index) {
                        setState(() => _segmentIndex = index);
                      },
                      items: const [
                        BeautySegmentedItem(
                          label: 'Day',
                          icon: Icons.wb_sunny_outlined,
                        ),
                        BeautySegmentedItem(
                          label: 'Week',
                          icon: Icons.calendar_view_week_rounded,
                        ),
                        BeautySegmentedItem(
                          label: 'Month',
                          icon: Icons.calendar_month_rounded,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  _SectionLabel('BeautyNavBar'),
                  const SizedBox(height: 12),
                  Center(
                    child: BeautyNavBar(
                      width: 340,
                      currentIndex: _navIndex,
                      onChanged: (index) {
                        setState(() => _navIndex = index);
                      },
                      items: const [
                        BeautyNavItem(
                          label: 'Home',
                          icon: Icons.home_outlined,
                          activeIcon: Icons.home_rounded,
                        ),
                        BeautyNavItem(
                          label: 'Search',
                          icon: Icons.search_rounded,
                        ),
                        BeautyNavItem(
                          label: 'Tasks',
                          icon: Icons.check_circle_outline_rounded,
                          activeIcon: Icons.check_circle_rounded,
                          badge: '2',
                        ),
                        BeautyNavItem(
                          label: 'Profile',
                          icon: Icons.person_outline_rounded,
                          activeIcon: Icons.person_rounded,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                  Text(
                    'Selected segment: $_segmentIndex  •  '
                    'Selected nav item: $_navIndex',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
    );
  }
}
