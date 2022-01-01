import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:tomato_market/utils/logger.dart';

class IntroPage extends StatelessWidget {
  PageController controller;
  IntroPage(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        Size size = MediaQuery.of(context).size;
        final sizeOfPosImg = (size.width - 32) * 0.1;
        final imgSize = size.width - 32;

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '토마토 마켓',
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                  // TextStyle(
                  //   fontSize: 40,
                  //   color: Theme.of(context).colorScheme.primary,
                  //   fontWeight: FontWeight.w800,
                  // ),
                ),
                SizedBox(
                  width: imgSize,
                  height: imgSize,
                  child: Stack(
                    children: [
                      ExtendedImage.asset('assets/imgs/carrot_intro.png'),
                      Positioned(
                        width: sizeOfPosImg,
                        left: imgSize * 0.45,
                        top: imgSize * 0.45,
                        height: sizeOfPosImg,
                        child: ExtendedImage.asset(
                            'assets/imgs/carrot_intro_pos.png'),
                      ),
                    ],
                  ),
                ),
                const Text(
                  '우리 동네 중고 직거래 토마토마켓',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                const Text(
                  '''토마토마켓은 동네 직거래 마켓이에요.
내 동네를 설정하고 시작해보세요!''',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                  textAlign: TextAlign.center,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextButton(
                      onPressed: () {
                        controller.animateToPage(1,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease);
                        logger.d('on text button clicked!!');
                      },
                      child: Text(
                        '내 동네 설정하고 시작하기',
                        style: Theme.of(context).textTheme.button,
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
