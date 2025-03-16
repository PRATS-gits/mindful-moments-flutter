import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app_1/utils/app_theme.dart';

class BreathingScreen extends StatefulWidget {
  const BreathingScreen({super.key});

  @override
  State<BreathingScreen> createState() => _BreathingScreenState();
}

class _BreathingScreenState extends State<BreathingScreen>
    with SingleTickerProviderStateMixin {
  bool _isBreathingActive = false;
  int _currentPhase = 0;
  int _secondsRemaining = 0;
  Timer? _timer;
  late AnimationController _animationController;
  late Animation<double> _animation;

  // Phases: 0 = inhale (4s), 1 = hold (7s), 2 = exhale (8s)
  final List<String> _phaseLabels = ['Inhale', 'Hold', 'Exhale'];
  final List<int> _phaseDurations = [4, 7, 8];
  final List<Color> _phaseColors = [
    AppTheme.lightBlue,
    AppTheme.paleLavender,
    AppTheme.paleGreen,
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  void _startBreathingExercise() {
    setState(() {
      _isBreathingActive = true;
      _currentPhase = 0;
      _secondsRemaining = _phaseDurations[0];
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _secondsRemaining--;
        if (_secondsRemaining <= 0) {
          _currentPhase = (_currentPhase + 1) % 3;
          _secondsRemaining = _phaseDurations[_currentPhase];

          // Handle animations based on phase
          if (_currentPhase == 0) {
            // Inhale - expand
            _animationController.duration = Duration(
              seconds: _phaseDurations[0],
            );
            _animationController.forward(from: 0.5);
          } else if (_currentPhase == 1) {
            // Hold - stay expanded
            _animationController.stop();
          } else if (_currentPhase == 2) {
            // Exhale - contract
            _animationController.duration = Duration(
              seconds: _phaseDurations[2],
            );
            _animationController.reverse(from: 1.0);
          }
        }
      });
    });

    // Start with inhale animation
    _animationController.forward(from: 0.5);
  }

  void _stopBreathingExercise() {
    _timer?.cancel();
    _animationController.reset();
    setState(() {
      _isBreathingActive = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Breathing Exercise'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _isBreathingActive
                  ? _phaseLabels[_currentPhase]
                  : 'Ready to begin',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            Text(
              _isBreathingActive ? '$_secondsRemaining' : '',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: _isBreathingActive ? null : _startBreathingExercise,
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  final size =
                      MediaQuery.of(context).size.shortestSide *
                      0.6 *
                      _animation.value;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      color:
                          _isBreathingActive
                              ? _phaseColors[_currentPhase]
                              : AppTheme.lightBlue.withOpacity(0.5),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryBlue.withOpacity(0.2),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Center(
                      child:
                          _isBreathingActive
                              ? null
                              : const Icon(
                                Icons.play_arrow_rounded,
                                size: 60,
                                color: Colors.white,
                              ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 60),
            if (_isBreathingActive)
              ElevatedButton(
                onPressed: _stopBreathingExercise,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 12,
                  ),
                ),
                child: const Text('Stop Exercise'),
              )
            else
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  '4-7-8 Breathing Technique: Inhale for 4 seconds, hold for 7 seconds, exhale for 8 seconds.',
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: AppTheme.textLight),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
