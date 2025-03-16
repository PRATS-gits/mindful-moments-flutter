import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_app_1/utils/app_theme.dart';

class SoundsScreen extends StatefulWidget {
  const SoundsScreen({super.key});

  @override
  State<SoundsScreen> createState() => _SoundsScreenState();
}

class _SoundsScreenState extends State<SoundsScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  int _selectedSoundIndex = -1;
  double _volume = 0.5;

  final List<Map<String, dynamic>> _sounds = [
    {
      'title': 'Rain',
      'description': 'Gentle rainfall on a roof',
      'icon': Icons.water_drop_outlined,
      'color': AppTheme.lightBlue,
      'assetPath': 'assets/sounds/rain.mp3',
    },
    {
      'title': 'Forest',
      'description': 'Peaceful woodland ambiance',
      'icon': Icons.forest_outlined,
      'color': AppTheme.mintGreen,
      'assetPath': 'assets/sounds/forest.mp3',
    },
    {
      'title': 'Waves',
      'description': 'Ocean waves on the shore',
      'icon': Icons.waves_outlined,
      'color': AppTheme.secondaryBlue,
      'assetPath': 'assets/sounds/waves.mp3',
    },
    {
      'title': 'Fire',
      'description': 'Crackling fireplace',
      'icon': Icons.local_fire_department_outlined,
      'color': AppTheme.blushPink,
      'assetPath': 'assets/sounds/fire.mp3',
    },
    {
      'title': 'Wind Chimes',
      'description': 'Gentle wind chimes in a breeze',
      'icon': Icons.wind_power_outlined,
      'color': AppTheme.lavender,
      'assetPath': 'assets/sounds/wind_chimes.mp3',
    },
  ];

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playSound(int index) async {
    if (_isPlaying) {
      await _audioPlayer.stop();
    }

    if (_selectedSoundIndex == index && _isPlaying) {
      setState(() {
        _isPlaying = false;
        _selectedSoundIndex = -1;
      });
      return;
    }

    try {
      // Note: In a real app, you would need actual sound files in the assets folder
      // For now, this is just a demonstration
      // Using AssetSource would require actual files
      // await _audioPlayer.play(AssetSource(_sounds[index]['assetPath']));

      // Instead of playing an actual sound, we'll just simulate it
      // In a real app with sound files, use the line above

      await Future.delayed(const Duration(milliseconds: 500));

      setState(() {
        _isPlaying = true;
        _selectedSoundIndex = index;
      });

      _audioPlayer.setVolume(_volume);
    } catch (e) {
      debugPrint('Error playing sound: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not play the sound. Please try again.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _changeVolume(double value) {
    setState(() {
      _volume = value;
    });
    _audioPlayer.setVolume(_volume);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Relaxing Sounds'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              'Select a sound to help you relax',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: AppTheme.textLight),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _sounds.length,
              itemBuilder: (context, index) {
                final sound = _sounds[index];
                final bool isSelected = _selectedSoundIndex == index;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Card(
                    elevation: isSelected ? 4 : 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () => _playSound(index),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: sound['color'].withOpacity(
                                  isSelected ? 1.0 : 0.2,
                                ),
                                shape: BoxShape.circle,
                                boxShadow:
                                    isSelected
                                        ? [
                                          BoxShadow(
                                            color: sound['color'].withOpacity(
                                              0.3,
                                            ),
                                            blurRadius: 12,
                                            spreadRadius: 2,
                                          ),
                                        ]
                                        : null,
                              ),
                              child: Icon(
                                sound['icon'],
                                color:
                                    isSelected ? Colors.white : sound['color'],
                                size: 30,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    sound['title'],
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color:
                                          isSelected
                                              ? sound['color']
                                              : AppTheme.textDark,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    sound['description'],
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: AppTheme.textLight),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                isSelected && _isPlaying
                                    ? Icons.pause_circle_filled
                                    : Icons.play_circle_filled,
                                color:
                                    isSelected ? sound['color'] : Colors.grey,
                                size: 36,
                              ),
                              onPressed: () => _playSound(index),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (_selectedSoundIndex >= 0)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    spreadRadius: 0,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Now Playing: ${_sounds[_selectedSoundIndex]['title']}',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          _audioPlayer.stop();
                          setState(() {
                            _isPlaying = false;
                            _selectedSoundIndex = -1;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.volume_down, color: AppTheme.textLight),
                      Expanded(
                        child: Slider(
                          value: _volume,
                          min: 0.0,
                          max: 1.0,
                          activeColor: _sounds[_selectedSoundIndex]['color'],
                          inactiveColor: _sounds[_selectedSoundIndex]['color']
                              .withOpacity(0.2),
                          onChanged: _changeVolume,
                        ),
                      ),
                      const Icon(Icons.volume_up, color: AppTheme.textLight),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
