import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:qrcode/models/product.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';

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
        emit(ProductStateLoadingAdd());
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
        emit(ProductStateLoadingEdit());
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
        emit(ProductStateLoadingDelete());
        // Menghapus product ke firebase
        await firestore.collection("products").doc(event.id).delete();
        emit(ProductStateCompleteDelete());
      } on FirebaseException catch (e) {
        emit(ProductStateError(e.message ?? "Tidak dapat menghapus product"));
      } catch (e) {
        emit(ProductStateError("Tidak dapat menghapus product"));
      }
    });
    on<ProductEventExportToPdf>((event, emit) async {
      try {
        emit(ProductStateLoadingExport());
        // 1. Ambil semua data product dari firebase
        var querySnap = await firestore
            .collection("products")
            .withConverter<Product>(
              fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()!),
              toFirestore: (product, _) => product.toJson(),
            )
            .get();

        List<Product> allProducts = [];

        for (var element in querySnap.docs) {
          Product product = element.data();
          allProducts.add(product);
        }
        // allProducts -> udah ada isinya, tergantung databasenya

        // 2. Bikin pdfnya (Create PDF) -> taro dimana ? -> penyimpanan local -> lokasi path
        final pdf = pw.Document();

        // TODO: MASUKIN DATA PRODUCTS KE PDF
        var data = await rootBundle.load("assets/fonts/opensans/OpenSans-Regular.ttf");
        var myFont = pw.Font.ttf(data);
        var myStyle = pw.TextStyle(font: myFont);

        pdf.addPage(
          pw.MultiPage(
            pageFormat: PdfPageFormat.a4,
            build: (context) {
              return [
                pw.Text("HELLO", style: myStyle),
              ];
            },
          ),
        );

        // 3. Open pdfnya
        Uint8List bytes = await pdf.save();

        final dir = await getApplicationDocumentsDirectory();
        File file = File("${dir.path}/myproducts.pdf");

        // masukin data bytesnya ke file pdf
        await file.writeAsBytes(bytes);

        await OpenFile.open(file.path);

        print(file.path);

        emit(ProductStateCompleteExport());
      } on FirebaseException catch (e) {
        emit(ProductStateError(e.message ?? "Tidak dapat export product"));
      } catch (e) {
        emit(ProductStateError("Tidak dapat export product"));
      }
    });
  }
}
