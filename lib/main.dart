import 'package:flutter/material.dart';
import 'package:flutter_app_1/screens/breathing_screen.dart';
import 'package:flutter_app_1/screens/meditation_screen.dart';
import 'package:flutter_app_1/screens/affirmations_screen.dart';
import 'package:flutter_app_1/screens/mood_screen.dart';
import 'package:flutter_app_1/screens/sounds_screen.dart';
import 'package:flutter_app_1/utils/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mindful Moments',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const BreathingScreen(),
    const MeditationScreen(),
    const AffirmationsScreen(),
    const MoodScreen(),
    const SoundsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _screens[_selectedIndex],
        transitionBuilder: (child, animation) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.air),
                label: 'Breathing',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.self_improvement),
                label: 'Meditation',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Affirmations',
              ),
              BottomNavigationBarItem(icon: Icon(Icons.mood), label: 'Mood'),
              BottomNavigationBarItem(
                icon: Icon(Icons.music_note),
                label: 'Sounds',
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            selectedItemColor: AppTheme.primaryBlue,
            unselectedItemColor: AppTheme.textLight,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
          ),
        ),
      ),
    );
  }
}
