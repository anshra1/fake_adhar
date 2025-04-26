import 'package:fake_adhar/re_name.dart';
import 'package:fake_adhar/src/core/config/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inditrans/inditrans.dart' as inditrans;

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await inditrans.init();
    await init();

    FlutterError.onError = (FlutterErrorDetails details) {
      // In a real app, log this to a crash reporting service (e.g., Sentry)
      debugPrint('Flutter error: ${details.exceptionAsString()}');
    }; // Initialize dependencies first

    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    runApp(const RootApp());
  } catch (error, stackTrace) {
    FlutterError.reportError(
      FlutterErrorDetails(
        exception: error,
        library: 'Flutter test framework',
        context: ErrorSummary('while running async test code'),
      ),
    );

    runApp(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text('Error initializing app: $error $stackTrace'),
          ),
        ),
      ),
    );
  }
}
