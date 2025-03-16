import 'package:flutter/material.dart';
import 'package:flutter_app_1/utils/app_theme.dart';

class MeditationScreen extends StatefulWidget {
  const MeditationScreen({super.key});

  @override
  State<MeditationScreen> createState() => _MeditationScreenState();
}

class _MeditationScreenState extends State<MeditationScreen> {
  final List<Map<String, dynamic>> _meditations = [
    {
      'title': 'Mindful Morning',
      'description': 'Start your day with clarity and purpose',
      'duration': '10 min',
      'color': AppTheme.lightBlue,
      'icon': Icons.wb_sunny_outlined,
      'content':
          'Begin by finding a comfortable seated position. Close your eyes and take a deep breath in through your nose, filling your lungs completely, and then slowly exhale through your mouth. Continue breathing deeply, allowing your body to relax with each breath.\n\nBring your awareness to the present moment. Notice the sensations in your body - the weight of your body on the surface beneath you, the feeling of your clothes against your skin, the temperature of the air around you.\n\nFocus on your breath. Don\'t try to control it, just observe it. Notice the rhythm of your inhalations and exhalations, the rise and fall of your chest and abdomen.\n\nAs thoughts arise, acknowledge them without judgment, then gently bring your attention back to your breath.\n\nSet an intention for your day. What quality would you like to cultivate today? Perhaps it\'s patience, gratitude, or compassion.\n\nCarry this intention with you as you slowly open your eyes and prepare to begin your day with mindfulness and purpose.',
    },
    {
      'title': 'Stress Relief',
      'description': 'Release tension and find calm',
      'duration': '15 min',
      'color': AppTheme.paleGreen,
      'icon': Icons.spa_outlined,
      'content':
          'Find a comfortable position, either sitting or lying down. Close your eyes and take a few deep breaths, inhaling through your nose and exhaling through your mouth.\n\nBegin by bringing awareness to areas of tension in your body. Notice any tightness or discomfort without trying to change it. Just observe.\n\nNow, starting with your toes, consciously tense and then relax each part of your body, working your way up. Tense your toes, hold for 5 seconds, then release, feeling the difference between tension and relaxation.\n\nContinue with your feet, calves, thighs, abdomen, chest, hands, arms, shoulders, neck, and face. With each release, imagine the stress flowing out of your body.\n\nNow visualize a peaceful scene – perhaps a beach, forest, or mountain. Engage all your senses in this visualization. What do you see? What sounds do you hear? What do you smell and feel?\n\nRemain in this peaceful place, breathing deeply and allowing a sense of calm to wash over you. Remember that you can return to this place whenever you need to center yourself.\n\nWhen you\'re ready, gently bring awareness back to your body and the present moment, carrying this sense of peace and relaxation with you.',
    },
    {
      'title': 'Body Scan',
      'description': 'Connect with your body and release tension',
      'duration': '20 min',
      'color': AppTheme.blushPink,
      'icon': Icons.self_improvement_outlined,
      'content':
          'Lie down in a comfortable position, arms at your sides, palms facing up. Close your eyes and take several deep breaths, allowing your body to settle into the surface beneath you.\n\nBring your awareness to your feet. Notice any sensations – warmth, coolness, tingling, pressure. There\'s no need to change anything, simply observe with curiosity. If you notice tension, imagine your breath flowing to that area, softening and releasing the tension as you exhale.\n\nSlowly move your attention up through your body – ankles, calves, knees, thighs, hips, lower back, abdomen, chest, shoulders, arms, hands, neck, and finally your head and face. Spend time with each area, observing sensations without judgment.\n\nIf your mind wanders, gently bring it back to the part of the body you were focusing on.\n\nAfter scanning your entire body, spend a moment sensing your body as a whole – a complete, integrated organism. Feel the boundary between your body and the space around it.\n\nNotice how your body feels different now compared to when you began. Perhaps there\'s a greater sense of relaxation, heaviness, or lightness.\n\nWhen you\'re ready, wiggle your fingers and toes, take a deeper breath, and slowly open your eyes, carrying this heightened body awareness with you.',
    },
    {
      'title': 'Loving-Kindness',
      'description': 'Cultivate compassion for yourself and others',
      'duration': '12 min',
      'color': AppTheme.lavender,
      'icon': Icons.favorite_outline,
      'content':
          'Begin in a comfortable seated position. Take a few deep breaths to settle into the present moment.\n\nPlace your hand over your heart and feel its rhythm. Bring to mind someone who naturally makes you smile – a loved one, a dear friend, perhaps a pet. Feel the warmth their image brings to your heart.\n\nSilently repeat these phrases, directing them toward this beloved: "May you be happy. May you be healthy. May you be safe. May you live with ease."\n\nNow turn these wishes toward yourself. Place both hands over your heart and repeat: "May I be happy. May I be healthy. May I be safe. May I live with ease." Notice any resistance that arises, and respond with gentleness and patience.\n\nNext, extend these wishes to a neutral person – someone you neither like nor dislike particularly. Visualize them and repeat the phrases.\n\nIf you feel ready, bring to mind someone with whom you have difficulty. You might begin with someone who causes only mild irritation before moving to more challenging relationships. Offer them the same wishes.\n\nFinally, expand your loving-kindness to all beings everywhere: "May all beings be happy. May all beings be healthy. May all beings be safe. May all beings live with ease."\n\nRest in the boundless nature of loving-kindness, feeling it radiate from your heart outward in all directions.',
    },
    {
      'title': 'Evening Wind Down',
      'description': 'Relax your mind before sleep',
      'duration': '8 min',
      'color': AppTheme.paleLavender,
      'icon': Icons.nightlight_outlined,
      'content':
          'Find a comfortable position, either sitting or lying down. Take a few deep breaths, feeling your body become heavier with each exhale.\n\nBegin by acknowledging your day. Consider three things that went well today, however small. Allow yourself to feel gratitude for these moments.\n\nNow, release the events of the day. Visualize your thoughts, worries, and to-do lists as leaves floating away on a gentle stream. They\'ll be there tomorrow if you need them, but for now, let them go.\n\nBring awareness to your body, noticing areas of tension. With each exhale, imagine these areas softening and melting away.\n\nFocus on your breath, feeling it naturally slow down. With each inhale, silently say "calm." With each exhale, silently say "release."\n\nVisualize yourself in a safe, peaceful place – perhaps a cozy room with soft lighting, or under a starry sky. Feel the comfort and security of this space.\n\nAllow your mind to grow quiet, knowing that this is your time to rest and restore. If thoughts arise, acknowledge them gently and return to your breath.\n\nAs this practice concludes, set the intention for restful sleep, knowing you have given your mind and body permission to fully relax and renew.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guided Meditations'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Find peace and presence',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: AppTheme.textLight),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                itemCount: _meditations.length,
                itemBuilder: (context, index) {
                  final meditation = _meditations[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: _MeditationCard(
                      title: meditation['title'],
                      description: meditation['description'],
                      duration: meditation['duration'],
                      color: meditation['color'],
                      icon: meditation['icon'],
                      content: meditation['content'],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MeditationCard extends StatelessWidget {
  final String title;
  final String description;
  final String duration;
  final Color color;
  final IconData icon;
  final String content;

  const _MeditationCard({
    required this.title,
    required this.description,
    required this.duration,
    required this.color,
    required this.icon,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder:
                  (context, animation, secondaryAnimation) =>
                      _MeditationDetailScreen(
                        title: title,
                        content: content,
                        color: color,
                        icon: icon,
                      ),
              transitionsBuilder: (
                context,
                animation,
                secondaryAnimation,
                child,
              ) {
                const begin = Offset(0.0, 0.05);
                const end = Offset.zero;
                const curve = Curves.easeOut;

                var tween = Tween(
                  begin: begin,
                  end: end,
                ).chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);

                return SlideTransition(
                  position: offsetAnimation,
                  child: FadeTransition(opacity: animation, child: child),
                );
              },
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 30, color: color),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textLight,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  duration,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MeditationDetailScreen extends StatelessWidget {
  final String title;
  final String content;
  final Color color;
  final IconData icon;

  const _MeditationDetailScreen({
    required this.title,
    required this.content,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 30, color: color),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                child: AnimatedOpacity(
                  opacity: 1.0,
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    content,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(height: 1.6, fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
