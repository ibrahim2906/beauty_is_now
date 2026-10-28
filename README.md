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
- 🎚️ **Deep Customization**: Control every dimension (width, maxWidth, height, pill padding, segment padding, corner radius, border widths), typography (text styles, icon size and spacing), drag physics and animation timing.
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

*(This automatically adds `beauty_is_now: ^1.2.0` to your `pubspec.yaml`)*

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

## 📐 Sizing & Full Customization

### Width, max width, height & alignment

Both `BeautyNavBar` and `BeautySegmentedBar` expand to fill the available width by default.
Pass a `width` to lock them to an exact size, or `maxWidth` to keep a responsive bar from
growing too wide on tablets and desktop. A fixed bar is aligned horizontally according to
`alignment` (defaults to `Alignment.center`).

```dart
// Segmented bar locked to 340 x 52, centered.
BeautySegmentedBar.fromStrings(
  items: const ['Overview', 'Analytics', 'Settings'],
  width: 340,
  height: 52,
  currentIndex: _selectedIndex,
  onChanged: (index) => setState(() => _selectedIndex = index),
)

// Responsive, but never wider than 420px and left aligned.
BeautySegmentedBar.fromStrings(
  items: const ['Day', 'Week', 'Month'],
  maxWidth: 420,
  alignment: Alignment.centerLeft,
  currentIndex: _selectedIndex,
  onChanged: (index) => setState(() => _selectedIndex = index),
)

// Navigation bar constrained to 320px, centered.
BeautyNavBar(
  currentIndex: _currentNavIndex,
  onChanged: (index) => setState(() => _currentNavIndex = index),
  width: 320,
  // alignment: Alignment.centerLeft, // optional
  items: const [
    BeautyNavItem(label: 'Home', icon: Icons.home_rounded),
    BeautyNavItem(label: 'Search', icon: Icons.search_rounded),
    BeautyNavItem(label: 'Profile', icon: Icons.person_rounded),
  ],
)
```

Omit `width` and `maxWidth` (or pass `null`) to keep the responsive, full-width behavior.

---

### `BeautySegmentedBar` property reference

**Size & layout**

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| `width` | `double?` | `null` | Exact bar width. `null` = fill available width. |
| `maxWidth` | `double?` | `null` | Upper bound used when `width` is `null`. |
| `height` | `double` | `46.0` | Total bar height. |
| `alignment` | `AlignmentGeometry` | `Alignment.center` | Alignment when `width`/`maxWidth` is applied. |
| `padding` | `EdgeInsetsGeometry` | `EdgeInsets.zero` | Padding around the whole bar. |
| `borderRadius` | `double` | `100.0` | Corner radius of track and pill. |
| `pillPadding` | `EdgeInsetsGeometry` | `symmetric(horizontal: 3, vertical: 4)` | Inset of the sliding pill inside the track. |
| `segmentPadding` | `EdgeInsetsGeometry` | `symmetric(horizontal: 4)` | Padding inside each segment around its label/icon. |

**Typography**

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| `textStyle` | `TextStyle?` | `13.5px`, `w500`, `-0.2` spacing | Base label style. Its `color` wins over the active/inactive colors when set. |
| `activeTextStyle` | `TextStyle?` | `null` | Extra style merged over `textStyle` for the selected segment only. |
| `iconSize` | `double` | `17.0` | Leading icon size. |
| `iconSpacing` | `double` | `6.0` | Gap between icon and label. |

**Colors**

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| `trackColor` | `Color?` | theme adaptive | Background of the track. |
| `trackBorderColor` / `trackBorderWidth` | `Color?` / `double` | `null` / `1.0` | Optional track border. |
| `pillColor` | `Color?` | theme adaptive | Color of the active pill. |
| `pillBorderColor` / `pillBorderWidth` | `Color?` / `double` | `null` / `1.0` | Optional pill border. |
| `pillShadows` | `List<BoxShadow>?` | soft adaptive shadow | Custom elevation for the pill. |
| `activeColor` / `inactiveColor` | `Color?` | theme adaptive | Label/icon colors for each state. |

**Interaction & animation**

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| `enabled` | `bool` | `true` | When `false`, the bar is a static, non-interactive display. |
| `dragEnabled` | `bool` | `true` | Allow dragging the pill; taps still work when `false`. |
| `enableHaptics` | `bool` | `true` | Haptic feedback on taps and drag transitions. |
| `dragExpand` | `double` | `4.0` | How far the pill overflows the track while dragging (`0` keeps it inside). |
| `dragScale` | `double` | `1.08` | Pill scale while dragging. |
| `dragBorderRadius` | `double?` | `borderRadius` | Corner radius while dragging. |
| `animationDuration` | `Duration` | `320ms` | Snap animation duration. |
| `animationCurve` | `Curve` | spring `Cubic` | Snap animation curve. |
| `onChanged` | `ValueChanged<int>` | — | Fired on tap or drag drop. |

### Fully styled example

```dart
BeautySegmentedBar.fromStrings(
  items: const ['Overview', 'Analytics', 'Settings'],
  currentIndex: _selectedIndex,
  onChanged: (index) => setState(() => _selectedIndex = index),
  // Size
  width: 380,
  height: 56,
  borderRadius: 16,
  pillPadding: const EdgeInsets.all(6),
  segmentPadding: const EdgeInsets.symmetric(horizontal: 8),
  // Typography
  textStyle: const TextStyle(fontSize: 15, letterSpacing: 0),
  activeTextStyle: const TextStyle(fontWeight: FontWeight.w800),
  iconSize: 18,
  iconSpacing: 8,
  // Colors
  trackColor: const Color(0xFFF1F5F9),
  pillColor: const Color(0xFF0EA5E9),
  activeColor: Colors.white,
  inactiveColor: const Color(0xFF64748B),
  // Motion
  animationDuration: const Duration(milliseconds: 260),
  animationCurve: Curves.easeOutBack,
  dragExpand: 0,
  dragScale: 1.04,
)
```

### Static badge / read-only display

```dart
BeautySegmentedBar.fromStrings(
  items: const ['Draft', 'Review', 'Published'],
  currentIndex: 2,
  onChanged: (_) {},
  enabled: false,   // no taps, no drag
  dragEnabled: false,
  height: 36,
)
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
