import 'package:flutter/material.dart';
import '../routes/router.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ALL PRODUCTS PAGE"),
      ),
      body: ListView.builder(
        itemCount: 15,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              // Penggunaan Routing Dynamic -> dengan path
              // Kita tidak bisa melempar data dengan path
              // context.go("/products/${index + 1}");
              // Penggunaan Routing Dynamic -> dengan Route Named
              context.goNamed(
                Routes.detailProduct,
                params: {
                  "productId": "${index + 1}",
                },
                queryParams: {
                  "id": "${index + 1}",
                  "title": "PRODUCT ${index + 1}",
                  "deskripsi": "Deskripsi product ${index + 1}",
                },
              );
            },
            leading: CircleAvatar(
              child: Text("${index + 1}"),
            ),
            title: Text("PRODUCT ${index + 1}"),
            subtitle: Text("Deskripsi product ${index + 1}"),
          );
        },
      ),
    );
  }
}
