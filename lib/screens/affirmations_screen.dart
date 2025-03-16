import 'package:flutter/material.dart';
import 'package:flutter_app_1/utils/app_theme.dart';

class AffirmationsScreen extends StatefulWidget {
  const AffirmationsScreen({super.key});

  @override
  State<AffirmationsScreen> createState() => _AffirmationsScreenState();
}

class _AffirmationsScreenState extends State<AffirmationsScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _affirmations = [
    {
      'text': 'I am worthy of all the good things that happen in my life.',
      'color': AppTheme.lightBlue,
      'icon': Icons.favorite,
    },
    {
      'text': 'I am in charge of how I feel today, and I choose happiness.',
      'color': AppTheme.mintGreen,
      'icon': Icons.sentiment_very_satisfied,
    },
    {
      'text': 'I am allowed to take up space and ask for what I need.',
      'color': AppTheme.paleGreen,
      'icon': Icons.spa,
    },
    {
      'text': 'I have the power to create positive change in my life.',
      'color': AppTheme.lavender,
      'icon': Icons.bolt,
    },
    {
      'text':
          'I trust myself to make decisions that align with my highest good.',
      'color': AppTheme.blushPink,
      'icon': Icons.lightbulb,
    },
    {
      'text': 'I embrace challenges as opportunities for growth.',
      'color': AppTheme.secondaryBlue,
      'icon': Icons.trending_up,
    },
    {
      'text': 'I am resilient and can overcome any obstacle.',
      'color': AppTheme.paleLavender,
      'icon': Icons.fitness_center,
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Affirmations'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              'Swipe to discover affirmations that resonate with you today',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: AppTheme.textLight),
            ),
          ),
          const SizedBox(height: 40),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: _affirmations.length,
              itemBuilder: (context, index) {
                return AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: _currentPage == index ? 1.0 : 0.8,
                  child: _AffirmationCard(
                    text: _affirmations[index]['text'],
                    color: _affirmations[index]['color'],
                    icon: _affirmations[index]['icon'],
                    isActive: _currentPage == index,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _affirmations.length,
              (index) => _buildPageIndicator(index == _currentPage),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildPageIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      height: 8.0,
      width: isActive ? 24.0 : 8.0,
      decoration: BoxDecoration(
        color:
            isActive
                ? AppTheme.primaryBlue
                : AppTheme.lightBlue.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}

class _AffirmationCard extends StatelessWidget {
  final String text;
  final Color color;
  final IconData icon;
  final bool isActive;

  const _AffirmationCard({
    required this.text,
    required this.color,
    required this.icon,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: isActive ? 16.0 : 32.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 40, color: color),
            ),
            const SizedBox(height: 40),
            Text(
              text,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(height: 1.5),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () {
                // Save or mark as favorite functionality could be added here
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Added to favorites'),
                    backgroundColor: color,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.bookmark_outline),
              label: const Text('Save'),
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
