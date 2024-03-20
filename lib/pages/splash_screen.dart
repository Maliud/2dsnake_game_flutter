import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snakegame_flutter/pages/snakeGame_screen.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/img/splash.jpeg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
          // mainAxisAlignment: MainAxisAlignment.end,
          children: [
            BounceInDown(
              duration: const Duration(seconds: 1),
              child: Container(
                margin: const EdgeInsets.only(top: 50),
                alignment: Alignment.center,
                width: double.infinity,
                height: 200,
                child: Text('Snake Game',
                    style: GoogleFonts.pressStart2p(
                        textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold))),
              ),
            ),
            const SizedBox(height: 420),
            
            BounceInDown(
              duration: const Duration(seconds: 1),
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 100,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SnakeGameScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 20),
                      textStyle: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  child: Text('Play',
                      style: GoogleFonts.pressStart2p(
                          textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold))),
                ),
              ),
            ),
            BounceInDown(
              duration: const Duration(seconds: 1),
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                width: double.infinity,
                child: Text('Developed by Muhammed Ali Ud',
                    style: GoogleFonts.outfit(
                        textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold))),
              ),
            ),
          ]),
    ));
  }
}
