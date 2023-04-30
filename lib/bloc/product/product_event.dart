part of 'product_bloc.dart';

abstract class ProductEvent {}

// aksi / tindakan
// 1. Add product
// 2. Edit product
// 3. Hapus product

class ProductEventAddProduct extends ProductEvent {
  ProductEventAddProduct({required this.code, required this.name, required this.qty});

  final String code;
  final String name;
  final int qty;
}

class ProductEventEditProduct extends ProductEvent {}

class ProductEventDeleteProduct extends ProductEvent {}
