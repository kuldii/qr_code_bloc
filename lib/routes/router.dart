import 'package:go_router/go_router.dart';

import '../pages/home.dart';
import '../pages/settings.dart';
import '../pages/products.dart';
import '../pages/detail_product.dart';
import '../pages/error.dart';

export 'package:go_router/go_router.dart';

part 'route_name.dart';

// GoRouter configuration
final router = GoRouter(
  errorBuilder: (context, state) => const ErrorPage(),
  routes: [
    // KALAU 1 LEVEL -> Push Replacement
    // KALAU SUB LEVEL -> Push (biasa)
    // Prioritas dalam pebuatan GoRoute (Urutan dari atas -> bawah)
    GoRoute(
      path: '/',
      name: Routes.home,
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(
          path: 'products',
          name: Routes.products,
          builder: (context, state) => const ProductsPage(),
          routes: [
            GoRoute(
              path: ':productId',
              name: Routes.detailProduct,
              builder: (context, state) => DetailProductPage(
                state.params['productId'].toString(),
                state.queryParams,
              ),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/settings',
      name: Routes.settings,
      builder: (context, state) => const SettingsPage(),
    ),
  ],
);
