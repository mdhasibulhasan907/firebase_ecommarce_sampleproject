import 'package:firebase_ecommerce/provider/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  void initState() {
    super.initState();
    Provider.of<OrderProvider>(context, listen: false).fatchOrder();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histery'),
        backgroundColor: Colors.white.withOpacity(0.7),
        //AllColors().primarycolor,
      ),
      body: Consumer<OrderProvider>(
        builder: (context, controller, child) {
          if (controller.orderItems.isEmpty) {
            return Center(child: Text("No orders found"));
          }
          return ListView.builder(
            itemCount: controller.orderItems.length,
            itemBuilder: (context, index) {
              final order = controller.orderItems[index];
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(title: Text("Order ID: ${order['id']}")),
                    ListTile(
                      title: Text("Delivery Address: ${order['dAddress']}"),
                    ),
                    ListTile(title: Text("Email: ${order['email']}")),
                    ListTile(title: Text("Status: ${order['status']}")),
                    SizedBox(height: 10),
                    Text(
                      "Ordered Items:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // For loop দিয়ে item গুলো দেখানো হচ্ছে
                    for (var item in order['item'])
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Title: ${item['title']}"),
                            Text("Price: \$${item['price']}"),
                            Text("Quantity: ${item['quantity']}"),
                            Text("ID: ${item['id']}"),
                            Divider(), // প্রতিটি পণ্যের শেষে লাইন
                          ],
                        ),
                      ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
