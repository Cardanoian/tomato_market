import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:tomato_market/router/locations.dart';
import 'package:tomato_market/screens/auth_screen.dart';
import 'package:tomato_market/screens/splash_screen.dart';
import 'package:tomato_market/utils/logger.dart';

final _routerDelegate = BeamerDelegate(guards: [
  BeamGuard(
      pathPatterns: ['/'],
      check: (context, location) {
        return false;
      },
      showPage: BeamPage(child: AuthScreen()))
], locationBuilder: BeamerLocationBuilder(beamLocations: [HomeLocation()]));

void main() {
  logger.d('my first log by logger!!');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(const Duration(milliseconds: 500), () => 100), //
        builder: (context, snapshot) {
          return AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _splashLoadingWidget(snapshot));
        });
  }

  StatelessWidget _splashLoadingWidget(AsyncSnapshot<Object?> snapshot) {
    if (snapshot.hasError) {
      print('Error occurred!!');
      return const Text('Error Occurred!');
    } else if (snapshot.hasData) {
      return TomatoApp();
    } else {
      return SplashScreen();
    }
  }
}

class TomatoApp extends StatelessWidget {
  const TomatoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'MapleStory',
        textTheme: const TextTheme(
            headline3: TextStyle(fontFamily: 'Samanco'),
            button: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700)),
      ),
      routeInformationParser: BeamerParser(),
      routerDelegate: _routerDelegate,
    );
  }
}
