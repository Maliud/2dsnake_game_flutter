import 'package:flutter/material.dart';
import 'package:snakegame_flutter/pages/snakeGame_screen.dart';
import 'package:snakegame_flutter/pages/splash_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     initialRoute: 'splash',
      routes: {
        'splash': (BuildContext context) => const SplashScreen(),
        'home': (BuildContext context) =>  const SnakeGameScreen(),
      },
      debugShowCheckedModeBanner: false,
      title: '2d snake game flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}




