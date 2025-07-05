import 'package:drop4life/core/appcolors/app_colors.dart';
import 'package:drop4life/core/appproviders/riverpod_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BottomBarWidget extends ConsumerWidget {
  const BottomBarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavigationRiverpdProvider);
    final bottomNavigationStateNotifier = ref.read(bottomNavigationRiverpdProvider.notifier);
    return SalomonBottomBar(
      currentIndex: currentIndex,
      onTap: bottomNavigationStateNotifier.onPressedNavItem,
      items: [
        /// Home
        SalomonBottomBarItem(
          icon: Icon(Icons.home),
          title: Text("Home"),
          selectedColor: Colors.red.shade700, // active tab
          unselectedColor: Theme.of(context).brightness == Brightness.light
                        ? AppColors.textDark
                        : AppColors.textLight,
        ),

        /// Likes
        SalomonBottomBarItem(
          icon: Icon(FontAwesomeIcons.commentDots),
          title: Text("Ai Chat"),
          selectedColor: Colors.red.shade700, // active tab
          unselectedColor: Theme.of(context).brightness == Brightness.light
                        ? AppColors.textDark
                        : AppColors.textLight,
        ),

        /// Search
        SalomonBottomBarItem(
          icon: Icon(Icons.person),
          title: Text("Profile"),
          selectedColor: Colors.red.shade700, // active tab
          unselectedColor: Theme.of(context).brightness == Brightness.light
                        ? AppColors.textDark
                        : AppColors.textLight,
        ),
      ],
    );
  }
}
