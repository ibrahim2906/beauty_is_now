import 'package:flutter/material.dart';
import 'package:beauty_is_now/beauty_is_now.dart';

void main() {
  runApp(const BeautyDemoApp());
}

class BeautyDemoApp extends StatefulWidget {
  const BeautyDemoApp({super.key});

  @override
  State<BeautyDemoApp> createState() => _BeautyDemoAppState();
}

class _BeautyDemoAppState extends State<BeautyDemoApp> {
  ThemeMode _themeMode = ThemeMode.dark;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'beauty_is_now Showcase',
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
      home: ShowcaseScreen(
        isDark: _themeMode == ThemeMode.dark,
        onToggleTheme: _toggleTheme,
      ),
    );
  }
}

class ShowcaseScreen extends StatefulWidget {
  final bool isDark;
  final VoidCallback onToggleTheme;

  const ShowcaseScreen({
    super.key,
    required this.isDark,
    required this.onToggleTheme,
  });

  @override
  State<ShowcaseScreen> createState() => _ShowcaseScreenState();
}

class _ShowcaseScreenState extends State<ShowcaseScreen> {
  int _selectedSegment = 0;
  int _selectedFilter = 0;
  int _currentNavIndex = 0;

  final List<String> _segmentItems = ['Dashboard', 'Activity', 'Settings'];

  void _openDemoWindow() {
    showBeautyWindow(
      context,
      title: 'Task Details',
      onConfirm: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Changes confirmed!'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        Navigator.of(context).pop();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Interactive Glassmorphic Modal',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: widget.isDark ? Colors.white70 : const Color(0xFF475569),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            autofocus: false,
            decoration: InputDecoration(
              labelText: 'Project Name',
              hintText: 'e.g. Next-Gen App UI',
              filled: true,
              fillColor: widget.isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : Colors.black.withValues(alpha: 0.04),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: widget.isDark
                  ? Colors.blueAccent.withValues(alpha: 0.12)
                  : Colors.blue.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              children: [
                Icon(Icons.info_outline_rounded, color: Colors.blueAccent, size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'You can swipe down on the drag handle or click outside to dismiss this window.',
                    style: TextStyle(fontSize: 12.5),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'beauty_is_now',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: -0.5),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
              color: isDark ? Colors.amberAccent : Colors.indigo,
            ),
            tooltip: 'Toggle Theme',
            onPressed: widget.onToggleTheme,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // SECTION 1: Segmented Control
                  _buildSectionHeader(
                    title: '1. Apple Segmented Bar',
                    subtitle: 'Drag or tap with spring physics and scale expansion.',
                  ),
                  const SizedBox(height: 12),
                  BeautySegmentedBar.fromStrings(
                    items: _segmentItems,
                    currentIndex: _selectedSegment,
                    onChanged: (index) {
                      setState(() => _selectedSegment = index);
                    },
                  ),
                  const SizedBox(height: 14),
                  BeautySegmentedBar(
                    currentIndex: _selectedFilter,
                    onChanged: (index) {
                      setState(() => _selectedFilter = index);
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

                  const SizedBox(height: 36),

                  // SECTION 2: Glass Window / Dialog Modal
                  _buildSectionHeader(
                    title: '2. Glassmorphic Modal Window',
                    subtitle:
                        'Features top drag handle, "X" close button, and blue checkmark confirm button.',
                  ),
                  const SizedBox(height: 12),
                  BeautyGlassPanel(
                    borderRadius: 20,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const Text(
                          'Test the frosted window modal complete with silky entrance animations and responsive gestures.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 16),
                        FilledButton.icon(
                          onPressed: _openDemoWindow,
                          icon: const Icon(Icons.open_in_new_rounded, size: 18),
                          label: const Text('Open BeautyWindow Modal'),
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 36),

                  // SECTION 3: Draggable Navigation Bar
                  _buildSectionHeader(
                    title: '3. Draggable Navigation Bar',
                    subtitle:
                        'Active floating pill expands during drag with spring snap physics.',
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.03)
                          : Colors.black.withValues(alpha: 0.02),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: isDark ? Colors.white10 : Colors.black12,
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Active Tab: ${_getNavLabel(_currentNavIndex)}',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 20),
                        BeautyNavBar(
                          currentIndex: _currentNavIndex,
                          onChanged: (index) {
                            setState(() => _currentNavIndex = index);
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: BeautyNavBar(
          currentIndex: _currentNavIndex,
          onChanged: (index) {
            setState(() => _currentNavIndex = index);
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
    );
  }

  String _getNavLabel(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'Search';
      case 2:
        return 'Tasks';
      case 3:
        return 'Profile';
      default:
        return 'Unknown';
    }
  }

  Widget _buildSectionHeader({required String title, required String subtitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(fontSize: 13, color: Colors.grey),
        ),
      ],
    );
  }
}
