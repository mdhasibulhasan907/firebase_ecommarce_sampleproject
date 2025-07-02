import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ecommerce/screens/checkout_screen.dart';
import 'package:firebase_ecommerce/utils/colors.dart';
import 'package:firebase_ecommerce/utils/sizes.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

double calculateTotal(List<QueryDocumentSnapshot> cartItems) {
  double total = 0.0;
  for (var item in cartItems) {
    final price = double.parse(item["price"].toString());
    final quantity = double.parse(item["quantity"].toString());
    total += price * quantity;
  }
  return total;
}

class _CartScreenState extends State<CartScreen> {
  final cartRef = FirebaseFirestore.instance
      .collection("cart")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("items");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        backgroundColor: Colors.white.withOpacity(0.7),
        //AllColors().primarycolor,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: cartRef.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("Your cart is empty"));
          }

          final cartItems = snapshot.data!.docs;
          final totalAmmount = calculateTotal(cartItems);

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final data =
                        cartItems[index].data() as Map<String, dynamic>;

                    return Card(
                      elevation: 3,
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            // Product Image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                height: 100,
                                width: 100,
                                color: Colors.grey[200],
                                child: Image.network(
                                  data["imageUrl"] ?? '',
                                  height: 90,
                                  width: 100,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Center(
                                      child: Icon(
                                        Icons.broken_image,
                                        color: Colors.red,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),

                            // Product Info
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                Text(
                                  data["title"] ?? 'No Title',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 55),
                                Row(
                                  children: [
                                    Text(
                                      "\$${data["price"] ?? 0}",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: AllColors().titleColor,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    const SizedBox(width: 100),
                                    InkWell(
                                      onTap: () {
                                        final quantity = data["quantity"];
                                        if (quantity > 1) {
                                          cartRef
                                              .doc(cartItems[index].id)
                                              .update({
                                                "quantity": quantity - 1,
                                              });
                                        } else {
                                          cartRef
                                              .doc(cartItems[index].id)
                                              .delete();
                                        }
                                      },
                                      child: const Icon(Icons.remove),
                                    ),
                                    Text(
                                      "${data["quantity"] ?? 1}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        cartRef.doc(cartItems[index].id).update(
                                          {"quantity": FieldValue.increment(1)},
                                        );
                                      },
                                      child: const Icon(Icons.add),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        cartRef
                                            .doc(cartItems[index].id)
                                            .delete();
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        size: 16,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ); // Card
                  },
                ),
              ), // Expanded

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Text(
                      "Subtotal: \$${totalAmmount.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => CheckoutScreen()),
                        );
                        
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AllColors().primarycolor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 120),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                      child: Text(
                        'Proceed to Checkout',
                        style: TextStyle(color: AllColors().colorOfAddtocart),
                      ),
                    ),
                  ],
                ),
              ), 
            ],
          ); 
        },
      ), 
    
      //  bottomNavigationBar: Padding(
      //    padding: const EdgeInsets.all(10.0),
      //    child: Column(
      //      children: [
      //       Text("Subtotal:${totalAmmount}"),
      //        ElevatedButton(
      //           onPressed: () async {
      //             // process to checkout
      //             Navigator.push(context, MaterialPageRoute(builder: (_)=>CheckoutScreen()));
      //           },
      //           child: Text(
      //             'Process to checkout',
      //             style: TextStyle(color: AllColors().colorOfAddtocart),
      //           ),
      //           style: ElevatedButton.styleFrom(
      //             backgroundColor: AllColors().primarycolor,
      //             foregroundColor: Colors.white,
      //             padding: EdgeInsets.symmetric(horizontal: 120),
      //             shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.all(Radius.circular(5)),
      //             ),
      //           ),
      //         ),
      //      ],
      //    ),
      //  ),
    );
  }
}
