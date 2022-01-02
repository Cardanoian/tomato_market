import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:provider/src/provider.dart';
import 'package:tomato_market/constants/common_size.dart';
import 'package:tomato_market/states/user_provider.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final inputBorder =
      const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey));

  final TextEditingController _phoneNumberController =
      TextEditingController(text: "010");

  final TextEditingController _codeController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  VerificationStatus _verificationStatus = VerificationStatus.none;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        Size size = MediaQuery.of(context).size;
        return IgnorePointer(
          ignoring: _verificationStatus == VerificationStatus.verifying
              ? true
              : false,
          child: Form(
            key: _formKey,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('전화번호 로그인'),
              ),
              body: Padding(
                padding: const EdgeInsets.all(common_padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(children: [
                      ExtendedImage.asset(
                        'assets/imgs/padlock.png',
                        width: size.width * 0.15,
                        height: size.height * 0.15,
                      ),
                      const SizedBox(
                        width: common_small_padding,
                      ),
                      Text(
                        '토마토마켓은 휴대폰 번호로 가입해요.\n번호는 안전하게 보관되며\n어디에도 공개되지 않아요.',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ]),
                    const SizedBox(
                      height: common_padding,
                    ),
                    TextFormField(
                        controller: _phoneNumberController,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          MaskedInputFormatter("000 0000 0000")
                        ],
                        decoration: InputDecoration(
                            focusedBorder: inputBorder, border: inputBorder),
                        validator: (phoneNumber) {
                          if (phoneNumber != null && phoneNumber.length == 13) {
                            return null;
                          } else {
                            // error
                            return '전화번호가 틀렸습니다.';
                          }
                        }),
                    const SizedBox(height: common_small_padding),
                    TextButton(
                      onPressed: () {
                        if (_formKey.currentState != null) {
                          bool passed = _formKey.currentState!.validate();
                          // print(passed);
                          if (passed) {
                            setState(() {
                              _verificationStatus = VerificationStatus.codeSent;
                            });
                          }
                        }
                      },
                      child: const Text('인증문자 발송'),
                    ),
                    const SizedBox(
                      height: common_padding,
                    ),
                    AnimatedOpacity(
                      duration: common_duration,
                      opacity: (_verificationStatus == VerificationStatus.none)
                          ? 0
                          : 1,
                      child: AnimatedContainer(
                        duration: common_duration,
                        curve: Curves.easeInOut,
                        height: getVerificationHeight(_verificationStatus),
                        child: TextFormField(
                          controller: _codeController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [MaskedInputFormatter("000000")],
                          decoration: InputDecoration(
                            focusedBorder: inputBorder,
                            border: inputBorder,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: common_small_padding,
                    ),
                    AnimatedContainer(
                      duration: common_duration,
                      curve: Curves.easeInOut,
                      height: getVerificationBtnHeight(_verificationStatus),
                      child: TextButton(
                          onPressed: () {
                            attemptVerify();
                          },
                          child: _verificationStatus ==
                                  VerificationStatus.verifying
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                  backgroundColor: Colors.grey,
                                )
                              : const Text('인증번호 확인')),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  double getVerificationHeight(VerificationStatus status) {
    switch (status) {
      case VerificationStatus.none:
        return 0;
      case VerificationStatus.codeSent:
      case VerificationStatus.verifying:
      case VerificationStatus.verificationDone:
        return 55 + common_small_padding;
    }
  }

  double getVerificationBtnHeight(VerificationStatus status) {
    switch (status) {
      case VerificationStatus.none:
        return 0;
      case VerificationStatus.codeSent:
      case VerificationStatus.verifying:
      case VerificationStatus.verificationDone:
        return 42 + common_small_padding;
    }
  }

  void attemptVerify() async {
    setState(() {
      _verificationStatus = VerificationStatus.verifying;
    });

    await Future.delayed(common_long_duration);

    setState(() {
      _verificationStatus = VerificationStatus.verificationDone;
    });

    context.read<UserProvider>().setUserAuth(true);
  }
}

enum VerificationStatus { none, codeSent, verifying, verificationDone }
