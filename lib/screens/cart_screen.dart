import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ecommerce/utils/colors.dart';
import 'package:firebase_ecommerce/utils/sizes.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
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

          return ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final data = cartItems[index].data() as Map<String, dynamic>;

              return Card(
                elevation: 3,
                color: Colors.white,
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
                            height: 100,
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Text(
                            data["title"] ?? 'No Title',
                            style: TextStyle(
                              fontSize: 15,
                              //AllSizes().titleSize,
                              color: Colors.black,
                              //AllColors().titleColor,
                            ),
                          ),
                          const SizedBox(height: 55),
                          Row(
                            children: [
                              Text(
                                "\$${data["price"] ?? 0}",
                                style: TextStyle(
                                  fontSize: 18,
                                  //AllSizes().prizeSize,
                                  color: AllColors().titleColor,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              SizedBox(width: 110),
                              InkWell(
                                onTap: (){
                                  final quantity=data["quantity"];
                                  if(quantity>1){
                                    cartRef.doc(cartItems[index].id).update(
                                     { "quantity":quantity-1}
                                    );
                                  }else{
                                    cartRef.doc(cartItems[index].id).delete();
                                  }
                                },
                                child: Icon(Icons.remove)),
                              Text(
                                "${data["quantity"] ?? 1}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  cartRef.doc(cartItems[index].id).update(
                                    {"quantity":FieldValue.increment(1)}
                                  );
                                },
                                child: Icon(Icons.add)),
                              Icon(
                                Icons.delete,
                                size: 20,
                                color: Colors.grey[700],
                              ),
                            ],
                          ),

                          //const SizedBox(height: 5),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
          
        },
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom: 25.0),
        child: ElevatedButton(
          onPressed: () async {
            // Add to cart action
          },
          child: Text(
            'Select Your Payment',
            style: TextStyle(color: AllColors().colorOfAddtocart),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AllColors().primarycolor,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 120),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          ),
        ),
      ),
      
    );
  }
}
