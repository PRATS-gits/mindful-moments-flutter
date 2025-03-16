import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app_1/utils/app_theme.dart';

class MoodScreen extends StatefulWidget {
  const MoodScreen({super.key});

  @override
  State<MoodScreen> createState() => _MoodScreenState();
}

class _MoodScreenState extends State<MoodScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _selectedMoodIndex = -1;
  final TextEditingController _noteController = TextEditingController();

  final List<Map<String, dynamic>> _moods = [
    {'emoji': '😊', 'label': 'Happy', 'color': AppTheme.mintGreen, 'value': 4},
    {'emoji': '😌', 'label': 'Calm', 'color': AppTheme.lightBlue, 'value': 3},
    {
      'emoji': '😐',
      'label': 'Neutral',
      'color': AppTheme.paleLavender,
      'value': 2,
    },
    {
      'emoji': '😓',
      'label': 'Stressed',
      'color': AppTheme.blushPink,
      'value': 1,
    },
    {'emoji': '😔', 'label': 'Sad', 'color': AppTheme.lavender, 'value': 0},
  ];

  final Map<String, int> _moodHistory = {};
  final String _todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _loadMoodHistory();
    _loadTodayMood();
  }

  @override
  void dispose() {
    _controller.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _loadMoodHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final moodHistoryKeys =
        prefs.getKeys().where((key) => key.startsWith('mood_')).toList();

    setState(() {
      for (var key in moodHistoryKeys) {
        final date = key.substring(5);
        _moodHistory[date] = prefs.getInt(key) ?? -1;
      }
    });
  }

  Future<void> _loadTodayMood() async {
    final prefs = await SharedPreferences.getInstance();
    final moodValue = prefs.getInt('mood_$_todayDate');
    final moodNote = prefs.getString('mood_note_$_todayDate');

    if (moodValue != null) {
      setState(() {
        for (int i = 0; i < _moods.length; i++) {
          if (_moods[i]['value'] == moodValue) {
            _selectedMoodIndex = i;
            break;
          }
        }
        if (moodNote != null) {
          _noteController.text = moodNote;
        }
      });
    }
  }

  Future<void> _saveMood(int mood, String note) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('mood_$_todayDate', mood);
    await prefs.setString('mood_note_$_todayDate', note);

    setState(() {
      _moodHistory[_todayDate] = mood;
    });
  }

  void _selectMood(int index) {
    setState(() {
      _selectedMoodIndex = index;
    });

    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood Tracker'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How are you feeling today?',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              DateFormat('EEEE, MMMM d').format(DateTime.now()),
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: AppTheme.textLight),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(_moods.length, (index) {
                final mood = _moods[index];
                return GestureDetector(
                  onTap: () => _selectMood(index),
                  child: Column(
                    children: [
                      AnimatedScale(
                        scale: _selectedMoodIndex == index ? 1.2 : 1.0,
                        duration: const Duration(milliseconds: 200),
                        child: Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color:
                                _selectedMoodIndex == index
                                    ? mood['color']
                                    : AppTheme.background,
                            shape: BoxShape.circle,
                            border: Border.all(color: mood['color'], width: 2),
                            boxShadow:
                                _selectedMoodIndex == index
                                    ? [
                                      BoxShadow(
                                        color: mood['color'].withOpacity(0.3),
                                        blurRadius: 12,
                                        spreadRadius: 2,
                                      ),
                                    ]
                                    : null,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            mood['emoji'],
                            style: const TextStyle(fontSize: 28),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        mood['label'],
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight:
                              _selectedMoodIndex == index
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                          color:
                              _selectedMoodIndex == index
                                  ? mood['color']
                                  : AppTheme.textLight,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
            const SizedBox(height: 40),
            Text(
              'Add a note (optional)',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _noteController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'What\'s making you feel this way?',
                hintStyle: TextStyle(color: AppTheme.textLight),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.grey.shade100),
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed:
                    _selectedMoodIndex >= 0
                        ? () {
                          final mood = _moods[_selectedMoodIndex]['value'];
                          final note = _noteController.text;
                          _saveMood(mood, note);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Your mood has been recorded'),
                              backgroundColor:
                                  _moods[_selectedMoodIndex]['color'],
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          );
                        }
                        : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Save Mood'),
              ),
            ),
            const SizedBox(height: 40),
            Text('Your Week', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 24),
            _buildMoodChart(),
          ],
        ),
      ),
    );
  }

  Widget _buildMoodChart() {
    final now = DateTime.now();
    final dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final days = List.generate(7, (index) {
      final date = now.subtract(Duration(days: 6 - index));
      final dateStr = DateFormat('yyyy-MM-dd').format(date);
      final dayName = dayNames[date.weekday - 1];
      final isToday = dateStr == _todayDate;
      final moodValue = _moodHistory[dateStr];

      Color? moodColor;
      if (moodValue != null && moodValue >= 0 && moodValue < _moods.length) {
        for (var mood in _moods) {
          if (mood['value'] == moodValue) {
            moodColor = mood['color'];
            break;
          }
        }
      }

      return Column(
        children: [
          Text(
            dayName,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color:
                  moodColor?.withOpacity(0.2) ?? Colors.grey.withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(
                color: moodColor ?? Colors.grey.shade300,
                width: 2,
              ),
            ),
            child:
                moodValue != null
                    ? Center(
                      child: Text(
                        _moods.firstWhere(
                          (m) => m['value'] == moodValue,
                          orElse: () => {'emoji': '?'},
                        )['emoji'],
                        style: const TextStyle(fontSize: 16),
                      ),
                    )
                    : null,
          ),
        ],
      );
    });

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: days,
    );
  }
}
