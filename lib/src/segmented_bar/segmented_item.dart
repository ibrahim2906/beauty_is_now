import 'package:flutter/widgets.dart';

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
