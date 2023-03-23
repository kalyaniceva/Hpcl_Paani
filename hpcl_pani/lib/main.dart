import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hpcl_pani/screens/hpcl_outletview.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const HpclPani());
}

class HpclPani extends StatelessWidget {
  const HpclPani({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return const MaterialApp(home: HpclSplashScreen());
    });
  }
}

class HpclSplashScreen extends StatefulWidget {
  const HpclSplashScreen({super.key});

  @override
  State<HpclSplashScreen> createState() => _HpclSplashScreenState();
}

class _HpclSplashScreenState extends State<HpclSplashScreen> {
  static const Duration _interval = Duration(seconds: 10);
  Timer? _timer;
  

  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  void initState() {
    super.initState();

    Timer(
        const Duration(seconds: 3),
        () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HpclView())));
    _timer = Timer.periodic(_interval, (timer) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HpclView()));
     
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/bottel1.jpg')),
        ),
        child: Center(
          child: SizedBox(
              height: 50.h,
              width: 50.w,
              child: Image.asset('assets/images/logo.jpeg')),
        ),
      ),
    );
  }
}
