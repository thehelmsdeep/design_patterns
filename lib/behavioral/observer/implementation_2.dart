import 'package:design_patterns/behavioral/observer/pattern.dart';
import 'package:flutter/material.dart';






class Order {
  final String id;
  final double total;

  Order(this.id, this.total);
}





class OrderController {
  final Observable<Order?> currentOrder =
  Observable<Order?>(null);

  void createOrder(String id, double total) {
    final order = Order(id, total);
    currentOrder.setValue(order);
  }
}





class OrderPage extends StatefulWidget {

  final String category;
  final String subCategory;
  const OrderPage({super.key,required this.category,required this.subCategory});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final controller = OrderController();

  String uiText = "No order yet";
  String inventoryText = "";
  String logText = "";
  String notificationText = "";

  @override
  void initState() {
    super.initState();

    /// ===============================
    /// Listener 1: UI update
    /// ===============================
    controller.currentOrder.subscribe((order) {
      setState(() {
        uiText = "Order: ${order?.id}";
      });
    });

    /// ===============================
    /// Listener 2: Inventory update
    /// ===============================
    controller.currentOrder.subscribe((order) {
      setState(() {
        inventoryText =
        "Stock reduced for ${order?.id}";
      });
    });

    /// ===============================
    /// Listener 3: Logging
    /// ===============================
    controller.currentOrder.subscribe((order) {
      setState(() {
        logText =
        "LOG: order created ${order?.id}";
      });
    });

    /// ===============================
    /// Listener 4: Notification
    /// ===============================
    controller.currentOrder.subscribe((order) {
      setState(() {
        notificationText =
        "Notification sent for ${order?.id}";
      });
    });
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('${widget.category} / ${widget.subCategory}',style: TextStyle(fontSize: 15),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(uiText,
                  style: const TextStyle(fontSize: 18)),

              const SizedBox(height: 10),

              Text(inventoryText),

              const SizedBox(height: 10),

              Text(logText),

              const SizedBox(height: 10),

              Text(notificationText),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: () {
                  controller.createOrder("A123", 250);
                },
                child: const Text("Create Order"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}