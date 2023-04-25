import 'package:flutter/material.dart';
import 'package:qrcode/routes/router.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SETTINGS PAGE"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("SETTINGS PAGE"),
            ElevatedButton(
              onPressed: () {
                // GoRouter.of(context).go('/');
                context.goNamed(Routes.home);
              },
              child: const Text("BACK TO HOME"),
            ),
          ],
        ),
      ),
    );
  }
}
