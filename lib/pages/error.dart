import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ERROR PAGE"),
      ),
      body: const Center(
        child: Text("ERROR PAGE"),
      ),
    );
  }
}
