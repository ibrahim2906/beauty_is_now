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
  <img src="https://raw.githubusercontent.com/ibrahim2906/beauty_is_now/main/assets/segmented_bar.gif" alt="BeautySegmentedBar Preview" width="31%" style="border-radius: 12px; margin: 3px;" />
  <img src="https://raw.githubusercontent.com/ibrahim2906/beauty_is_now/main/assets/window.png" alt="BeautyWindow Preview" width="31%" style="border-radius: 12px; margin: 3px;" />
  <img src="https://raw.githubusercontent.com/ibrahim2906/beauty_is_now/main/assets/navBar.gif" alt="BeautyNavBar Preview" width="31%" style="border-radius: 12px; margin: 3px;" />
</p>

---

## 🚀 How to Install & Use (Step-by-Step)

### Step 1: Add to your Flutter project

Open your project's terminal and run:

```bash
flutter pub add beauty_is_now
```

*(This automatically adds `beauty_is_now: ^1.0.2` to your `pubspec.yaml`)*

---

### Step 2: Import the package

In any Dart file where you want to use the widgets (e.g. `main.dart` or your screen file):

```dart
import 'package:beauty_is_now/beauty_is_now.dart';
```

---

## 📖 Complete Copy-Paste Examples

### 1. Fluid Segmented Bar (`BeautySegmentedBar`)

<p align="center">
  <img src="https://raw.githubusercontent.com/ibrahim2906/beauty_is_now/main/assets/segmented_bar.gif" alt="BeautySegmentedBar GIF" width="460" style="border-radius: 14px;" />
</p>

Use this inside any `StatefulWidget`:

```dart
class SegmentedDemo extends StatefulWidget {
  const SegmentedDemo({super.key});

  @override
  State<SegmentedDemo> createState() => _SegmentedDemoState();
}

class _SegmentedDemoState extends State<SegmentedDemo> {
  // Store the active index
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BeautySegmentedBar.fromStrings(
            items: const ['Overview', 'Analytics', 'Settings'],
            currentIndex: _selectedIndex,
            onChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
```

#### With Custom Icons:
```dart
BeautySegmentedBar(
  currentIndex: _selectedIndex,
  onChanged: (index) => setState(() => _selectedIndex = index),
  items: const [
    BeautySegmentedItem(label: 'Day', icon: Icons.wb_sunny_rounded),
    BeautySegmentedItem(label: 'Week', icon: Icons.calendar_view_week_rounded),
    BeautySegmentedItem(label: 'Month', icon: Icons.calendar_month_rounded),
  ],
)
```

---

### 2. Glassmorphic Modal Window (`BeautyWindow` & `showBeautyWindow`)

<p align="center">
  <img src="https://raw.githubusercontent.com/ibrahim2906/beauty_is_now/main/assets/window.png" alt="BeautyWindow Preview" width="380" style="border-radius: 14px;" />
</p>

To show the modal window from any button click:

```dart
ElevatedButton(
  onPressed: () {
    showBeautyWindow(
      context,
      title: 'New Task',
      onConfirm: () {
        // Triggered when the blue checkmark button is tapped
        print('Confirmed!');
        Navigator.of(context).pop();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Task Title',
              hintText: 'e.g. Design Landing Page',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Swipe down or tap outside to close.'),
        ],
      ),
    );
  },
  child: const Text('Open Modal Window'),
)
```

---

### 3. Draggable Floating Navigation Bar (`BeautyNavBar`)

<p align="center">
  <img src="https://raw.githubusercontent.com/ibrahim2906/beauty_is_now/main/assets/navBar.gif" alt="BeautyNavBar GIF" width="460" style="border-radius: 14px;" />
</p>

Place `BeautyNavBar` directly in your `Scaffold.bottomNavigationBar`:

```dart
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Selected Tab: $_currentNavIndex'),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BeautyNavBar(
          currentIndex: _currentNavIndex,
          onChanged: (index) {
            setState(() {
              _currentNavIndex = index;
            });
          },
          items: const [
            BeautyNavItem(label: 'Home', icon: Icons.home_rounded),
            BeautyNavItem(label: 'Search', icon: Icons.search_rounded),
            BeautyNavItem(label: 'Tasks', icon: Icons.check_circle_outline_rounded, badge: '3'),
            BeautyNavItem(label: 'Profile', icon: Icons.person_rounded),
          ],
        ),
      ),
    );
  }
}
```

---

## 🎨 Dark & Light Mode Customization

Every widget in `beauty_is_now` automatically detects whether your app is currently in Light Mode or Dark Mode (`Theme.of(context).brightness`).

You can also pass custom colors directly:

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

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
