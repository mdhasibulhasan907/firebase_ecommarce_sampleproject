import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ecommerce/screens/home_screen.dart';
import 'package:firebase_ecommerce/screens/navbar/nav_bar.dart';
import 'package:firebase_ecommerce/utils/colors.dart';
import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

TextEditingController emailController = TextEditingController();
TextEditingController deliveryAddressController = TextEditingController();

void placeOrder(BuildContext context) async {
  final user = await FirebaseAuth.instance.currentUser;
  if (user == null) return;

  final CartSnapshot = await FirebaseFirestore.instance
      .collection("cart")
      .doc(user!.uid)
      .collection("items")
      .get();
  List<Map<String, dynamic>> item = CartSnapshot.docs.map((value) {
    return {
      "id": value.id,
      "title": value["title"],
      "price": value["price"],
      "quantity": value["quantity"],
    };
  }).toList();

  final order = {
    "UserId": user.uid,
    "item": item,
    "dAddress": deliveryAddressController.text.trim(),
    "email": emailController.text.trim(),
    "status": "pending",
    "time": FieldValue.serverTimestamp(),
  };

  await FirebaseFirestore.instance.collection("orders")
  .add(order);

  for(var doc in CartSnapshot.docs){
    await doc.reference.delete();
  }
  Navigator.push(
    context,
     MaterialPageRoute(builder: (_)=>NavBar() )
     );
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: Colors.white.withOpacity(0.7),
        //AllColors().primarycolor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          Text(
            "Please fillup for order",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          //Email Filed
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                hint: Text("Enter Your Email"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),

          SizedBox(height: 10),

          //Delivery Address Filed
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: TextField(
              controller: deliveryAddressController,
             
              decoration: InputDecoration(
                hint: Text("Enter Your Delivery Address"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              placeOrder(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AllColors().primarycolor,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 80),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
            ),
            child: Text('palace order'),
          ),
        ],
      ),
    );
  }
}
