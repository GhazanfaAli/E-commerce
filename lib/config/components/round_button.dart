import 'package:flutter/material.dart';

class RoundButton extends StatefulWidget {
  final String title;
  final VoidCallback onPress;
  final double height, width;
  final bool loading;
  final Gradient? gradient;
  final Color? color;

  const RoundButton({
    super.key,
    required this.title,
    required this.onPress,
    required this.height,
    required this.width,
    this.loading = false,
    this.gradient,
    this.color,
  });

  @override
  State<RoundButton> createState() => _RoundButtonState();
}

class _RoundButtonState extends State<RoundButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: widget.loading ? null : widget.onPress,
      child: ScaleTransition(
        scale: _animation,
        child: Container(
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
            gradient: widget.gradient,
            color: widget.color ?? const Color.fromARGB(255, 0, 132, 255),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Center(
            child: widget.loading
                ? const CircularProgressIndicator(
              color: Colors.black,
            )
                : Text(
              widget.title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 21,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
