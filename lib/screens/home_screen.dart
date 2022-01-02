import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:tomato_market/states/user_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(
                Icons.logout,
                color: Colors.black,
              ),
              onPressed: () {
                context.read<UserProvider>().setUserAuth(false);
              },
            ),
          ],
          title: const Text('홈페이지'),
        ),
      ),
    );
  }
}
