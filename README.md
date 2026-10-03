# 🌟 beauty_is_now

[![pub package](https://img.shields.io/pub/v/beauty_is_now.svg?color=blue)](https://pub.dev/packages/beauty_is_now)
[![likes](https://img.shields.io/pub/likes/beauty_is_now)](https://pub.dev/packages/beauty_is_now/score)
[![popularity](https://img.shields.io/pub/popularity/beauty_is_now)](https://pub.dev/packages/beauty_is_now/score)
[![license](https://img.shields.io/badge/license-MIT-purple.svg)](LICENSE)
[![Platforms](https://img.shields.io/badge/platforms-Android%20%7C%20iOS%20%7C%20Web%20%7C%20macOS%20%7C%20Windows%20%7C%20Linux-teal.svg)](https://flutter.dev)

A modern, high-polish Flutter UI package featuring fluid segmented bars, frosted glass modal windows with drag-to-dismiss gestures, and spring-physics draggable navigation bars.

Engineered with zero third-party dependencies, 100% pure Flutter, full Light & Dark mode adaptation, and cross-platform compatibility out-of-the-box.

---

## ✨ Features

- 🎛️ **BeautySegmentedBar**: Interactive fluid segmented bar with spring drag physics, touch scale expansion, adaptive light/dark theming, and full RTL (Right-to-Left) support.
- 🪟 **BeautyWindow & showBeautyWindow**: Glassmorphic modal window with a swipe-down-to-dismiss handle, circular close 'X' button, vibrant blue checkmark button, and smooth entrance transitions.
- 🧭 **BeautyNavBar**: Sleek draggable floating navigation bar with spring physics, active pill expansion during gestures, and haptic feedback.
- 🌓 **Adaptive Theming**: Automatically adapts to Light and Dark modes without any extra configuration.
- ⚡ **Zero External Dependencies**: Pure Flutter framework widgets with Cupertino icons and Material Design.
- 📱 **All Platforms Supported**: Android, iOS, Web, Windows, macOS, Linux.

---

## 📸 Preview

<p align="center">
  <img src="https://raw.githubusercontent.com/ibrahim2906/beauty_is_now/main/assets/segmented_bar.gif" alt="BeautySegmentedBar Preview" width="48%" style="border-radius: 12px; margin: 4px;" />
  <img src="https://raw.githubusercontent.com/ibrahim2906/beauty_is_now/main/assets/navBar.gif" alt="BeautyNavBar Preview" width="48%" style="border-radius: 12px; margin: 4px;" />
</p>

---

## 🚀 Getting Started

Add `beauty_is_now` to your `pubspec.yaml`:

```yaml
dependencies:
  beauty_is_now: ^1.0.0
```

Or run:

```bash
flutter pub add beauty_is_now
```

Then import the package in your Dart code:

```dart
import 'package:beauty_is_now/beauty_is_now.dart';
```

---

## 📖 Usage Examples

### 1. Fluid Segmented Bar (`BeautySegmentedBar`)

<p align="center">
  <img src="https://raw.githubusercontent.com/ibrahim2906/beauty_is_now/main/assets/segmented_bar.gif" alt="BeautySegmentedBar GIF" width="480" style="border-radius: 14px;" />
</p>

```dart
int _selectedSegment = 0;

BeautySegmentedBar.fromStrings(
  items: const ['Overview', 'Analytics', 'Settings'],
  currentIndex: _selectedSegment,
  onChanged: (index) {
    setState(() => _selectedSegment = index);
  },
)
```

With icons and custom items:

```dart
BeautySegmentedBar(
  currentIndex: _selectedSegment,
  onChanged: (index) => setState(() => _selectedSegment = index),
  items: const [
    BeautySegmentedItem(label: 'Day', icon: Icons.wb_sunny_rounded),
    BeautySegmentedItem(label: 'Week', icon: Icons.calendar_view_week_rounded),
    BeautySegmentedItem(label: 'Month', icon: Icons.calendar_month_rounded),
  ],
)
```

---

### 2. Glassmorphic Modal Window (`BeautyWindow` & `showBeautyWindow`)

Present a modern dialog with top drag handle, 'X' close button, and circular blue checkmark button:

```dart
showBeautyWindow(
  context,
  title: 'Edit Workspace',
  onConfirm: () {
    // Perform save action
    Navigator.of(context).pop();
  },
  child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      TextField(
        decoration: InputDecoration(
          labelText: 'Workspace Name',
          hintText: 'e.g. Mobile App Redesign',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      const SizedBox(height: 16),
      const Text('Swipe down or tap outside to dismiss.'),
    ],
  ),
);
```

You can also use `BeautyWindow` directly inside any custom route or bottom sheet.

---

### 3. Draggable Floating Navigation Bar (`BeautyNavBar`)

<p align="center">
  <img src="https://raw.githubusercontent.com/ibrahim2906/beauty_is_now/main/assets/navBar.gif" alt="BeautyNavBar GIF" width="480" style="border-radius: 14px;" />
</p>

```dart
int _currentNavIndex = 0;

BeautyNavBar(
  currentIndex: _currentNavIndex,
  onChanged: (index) => setState(() => _currentNavIndex = index),
  items: const [
    BeautyNavItem(label: 'Home', icon: Icons.home_rounded),
    BeautyNavItem(label: 'Search', icon: Icons.search_rounded),
    BeautyNavItem(label: 'Tasks', icon: Icons.check_circle_outline_rounded, badge: '3'),
    BeautyNavItem(label: 'Profile', icon: Icons.person_rounded),
  ],
)
```

---

## 🎨 Dark & Light Mode Customization

Every widget in `beauty_is_now` automatically respects your app's `Theme.of(context).brightness`.

You can also explicitly customize the colors:

```dart
BeautySegmentedBar(
  trackColor: isDark ? const Color(0xFF1E222D) : const Color(0xFFE2E8F0),
  pillColor: Colors.blueAccent,
  activeColor: Colors.white,
  inactiveColor: Colors.grey,
  items: ...,
  currentIndex: ...,
  onChanged: ...,
)
```

---

## 🎬 How to Add Images & Videos to pub.dev

pub.dev does **not** store media files directly inside the package bundle. To showcase images, GIFs, and videos:

1. **Host images/GIFs on GitHub**:
   - Push your screenshots or recorded GIF to your GitHub repository (e.g. in the `assets/` directory).
   - Use the **raw GitHub URL** in your `README.md`:
     ```markdown
     ![Demo Preview](https://raw.githubusercontent.com/<YOUR_USERNAME>/beauty_is_now/main/assets/demo.gif)
     ```
2. **Embed Videos (YouTube / Loom / MP4)**:
   - For YouTube or Loom videos, add a clickable thumbnail in `README.md`:
     ```markdown
     [![Watch the video](https://img.youtube.com/vi/YOUR_VIDEO_ID/0.jpg)](https://www.youtube.com/watch?v=YOUR_VIDEO_ID)
     ```
   - For direct MP4 or WebM video links:
     ```markdown
     [▶️ Watch Demo Video](https://your-domain.com/demo.mp4)
     ```

---

## 🚀 Publishing to pub.dev Guide

1. **Verify your package**:
   ```bash
   dart pub publish --dry-run
   ```
2. **Publish**:
   ```bash
   dart pub publish
   ```
3. Follow the Google authentication link printed in the terminal.

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
