import 'package:drop4life/core/appcolors/app_colors.dart';
import 'package:drop4life/core/imports/all_imports.dart';
import 'package:flutter/services.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});
  static const String pageName = '/notifications';

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor:
            Theme.of(context).brightness == Brightness.dark
                ? AppColors.textLight
                : AppColors.textDark,
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(title: Text('Notifications')),
          body: Center(
            child: Text(
              'No notifications yet. 🔔',
              style: TextStyle(fontSize: 22),
            ),
          ),
        ),
      ),
    );
  }
}
