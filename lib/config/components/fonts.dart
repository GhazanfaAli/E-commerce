import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class GradientText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;

  const GradientText(this.text, {super.key, this.fontSize = 30, this.fontWeight = FontWeight.w600});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return const LinearGradient(
          colors: [
            Colors.orange,
            Colors.pink,
          ],
        ).createShader(bounds);
      },
      child: Text(
        text,
        style: GoogleFonts.kaushanScript(
          textStyle: Theme.of(context).textTheme.bodySmall,
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: Colors.white,
        ),
      ),
    );
  }
}

class AnimatedGradientText extends StatelessWidget {
  final String text;

  const AnimatedGradientText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: [
        TypewriterAnimatedText(
          text,
          textStyle: const TextStyle(
            fontSize: 37,
            fontWeight: FontWeight.bold,
            color: Colors.transparent, // Set to transparent
          ),
          speed: const Duration(milliseconds: 100),
        ),
      ],
      isRepeatingAnimation: true,
      onFinished: () => print("Animation Complete"),
    );
  }
}