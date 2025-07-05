import 'package:drop4life/core/appproviders/riverpod_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IndexStackWidget extends ConsumerWidget {
  final List<Widget> children;
  const IndexStackWidget({super.key, required this.children});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavigationRiverpdProvider);
    return IndexedStack(
      index: currentIndex,
      children: children,
    );
  }
}
