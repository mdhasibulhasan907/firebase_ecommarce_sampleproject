import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ecommerce/screens/cart_screen.dart';
import 'package:firebase_ecommerce/screens/navbar/profile_screen.dart';
import 'package:firebase_ecommerce/utils/colors.dart';
import 'package:firebase_ecommerce/utils/sizes.dart';

import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:firebase_ecommerce/provider/auth_provider.dart';
import 'package:firebase_ecommerce/provider/product_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

int _selectedIndex = 0;

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ProductProvider>(context, listen: false).fatchProduct(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Delivery address",
                    style: TextStyle(fontSize: 10, color: Color(0xffC8C8CB)),
                  ),
                  Row(
                    children: [
                      Text(
                        "Salatiga City, Central Java",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xff393F42),
                        ),
                      ),
                      Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ],
              ),
              SizedBox(width: 12,),
              Row(
                children: [
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("cart")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection("items")
                        .snapshots(),

                    builder: (context, snapshots) {
                      num totalQuantity = 0;
                      if (snapshots.hasData) {
                        for (var doc in snapshots.data!.docs) {
                          totalQuantity += (doc["quantity"] ?? 1);
                        }
                      }
                      return Stack(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => CartScreen()),
                              );
                            },
                            icon: Icon(Icons.shopping_cart),
                          ),

                          if (totalQuantity > 0)
                            Positioned(
                              right: 6,
                              top: 6,
                              child: Text(
                                "${totalQuantity}",
                                style: TextStyle(
                                  color: const Color.fromARGB(255, 248, 1, 1),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),

                  IconButton(
                    onPressed: () {
                      Provider.of<AuthProvider>(
                        context,
                        listen: false,
                      ).LogOut(context);
                    },
                    icon: Icon(Icons.logout),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.search),
                  SizedBox(width: 10),
                  Text("Search here"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recent product",
                    style: TextStyle(fontSize: 14, color: Color(0xff393F42)),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Text('Filters', style: TextStyle(color: Colors.black)),
                        SizedBox(width: 6),
                        Icon(
                          Icons.filter_alt_outlined,
                          color: Colors.black,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),

            /// Product GridView
            Expanded(
              child: Consumer<ProductProvider>(
                builder: (context, controller, child) {
                  return GridView.builder(
                    itemCount: controller.product.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.65,
                    ),
                    itemBuilder: (context, index) {
                      var data = controller.product[index];
                      print('Image path: ${data.imageUrl!}');
                      return Card(
                        elevation: 3,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  height: 120,
                                  width: double.infinity,
                                  color: Colors.grey[200],
                                  child: Image.network(
                                    data.imageUrl!,

                                    //"assets/images/AestechicMug.jpg",
                                    height: 120,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Center(
                                        child: Icon(
                                          Icons.broken_image,
                                          color: Colors.red,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                '${data.title}',
                                style: TextStyle(
                                  fontSize: AllSizes().titleSize,
                                  color: AllColors().titleColor,
                                  //fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                '\$${data.price}',
                                style: TextStyle(
                                  fontSize: AllSizes().prizeSize,
                                  color: AllColors().priceColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Spacer(),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    // Add to cart action
                                    final user =
                                        FirebaseAuth.instance.currentUser;

                                    final cartRef = await FirebaseFirestore
                                        .instance
                                        .collection("cart")
                                        .doc(user!.uid)
                                        .collection("items")
                                        .doc(data.id);

                                    final cartSnapshot = await cartRef.get();

                                    if (cartSnapshot.exists) {
                                      cartRef.update({
                                        "quantity": FieldValue.increment(1),
                                      });
                                    } else {
                                      cartRef.set({
                                        "id": data.id,
                                        "imageUrl": data.imageUrl,
                                        "title": data.title,
                                        "price": data.price,
                                        "quantity": 1,
                                      });
                                      // masage: Add to cart
                                      Fluttertoast.showToast(
                                        msg: "${data.id} cart id added",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0,
                                      );
                                    }
                                  },
                                  child: Text(
                                    'Add to Cart',
                                    style: TextStyle(
                                      color: AllColors().colorOfAddtocart,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AllColors().primarycolor,
                                    foregroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Colors.white,
      //   selectedItemColor: AllColors().primarycolor,
      //   unselectedItemColor: Colors.grey,
      //   currentIndex: _selectedIndex,
      //   showUnselectedLabels: true,
      //   onTap: (index) {
      //     setState(() {
      //       _selectedIndex = index;
      //     });
      //   },
      //   items: [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.favorite_border),
      //       label: "Wishlist",
      //     ),
      //     BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.account_circle),
      //       label: "Account",
      //     ),
      //   ],
      // ),
    );
  }
}
