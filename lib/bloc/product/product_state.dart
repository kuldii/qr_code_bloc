part of 'product_bloc.dart';

abstract class ProductState {}

// state / kondisi product
// 1. Product awal -> masih kosong
// 2. Product loading ...
// 3. Product complete -> ketika sudah berhasil mendapatkan data dari database
// 4. Product error -> ketika gagal mendapatkan data dari database

class ProductStateInitial extends ProductState {}

class ProductStateLoading extends ProductState {}

class ProductStateCompleteEdit extends ProductState {}

class ProductStateCompleteDelete extends ProductState {}

class ProductStateCompleteAdd extends ProductState {}

class ProductStateError extends ProductState {
  ProductStateError(this.message);

  final String message;
}
