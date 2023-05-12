import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qrcode/models/product.dart';

import '../pages/home.dart';
import '../pages/products.dart';
import '../pages/detail_product.dart';
import '../pages/add_product.dart';
import '../pages/error.dart';
import '../pages/login.dart';

export 'package:go_router/go_router.dart';

part 'route_name.dart';

// GoRouter configuration
final router = GoRouter(
  redirect: (context, state) {
    FirebaseAuth auth = FirebaseAuth.instance;
    // cek kondisi saat ini -> sedang terautentikasi
    if (auth.currentUser == null) {
      // tidak sedang login / tidak ada user yg aktif saat ini
      return "/login";
    } else {
      return null;
    }
  },
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
                state.extra as Product,
              ),
            ),
          ],
        ),
        GoRoute(
          path: 'add-product',
          name: Routes.addProduct,
          builder: (context, state) => AddProductPage(),
        ),
      ],
    ),
    GoRoute(
      path: '/login',
      name: Routes.login,
      builder: (context, state) => LoginPage(),
    ),
  ],
);
