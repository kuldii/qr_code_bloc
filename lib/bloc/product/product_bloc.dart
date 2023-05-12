import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qrcode/models/product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Product>> streamProducts() async* {
    yield* firestore
        .collection("products")
        .withConverter<Product>(
          fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()!),
          toFirestore: (product, _) => product.toJson(),
        )
        .snapshots();
  }

  ProductBloc() : super(ProductStateInitial()) {
    on<ProductEventAddProduct>((event, emit) async {
      try {
        emit(ProductStateLoading());
        // Menambahkan product ke firebase
        var hasil = await firestore.collection("products").add({
          "name": event.name,
          "code": event.code,
          "qty": event.qty,
        });

        await firestore.collection("products").doc(hasil.id).update({"productId": hasil.id});
        emit(ProductStateCompleteAdd());
      } on FirebaseException catch (e) {
        emit(ProductStateError(e.message ?? "Tidak dapat menambah product"));
      } catch (e) {
        emit(ProductStateError("Tidak dapat menambah product"));
      }
    });
    on<ProductEventEditProduct>((event, emit) async {
      try {
        emit(ProductStateLoading());
        // Mengedit product ke firebase
        await firestore.collection("products").doc(event.productId).update({
          "name": event.name,
          "qty": event.qty,
        });

        emit(ProductStateCompleteEdit());
      } on FirebaseException catch (e) {
        emit(ProductStateError(e.message ?? "Tidak dapat menambah product"));
      } catch (e) {
        emit(ProductStateError("Tidak dapat menambah product"));
      }
    });
    on<ProductEventDeleteProduct>((event, emit) async {
      try {
        emit(ProductStateLoading());
        // Menghapus product ke firebase
        await firestore.collection("products").doc(event.id).delete();
        emit(ProductStateCompleteDelete());
      } on FirebaseException catch (e) {
        emit(ProductStateError(e.message ?? "Tidak dapat menghapus product"));
      } catch (e) {
        emit(ProductStateError("Tidak dapat menghapus product"));
      }
    });
  }
}
