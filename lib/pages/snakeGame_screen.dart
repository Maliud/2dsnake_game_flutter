// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SnakeGameScreen extends StatefulWidget {
  const SnakeGameScreen({super.key});

  @override
  State<SnakeGameScreen> createState() => _SnakeGameScreenState();
}

enum Direction { up, down, left, right }

class _SnakeGameScreenState extends State<SnakeGameScreen> {
 
  Offset foodCoordinates = const Offset(0, 0);
  List<Offset> snakeSegments = [
    const Offset(3, 5), 
    const Offset(3, 4), 
  ];

  int socreGame = 0;

  bool isPlaying = false;

  Timer? gameTimer;
  int numRows = 13; 
  int numColumns = 10; 
  Direction currentDirection = Direction.right;

  void changeDirection(Direction newDirection) {
    if (newDirection == Direction.up && currentDirection != Direction.down) {
      currentDirection = Direction.up;
    } else if (newDirection == Direction.down &&
        currentDirection != Direction.up) {
      currentDirection = Direction.down;
    } else if (newDirection == Direction.left &&
        currentDirection != Direction.right) {
      currentDirection = Direction.left;
    } else if (newDirection == Direction.right &&
        currentDirection != Direction.left) {
      currentDirection = Direction.right;
    }
  }

  
  void startGameTimer() {
    gameTimer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      moveSnake();
    });
  }

  
  void stopGameTimer() {
    gameTimer?.cancel();
  }

  void playGame() {
    generateRandomFood();
    startGameTimer();
    setState(() {
      isPlaying = true;
    });
  }

  void resetGame() {
    setState(() {
      snakeSegments = [
        const Offset(3, 5), 
        const Offset(3, 4), 
      ];
      socreGame = 0;
      playGame();
    });
  }

  @override
  void initState() {
    
    Future.delayed(const Duration(seconds: 3), () {
      AwesomeDialog(
        dismissOnTouchOutside: false,
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.bottomSlide,
        title: 'Start',
        btnOkOnPress: () async {
          playGame();
        },
      ).show();
    });
    super.initState();
    
  }

  void moveSnake() {
    setState(() {
    
      Offset head = snakeSegments.first;

    
      Offset newHead;
      switch (currentDirection) {
        case Direction.up:
          newHead = Offset(head.dx, head.dy - 1);
          break;
        case Direction.down:
          newHead = Offset(head.dx, head.dy + 1);
          break;
        case Direction.left:
          newHead = Offset(head.dx - 1, head.dy);
          break;
        case Direction.right:
          newHead = Offset(head.dx + 1, head.dy);
          break;
      }

      
      snakeSegments.insert(0, newHead);

      
      if (snakeSegments.length > 2) {
        snakeSegments.removeLast();
      }

      if (checkSelfCollision()) {
      
        stopGameTimer();
        AwesomeDialog(
          dismissOnTouchOutside: false,
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.bottomSlide,
          // title: 'Game Over',
          body: Column(
            children: [
              Text('Game Over',
                  style: GoogleFonts.pressStart2p(
                    color: Colors.black,
                    fontSize: 25,
                  )),
              const SizedBox(
                height: 10,
              ),
              Text('Score: $socreGame',
                  style: GoogleFonts.pressStart2p(
                    color: Colors.black,
                    fontSize: 15,
                  )),
            ],
          ),
          btnOkOnPress: () async {
            resetGame();
          },
        ).show();
      }

      
      checkCollisions();
    });
  }

  bool checkSelfCollision() {
    final head = snakeSegments.first;

    
    for (int i = 1; i < snakeSegments.length; i++) {
      if (snakeSegments[i] == head) {
    
        return true;
      }
    }

    
    return false;
  }

  void checkCollisions() {
    
    if (snakeSegments.first == foodCoordinates) {
    
      generateRandomFood();

    
    
      snakeSegments.add(snakeSegments.last);
    
      socreGame++;
    }

    
    if (snakeSegments.first.dx < 0 ||
        snakeSegments.first.dx >= numColumns ||
        snakeSegments.first.dy < 0 ||
        snakeSegments.first.dy >= numRows) {
      stopGameTimer();
      AwesomeDialog(
        dismissOnTouchOutside: false,
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        // title: 'Game Over',
        body: Column(
          children: [
            Text('Game Over',
                style: GoogleFonts.pressStart2p(
                  color: Colors.black,
                  fontSize: 25,
                )),
            const SizedBox(
              height: 10,
            ),
            Text('Score: $socreGame',
                style: GoogleFonts.pressStart2p(
                  color: Colors.black,
                  fontSize: 15,
                )),
          ],
        ),
        btnOkOnPress: () async {
          resetGame();
        },
      ).show();

     
    }

    
  }

  void generateRandomFood() {
    final random = Random();
    const maxX = 10; 
    const maxY = 13; 
    Offset newFoodCoordinates;

    do {
      
      final foodX = random.nextInt(maxX).toDouble();
      final foodY = random.nextInt(maxY).toDouble();
      newFoodCoordinates = Offset(foodX, foodY);
    } while (snakeSegments.contains(
        newFoodCoordinates)); 

    setState(() {
      foodCoordinates = newFoodCoordinates;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 90, 158, 120),
        title: BounceInDown(
            duration: const Duration(seconds: 2),
            child: Text('Score: $socreGame',
                style: GoogleFonts.pressStart2p(
                  color: Colors.black,
                  fontSize: 20,
                ))),
      ),
      body: Column(
        children: [
        
          SizedBox(
            width: 425,
            height: 533,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                color:
                    Colors.grey[200], 
                
                child: CustomPaint(
                  painter: SnakeGamePainter(
                    
                    snakeSegments: snakeSegments,
                    foodCoordinates: foodCoordinates,
                    segmentSize: 50.0, 
                    numRows: 13, 
                    numColumns: 10, 
                    cellSize: 38.1, 
                    isPlaying: isPlaying, 
                  ),
                ),
              ),
            ),
          ),


          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BounceInUp(
                duration: const Duration(seconds: 2),
                child: GestureDetector(
                    onTap: () => changeDirection(Direction.up),
                    child: Image.asset('assets/img/up.png',
                        width: 80, height: 80, fit: BoxFit.fill)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BounceInLeft(
                    duration: const Duration(seconds: 2),
                    child: GestureDetector(
                        onTap: () => changeDirection(Direction.left),
                        child: Image.asset('assets/img/izq.png',
                            width: 80, height: 80, fit: BoxFit.fill)),
                  ),
                  BounceInRight(
                    duration: const Duration(seconds: 2),
                    child: GestureDetector(
                        onTap: () => changeDirection(Direction.right),
                        child: Image.asset('assets/img/der.png',
                            width: 80, height: 80, fit: BoxFit.fill)),
                  ),
                ],
              ),
              BounceInDown(
                duration: const Duration(seconds: 2),
                child: GestureDetector(
                    onTap: () => changeDirection(Direction.down),
                    child: Image.asset('assets/img/dow.png',
                        width: 80, height: 80, fit: BoxFit.fill)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SnakeGamePainter extends CustomPainter {
  final List<Offset> snakeSegments;
  final Offset foodCoordinates;
  final double segmentSize;
  final int numRows;
  final int numColumns;
  final double cellSize;
  final bool isPlaying;

  SnakeGamePainter({
    required this.isPlaying,
    required this.snakeSegments,
    required this.foodCoordinates,
    required this.segmentSize,
    required this.numRows,
    required this.numColumns,
    required this.cellSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
   
    final Paint gridPaint = Paint()
      ..color = Colors.grey[300]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    for (int row = 0; row < numRows; row++) {
      for (int col = 0; col < numColumns; col++) {
        final left = col * cellSize;
        final top = row * cellSize;
        final rect = Rect.fromLTWH(left, top, cellSize, cellSize);
        canvas.drawRect(rect, gridPaint);
      }
    }

    
    final Paint borderPaint = Paint()
      ..color = const Color.fromARGB(255, 90, 158, 120)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawRect(
        Rect.fromPoints(const Offset(0, 0), Offset(size.width, size.height)),
        borderPaint);

    if (isPlaying) {
      final Paint snakePaint = Paint()
        ..color = const Color.fromARGB(255, 90, 158, 120);

      for (var segment in snakeSegments) {
        final left = segment.dx * cellSize;
        final top = segment.dy * cellSize;
        final rect = Rect.fromLTWH(left, top, cellSize, cellSize);
        canvas.drawRect(rect, snakePaint);
      }

     
      final Paint foodPaint = Paint()..color = Colors.red;
      final foodLeft = foodCoordinates.dx * cellSize;
      final foodTop = foodCoordinates.dy * cellSize;
      final foodRect = Rect.fromLTWH(foodLeft, foodTop, cellSize, cellSize);
      canvas.drawRect(foodRect, foodPaint);
     
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
