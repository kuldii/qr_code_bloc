import 'package:flutter/material.dart';
import 'package:qrcode/routes/router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HOME PAGE"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // GoRouter.of(context).go('/settings');
                context.goNamed(Routes.settings);
              },
              child: const Text("SETTINGS"),
            ),
            ElevatedButton(
              onPressed: () {
                // GoRouter.of(context).go('/products');
                context.goNamed(Routes.products);
              },
              child: const Text("ALL PRODUCTS"),
            ),
          ],
        ),
      ),
    );
  }
}
