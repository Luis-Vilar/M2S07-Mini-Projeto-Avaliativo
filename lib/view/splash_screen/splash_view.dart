import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: .center,
            children: [
              const CircularProgressIndicator(
                padding: EdgeInsets.only(bottom: 12),
                strokeWidth: 6,
              ),
              Text(
                'Carregando...',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
