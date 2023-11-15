import 'package:flutter/material.dart';

class AnimatedScreen extends StatelessWidget {

  static const name = 'animated_screen';

  const AnimatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Poniendo Scaffold ya estamos indicando que es otra pantalla
      appBar: AppBar(
        title: const Text('Animated Container'),
      ),
      body: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutCubic,
          width: 300,
          height: 230,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20)
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.play_arrow_rounded),
        onPressed: () {

        },
      ),
    );
  }
}