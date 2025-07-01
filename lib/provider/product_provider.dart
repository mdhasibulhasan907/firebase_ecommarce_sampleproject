import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ecommerce/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  final FirebaseFirestore _dbOfProducts = FirebaseFirestore.instance;

  List<ProductModel> _product = [];
  List<ProductModel> get product => _product;

  Future fatchProduct(BuildContext context) async {
    try{
      final snapshot = await _dbOfProducts.collection("products").get();

    _product = snapshot.docs
        .map((value)=>ProductModel.fromJson(value.data()))
        .toList();

        notifyListeners();
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()))
      );
    }
  }
}
