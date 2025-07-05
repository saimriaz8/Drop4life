import 'package:drop4life/core/appcolors/app_colors.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/imports/all_imports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: AppColors.textDark, // test with solid color
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        title: 'Drop 4 Life',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        routerConfig: goRouter,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;
  static const String pageName = '/';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void onPressedGetStarted() {
    GoRouter.of(context).push(LoginPage.pageName);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    final Size(:width, :height) = size;

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Stack(
            children: [
              Positioned.fill(
                child: FullscreenCarousel(height: height, width: width),
              ),
              Positioned(
                bottom: 40,
                left: 0,
                right: 0,
                child: Center(
                  child: GetStartedButton(
                    onPressed: onPressedGetStarted,
                    width: width * 0.8,
                    height: 50,
                    text: 'Get Started',
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
