import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomato_market/constants/common_size.dart';
import 'package:tomato_market/router/locations.dart';
import 'package:tomato_market/screens/splash_screen.dart';
import 'package:tomato_market/screens/start_screen.dart';
import 'package:tomato_market/states/user_provider.dart';
import 'package:tomato_market/utils/logger.dart';

final _routerDelegate = BeamerDelegate(
    guards: [
      BeamGuard(
          // 로그인 안됐을 때
          pathPatterns: ['/'],
          check: (context, location) {
            return context.watch<UserProvider>().userState;
          },
          showPage: BeamPage(child: StartScreen()))
    ],
    // 로그인 완료됐을 때
    locationBuilder: BeamerLocationBuilder(beamLocations: [HomeLocation()]));

void main() {
  logger.d('my first log by logger!!');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(common_long_duration, () => 100), //
        builder: (context, snapshot) {
          return AnimatedSwitcher(
            duration: common_duration,
            child: _splashLoadingWidget(snapshot),
          );
        });
  }

  StatelessWidget _splashLoadingWidget(AsyncSnapshot<Object?> snapshot) {
    if (snapshot.hasError) {
      logger.d('Error occurred!!');
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
    return ChangeNotifierProvider<UserProvider>(
      create: (BuildContext context) {
        return UserProvider();
      },
      child: MaterialApp.router(
        theme: ThemeData(
          primarySwatch: Colors.red,
          fontFamily: 'MapleStory',
          hintColor: Colors.grey[350],
          textTheme: const TextTheme(
              headline3: TextStyle(fontFamily: 'Samanco'),
              subtitle1: TextStyle(
                  fontFamily: 'MapleStory',
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
              headline6: TextStyle(
                  fontFamily: 'MapleStory',
                  fontSize: 25,
                  fontWeight: FontWeight.w700),
              button: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700)),
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              elevation: 2,
              titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontSize: 30,
                  fontFamily: 'Samanco'),
              actionsIconTheme: IconThemeData(color: Colors.black87)),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              backgroundColor: Colors.red,
              primary: Colors.white,
              minimumSize: const Size(48, 48),
              textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
        routeInformationParser: BeamerParser(),
        routerDelegate: _routerDelegate,
      ),
    );
  }
}
