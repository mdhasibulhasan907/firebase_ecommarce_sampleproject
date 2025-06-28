import 'package:firebase_ecommerce/utils/colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
int _selectedIndex = 0;
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //crossAxisAlignment: CrossAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
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

              Row(
                children: [
                  Icon(Icons.shopping_cart),
                  SizedBox(width: 10.0),
                  Icon(Icons.notifications_none),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey, // আপনি ইচ্ছামতো রং দিতে পারেন
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8), // কোণ গুলো গোল করতে চাইলে
            ),
            child: Row(children: [Icon(Icons.search), Text("search here")]),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
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
                    mainAxisSize: MainAxisSize.min,
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
          SizedBox(height: 10,),
          

        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white, // Background color of bar
        selectedItemColor: AllColors().primarycolor, // Selected icon & label color
        unselectedItemColor: Colors.grey, // Unselected icon color
        currentIndex: _selectedIndex, // Add this in a StatefulWidget
        showUnselectedLabels: true,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },

        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: "Wishlist",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: "Account",
          ),
        ],
      ),
    );
  }
}
