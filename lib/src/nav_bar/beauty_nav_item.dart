import 'package:flutter/widgets.dart';

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
