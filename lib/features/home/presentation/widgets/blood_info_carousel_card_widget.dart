import 'dart:async';
import 'package:drop4life/core/appcolors/app_colors.dart';
import 'package:flutter/material.dart';

class BloodInfoCarouselCardWidget extends StatefulWidget {
  final double height;
  final double width;

  const BloodInfoCarouselCardWidget({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  State<BloodInfoCarouselCardWidget> createState() =>
      _BloodInfoCarouselCardWidgetState();
}

class _BloodInfoCarouselCardWidgetState
    extends State<BloodInfoCarouselCardWidget> {
  final List<Map<String, String>> infoMessages = [
    {
      'title': '❤️ Be a Hero',
      'subtitle': 'Every drop counts. Your blood can save lives.',
    },
    {
      'title': '🤝 Join the Community',
      'subtitle': 'Thousands have pledged to donate. Have you?',
    },
    {
      'title': '💡 Did You Know?',
      'subtitle': 'You can donate blood every 3 months safely.',
    },
    {
      'title': '🌟 Inspire Others',
      'subtitle': 'Lead by example. Encourage friends to donate.',
    },
    {
      'title': '🏥 Health Benefit',
      'subtitle': 'Donating blood improves heart health and reduces stress.',
    },
  ];

  int currentIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        currentIndex = (currentIndex + 1) % infoMessages.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final current = infoMessages[currentIndex];

    return Container(
      height: widget.height,
      width: widget.width,
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient:
            Theme.of(context).brightness == Brightness.light
                ? LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.red.shade200, // subtle red shade
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
                : LinearGradient(
                  colors: [Colors.black, Colors.red.shade500,],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
        boxShadow: [
          BoxShadow(
            color: Colors.red.shade200.withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder:
            (child, animation) =>
                FadeTransition(opacity: animation, child: child),
        child: Padding(
          key: ValueKey(currentIndex),
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Updated: more neutral/inspirational icon
              Container(
                height: widget.height * 0.7,
                width: widget.height * 0.7,
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.volunteer_activism, // neutral inspirational icon
                  color: AppColors.primaryColor,
                  size: 40,
                ),
              ),
              const SizedBox(width: 16),
              // Text section
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      current['title'] ?? '',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      current['subtitle'] ?? '',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
