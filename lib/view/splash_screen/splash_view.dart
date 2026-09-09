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
              CircularProgressIndicator(
                padding: EdgeInsets.only(bottom: 12),
                strokeWidth: 6,
                color: Colors.blueAccent,
                backgroundColor: Colors.blueGrey[100],
              ),
              Text(
                'Carregando...',
                style: TextStyle(fontWeight: .w600, color: Colors.blueGrey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
