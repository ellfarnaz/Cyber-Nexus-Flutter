import 'package:flutter/material.dart';

class WelcomeSection extends StatelessWidget {
  const WelcomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [
                Colors.cyanAccent,
                Colors.pinkAccent.shade100,
              ],
            ).createShader(bounds),
            child: Text(
              'Welcome to',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
          const SizedBox(height: 5),
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [
                Colors.cyanAccent,
                Colors.pinkAccent.shade100,
              ],
            ).createShader(bounds),
            child: const Text(
              'CYBER NEXUS',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
