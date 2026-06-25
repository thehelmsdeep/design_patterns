import 'package:design_patterns/behavioral/observer/pattern.dart';
import 'package:flutter/material.dart';


class Order {
  final String id;
  final double total;

  Order({
    required this.id,
    required this.total,
  });
}

class OrderEvent {
  final Order order;

  OrderEvent(this.order);
}





class OrderController {
  final Observable<OrderEvent?> orderEvents =
  Observable<OrderEvent?>(null);

  int _counter = 100;

  void placeOrder() {
    _counter++;

    final order = Order(
      id: "A$_counter",
      total: 50 + (_counter * 2).toDouble(),
    );

    orderEvents.setValue(
      OrderEvent(order),
    );
  }
}






class InventoryService {
  int burgers = 20;
  int fries = 20;
  int cola = 20;

  InventoryService(
      Observable<OrderEvent?> observable,
      ) {
    observable.subscribe((event) {
      if (event == null) return;

      burgers--;

      fries--;

      cola--;

      if (burgers < 0) burgers = 20;
      if (fries < 0) fries = 20;
      if (cola < 0) cola = 20;
    });
  }
}




class AnalyticsService {
  int totalOrders = 0;

  double revenue = 0;

  AnalyticsService(
      Observable<OrderEvent?> observable,
      ) {
    observable.subscribe((event) {
      if (event == null) return;

      totalOrders++;

      revenue += event.order.total;
    });
  }
}





class DeliveryService {
  final List<String> drivers = [
    "Ashkan",
    "Sara",
    "Reza",
    "Amir",
  ];

  String currentDriver = "-";

  int _index = 0;

  DeliveryService(
      Observable<OrderEvent?> observable,
      ) {
    observable.subscribe((event) {
      if (event == null) return;

      currentDriver =
      drivers[_index % drivers.length];

      _index++;
    });
  }
}





class NotificationService {
  String latestMessage =
      "Waiting for orders...";

  NotificationService(
      Observable<OrderEvent?> observable,
      ) {
    observable.subscribe((event) {
      if (event == null) return;

      latestMessage =
      "✅ ${event.order.id} received successfully";
    });
  }
}





class ActivityService {
  final List<String> logs = [];

  ActivityService(
      Observable<OrderEvent?> observable,
      ) {
    observable.subscribe((event) {
      if (event == null) return;

      final now = DateTime.now();

      final time =
          "${now.hour}:${now.minute}";

      logs.insert(
        0,
        "$time → Notification sent",
      );

      logs.insert(
        0,
        "$time → Driver assigned",
      );

      logs.insert(
        0,
        "$time → Inventory updated",
      );

      logs.insert(
        0,
        "$time → Order ${event.order.id}",
      );
    });
  }
}





final navigatorKey =
GlobalKey<NavigatorState>();








class ObserverDashboard
    extends StatefulWidget {
  final String category;
  final String subCategory;
  const ObserverDashboard({super.key,required this.category,required this.subCategory});


  @override
  State<ObserverDashboard> createState() =>
      _ObserverDashboardState();
}

class _ObserverDashboardState
    extends State<ObserverDashboard> {
  late final OrderController controller;

  late final InventoryService inventory;

  late final AnalyticsService analytics;

  late final DeliveryService delivery;

  late final NotificationService notification;

  late final ActivityService activity;

  final List<Order> orders = [];

  @override
  void initState() {
    super.initState();

    controller = OrderController();

    inventory =
        InventoryService(controller.orderEvents);

    analytics =
        AnalyticsService(controller.orderEvents);

    delivery =
        DeliveryService(controller.orderEvents);

    notification = NotificationService(
      controller.orderEvents,
    );

    activity =
        ActivityService(controller.orderEvents);

    controller.orderEvents.subscribe((event) {
      if (event == null) return;

      setState(() {
        orders.insert(
          0,
          event.order,
        );
      });
    });
  }

  Widget panel(
      String title,
      Widget child,
      ) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight:
                FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      const Color(0xffF5F6FA),

      appBar: AppBar(
        centerTitle: true,
          title:  Text('${widget.category} / ${widget.subCategory}',style: TextStyle(fontSize: 15),),
      ),

      floatingActionButton:
      FloatingActionButton.extended(
        onPressed: () {
          controller.placeOrder();
        },
        icon: const Icon(
          Icons.add_shopping_cart,
        ),
        label: const Text(
          "Place Order",
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Card(
              color:
              Colors.green.shade50,
              child: Padding(
                padding:
                const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(
                      Icons.notifications,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        notification
                            .latestMessage,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [
                  /// Orders
                  panel(
                    "🍔 Orders",
                    ListView.builder(
                      itemCount:
                      orders.length,
                      itemBuilder:
                          (_, index) {
                        final order =
                        orders[index];

                        return ListTile(
                          dense: true,
                          leading:
                          const Icon(
                            Icons.fastfood,
                          ),
                          title: Text(
                            order.id,
                          ),
                          subtitle:
                          Text(
                            "\$${order.total.toStringAsFixed(0)}",
                          ),
                        );
                      },
                    ),
                  ),

                  /// Inventory
                  panel(
                    "📦 Inventory",
                    Column(
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                      children: [
                        Text(
                          "Burger : ${inventory.burgers}",
                        ),
                        const SizedBox(
                            height: 10),
                        Text(
                          "Fries : ${inventory.fries}",
                        ),
                        const SizedBox(
                            height: 10),
                        Text(
                          "Cola : ${inventory.cola}",
                        ),
                      ],
                    ),
                  ),

                  /// Analytics
                  panel(
                    "📈 Analytics",
                    Column(
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                      children: [
                        Text(
                          "Orders : ${analytics.totalOrders}",
                        ),
                        const SizedBox(
                            height: 10),
                        Text(
                          "Revenue : \$${analytics.revenue.toStringAsFixed(0)}",
                        ),
                      ],
                    ),
                  ),

                  /// Delivery
                  panel(
                    "🛵 Delivery",
                    Column(
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                      children: [
                        const Text(
                          "Current Driver",
                        ),
                        const SizedBox(
                            height: 10),
                        Text(
                          delivery
                              .currentDriver,
                          style:
                          const TextStyle(
                            fontSize: 22,
                            fontWeight:
                            FontWeight
                                .bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// Activity Feed
                  panel(
                    "📝 Activity Feed",
                    ListView.builder(
                      itemCount: activity
                          .logs.length,
                      itemBuilder:
                          (_, index) {
                        return Padding(
                          padding:
                          const EdgeInsets
                              .symmetric(
                            vertical: 4,
                          ),
                          child: Text(
                            activity
                                .logs[index],
                          ),
                        );
                      },
                    ),
                  ),


                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}