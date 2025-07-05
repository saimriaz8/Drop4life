import 'package:drop4life/features/auth/sign_in/presentation/login_page.dart';
import 'package:drop4life/features/auth/sign_up/presentation/signup_page.dart';
import 'package:drop4life/features/bottom_navigation/presentation/bottom_navigation_page.dart';
import 'package:drop4life/features/home/model/blood_request.dart';
import 'package:drop4life/features/notification/presentation/notifications_page.dart';
import 'package:drop4life/features/request_blood_form/presentation/request_blood_form_page.dart';
import 'package:drop4life/features/requestdetails/presentation/request_detail_page.dart';
import 'package:drop4life/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

final GoRouter goRouter = GoRouter(
  routes: [
    GoRoute(
      path: MyHomePage.pageName,
      builder: (context, state) => MyHomePage(title: 'News App'),
    ),
    GoRoute(path: LoginPage.pageName, builder: (context, state) => LoginPage()),
    GoRoute(
      path: SignupPage.pageName,
      builder: (context, state) => SignupPage(),
    ),
    GoRoute(
      path: BottomNavigationPage.pageName,
      builder: (context, state) {
        var record = state.extra as (User?, Map<String, dynamic>);
        return BottomNavigationPage(record: record);
      },
    ),
    GoRoute(
      path: RequestBloodFormPage.pageName,
      builder: (context, state) {
        var record = state.extra as (User?, Map<String, dynamic>);
        return RequestBloodFormPage(record: record);
      },
    ),
    GoRoute(
      path: RequestDetailPage.pageName,
      builder: (context, state) {
        var record = state.extra as (User?, Map<String, dynamic>, BloodRequest);
        return RequestDetailPage(record: record);
      },
    ),
    GoRoute(
      path: NotificationsPage.pageName,
      builder: (context, state) {
        return NotificationsPage();
      },
    ),
  ],
);
