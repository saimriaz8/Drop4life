import 'package:drop4life/features/aichat/presentation/ai_chat_page.dart';
import 'package:drop4life/features/home/presentation/home_page.dart';
import 'package:drop4life/features/bottom_navigation/presentation/widgets/bottom_bar_widget.dart';
import 'package:drop4life/features/profile/presentation/profile_page.dart';
import 'package:drop4life/shared/widgets/index_stack_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BottomNavigationPage extends StatelessWidget {
  static const String pageName = '/home';
  final (User?, Map<String, dynamic>) record;
  const BottomNavigationPage({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      HomePage(record: record),
      AIChatPage(),
      ProfilePage(record: record),
    ];
    return Scaffold(
      body: IndexStackWidget(children: pages),
      bottomNavigationBar: BottomBarWidget(),
    );
  }
}
