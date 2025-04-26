import 'package:baby_package/baby_package.dart';
import 'package:fake_adhar/src/core/%20theme/light_theme.dart';
import 'package:fake_adhar/src/core/routes/import.dart';
import 'package:fake_adhar/src/core/utils/dismiss_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppConfig {
  const AppConfig._();

  static const String appName = 'Library App';
  static const Locale defaultLocale = Locale('en', 'US');
  static const Size designSize = Size(375, 812);
  static const double minTextScale = 0.8;
  static const double maxTextScale = 1.2;
}

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: AppConfig.designSize,
      minTextAdapt: true,
      builder: (context, child) => const AppContainer(),
    );
  }
}

class AppContainer extends StatelessWidget {
  const AppContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: AppConfig.appName,
        themeMode: ThemeMode.light,
        theme: LightTheme.theme,
        routerConfig: AppRouter.router,
        builder: (context, child) => AppScaffold(child: child),
      ),
    );
  }
}

class AppScaffold extends StatelessWidget {
  const AppScaffold({required this.child, super.key});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final textScale = context.mediaQuery.textScaler
        .scale(1)
        .clamp(AppConfig.minTextScale, AppConfig.maxTextScale);

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        platformBrightness: Theme.of(context).brightness,
        textScaler: TextScaler.linear(textScale),
      ),
      child: ErrorBoundary(child: child ?? const SizedBox.shrink()),
    );
  }
}

class ErrorBoundary extends StatelessWidget {
  const ErrorBoundary({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SizedBox.expand(child: child),
    );
  }
}
