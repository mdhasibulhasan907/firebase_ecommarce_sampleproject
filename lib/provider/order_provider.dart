import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderProvider with ChangeNotifier {
  final FirebaseFirestore _dbOrder = FirebaseFirestore.instance;

  List<Map<String, dynamic>> _orderItems = [];

  List<Map<String, dynamic>> get orderItems => _orderItems;

  Future<void> fatchOrder() async {
    try {
      final snapshot = await _dbOrder.collection("orders").get();

      _orderItems = snapshot.docs.map((item) {
        return {
          "id": item.id,
          ...item.data(), // ডকুমেন্টের সমস্ত ফিল্ড নিয়ে আসছে
        };
      }).toList();

      notifyListeners(); // UI রিফ্রেশের জন্য
    } catch (e) {
      print("Fetch order error: $e");
    }
  }
}
