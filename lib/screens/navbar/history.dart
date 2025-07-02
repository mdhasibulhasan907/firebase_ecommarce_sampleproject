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

  //total amount 
  double calculateTotalAmount(List<dynamic> items) {
  double total = 0;
  for (var item in items) {
    double price = double.tryParse(item['price'].toString()) ?? 0;
    int quantity = item['quantity'] ?? 1;
    total += price * quantity;
  }
  return total;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        backgroundColor: Colors.white.withOpacity(0.7),
      ),
      body: Consumer<OrderProvider>(
        builder: (context, controller, child) {
          if (controller.orderItems.isEmpty) {
            return const Center(child: Text("No orders found"));
          }
          return ListView.builder(
            itemCount: controller.orderItems.length,
            itemBuilder: (context, index) {
              final order = controller.orderItems[index];
              final items = order['item'];
              final totalAmount = calculateTotalAmount(items); //Total

              return SingleChildScrollView(
                child: Card(
                  elevation: 3,
                  margin: const EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(title: Text("Order ID: ${order['id']}")),
                        ListTile(
                          title:
                              Text("Delivery Address: ${order['dAddress']}"),
                        ),
                        ListTile(title: Text("Email: ${order['email']}")),
                        ListTile(title: Text("Status: ${order['status']}")),
                        const SizedBox(height: 10),
                        const Text(
                          "Ordered Items:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        // 🛒 Ordered items loop
                        for (var item in items)
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
                                const Divider(),
                              ],
                            ),
                          ),

                        // 🧾 Show Total
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Total Amount: \$${totalAmount.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
