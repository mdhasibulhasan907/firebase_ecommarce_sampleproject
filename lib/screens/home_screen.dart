import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

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
        ],
      ),
    );
  }
}
