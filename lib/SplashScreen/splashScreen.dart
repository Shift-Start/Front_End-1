import 'package:flutter/material.dart';

import '../onBoarder/onboarding.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5)).then((_) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Onboarding()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter, // بداية التدرج من الأعلى
            end: Alignment.bottomCenter, // نهاية التدرج إلى الأسفل
            colors: [
              Color.fromARGB(255, 243, 218, 223),
              Color.fromARGB(255, 174, 125, 172),
              Color.fromARGB(255, 65, 59, 97),
              Color.fromARGB(255, 25, 48, 92),
              Color.fromARGB(255, 3, 18, 47)
            ],
          ),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              Container(
                width: 330,
                height: 210,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          'images/Logo.png')), //shape: BoxShape.circle
                ),
              ),
              SizedBox(
                height: 0,
              ),
              Text(
                'ShiftStart',
                style: TextStyle(
                  fontFamily: 'DMSans_18pt-Bold',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 24.83,
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
