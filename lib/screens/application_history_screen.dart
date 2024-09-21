import 'package:flutter/material.dart';
import 'package:pop_up_the_local/style/theme.dart';

class ApplicationHistoryScreen extends StatelessWidget {
  const ApplicationHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorTheme.background,
      ),
      child: Center(
        child: Text(
          'Application History Screen',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
    );
  }
}
