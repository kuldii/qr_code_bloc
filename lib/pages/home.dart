import 'package:flutter/material.dart';
import 'package:qrcode/bloc/auth/auth_bloc.dart';
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
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthStateLogout) {
              context.goNamed(Routes.login);
            }
          },
          builder: (context, state) {
            if (state is AuthStateLoading) {
              return const CircularProgressIndicator();
            }
            if (state is AuthStateError) {
              return Text(state.message);
            }
            return Column(
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
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // proses logout
          context.read<AuthBloc>().add(AuthEventLogout());
        },
        child: const Icon(Icons.logout),
      ),
    );
  }
}
