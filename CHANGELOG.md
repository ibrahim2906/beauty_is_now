# Changelog

All notable changes to this project will be documented in this file.

## 1.2.0

* **BeautySegmentedBar is now fully customizable.** New properties:
  * Sizing: `maxWidth` (responsive upper bound next to `width`), fully configurable `pillPadding` and `segmentPadding`, plus `trackBorderWidth` / `pillBorderWidth`.
  * Typography: `textStyle` (base label style, color respected), `activeTextStyle` (selected label emphasis), `iconSize` and `iconSpacing`.
* Interaction: `enabled` (static/read-only bar), `dragEnabled` (tap-only mode), `dragExpand`, `dragScale` and `dragBorderRadius`.
* Motion: `animationDuration` and `animationCurve` for the pill snap animation.
* The dragged pill now keeps the resting corner radius by default instead of snapping to a hard-coded `30`; use `dragBorderRadius` to restore a custom drag shape.
* `BeautySegmentedBar.fromStrings` accepts every new property.
* README: new property reference tables and fully styled / read-only examples.

## 1.1.2

* Republish release with the configurable `width` and `alignment` support.

## 1.1.0

* Added a configurable `width` (and `alignment`) to `BeautyNavBar` and `BeautySegmentedBar`. When omitted, both widgets keep the previous behavior and expand to fill the available width.

## 1.0.2

* Cleaned up README documentation and user guides.

## 1.0.1

* Added interactive demo GIFs to README and documentation.
* Refined branding and component descriptions.

## 1.0.0

* Initial release of `beauty_is_now`.
* Added `BeautySegmentedBar`: Interactive fluid segmented bar with spring drag physics, dynamic scale expansion, adaptive light/dark mode, and RTL support.
* Added `BeautyWindow` and `showBeautyWindow`: Frosted glass modal window with swipe-to-dismiss handle, circular close 'X' button, vibrant blue checkmark button, and custom entry transitions.
* Added `BeautyNavBar`: Draggable floating pill navigation bar with spring physics, scale-up drag effect, active/inactive theme styling, and haptic feedback.
* Added `BeautyGlassPanel`, `BeautyCloseButton`, and `BeautyConfirmButton` utility components.
* Support for all platforms: Android, iOS, Web, macOS, Windows, Linux.
