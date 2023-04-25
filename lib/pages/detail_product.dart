import 'package:flutter/material.dart';

class DetailProductPage extends StatelessWidget {
  const DetailProductPage(this.id, this.data, {super.key});

  final String id;

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DETAIL PRODUCT PAGE"),
      ),
      body: Center(
        child: Text(data.toString()),
      ),
    );
  }
}
