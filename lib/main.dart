import 'dart:math';
import 'package:flutter/material.dart';
import 'package:scratcher/scratcher.dart';

void main() => runApp(ScratcherGame());

class ScratcherGame extends StatefulWidget {
  @override
  _ScratcherGameState createState() => _ScratcherGameState();
}

class _ScratcherGameState extends State<ScratcherGame> {
  final Random _random = Random();
  bool _isScratched = false;
  bool _hasWon = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Scratcher Game with Prizes'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Scratch to reveal the hidden image!',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              _isScratched
                  ? _hasWon
                      ? Column(
                          children: [
                            const Text(
                              'Congratulations! You won a prize!',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.green),
                            ),
                            const SizedBox(height: 20),
                            // Display the prize image here
                            Image.asset('assets/download.jpg', width: 200),
                          ],
                        )
                      : const Text(
                          'Sorry, you didn\'t win this time.',
                          style: TextStyle(fontSize: 20, color: Colors.red),
                        )
                  : Scratcher(
                      brushSize: 30,
                      threshold: 50,
                      color: Colors.blue,
                      onThreshold: () {
                        // Handle winning logic here
                        if (_random.nextDouble() < 0.5) {
                          setState(() {
                            _hasWon = true;
                          });
                        } else {
                          setState(() {
                            _hasWon = false;
                          });
                        }
                        setState(() {
                          _isScratched = true;
                        });
                      },
                      child: Container(
                        width: 300,
                        height: 300,
                        color: Colors.grey,
                        child: Image.asset('assets/hidden_image.jpg'),
                      ),
                    ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isScratched = false;
                    _hasWon = false;
                  });
                },
                child: const Text('Reset'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
