import 'dart:async';
import 'package:flutter/material.dart';

import 'package:fluttercommerce/src/routes/router.gr.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  Future<void> startTime() async {
    const _duration = Duration(seconds: 4);
    Timer(_duration, navigationPage);
  }

  navigationPage() async {
    await Navigator.pushReplacementNamed(context, Routes.checkStatusScreen);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Scaffold(
        body: Center(
          child: Lottie.network(
              'https://assets3.lottiefiles.com/packages/lf20_929ihyjs.json'),
        ),
      ),
    );
  }
}
