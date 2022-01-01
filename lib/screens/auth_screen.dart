import 'package:flutter/material.dart';
import 'package:tomato_market/screens/start/intro_page.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({Key? key}) : super(key: key);

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          IntroPage(_pageController),
          Container(color: Colors.accents[2]),
          Container(color: Colors.accents[5]),
        ],
      ),
    );
  }
}
