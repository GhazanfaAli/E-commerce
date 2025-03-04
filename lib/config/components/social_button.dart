import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialButton extends StatelessWidget {
  final IconData icon;
  final String url;

  const SocialButton({super.key, required this.icon, required this.url});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        launchUrl(
          Uri.parse(url),
          mode: LaunchMode.inAppWebView,
        );
      },
      child: Icon(
        icon,
        color: Colors.black,
        size: 28,
      ),
    );
  }
}