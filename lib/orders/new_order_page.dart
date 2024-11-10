import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vendor_digital_canteen/orders/service/order_service.dart';
import 'package:vendor_digital_canteen/orders/widgets/my_card.dart';

class NewOrderPage extends StatelessWidget {
  final OrderService _orderService = OrderService(); // Instantiate the service

   NewOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Add the AppBar with a menu icon to open the drawer
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        toolbarHeight: 100,
        title: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Orders",
                style: TextStyle(fontSize: 25, color: Colors.black87)),
            Text("Track and Complete Orders",
                style: TextStyle(color: Colors.grey, fontSize: 16)),
          ],
        ),
      ),

      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [            
              const Divider(),
              // Completed Orders section
              SizedBox(
                height: 250,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10,),
                      const Text(
                        "Completed Orders",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      // StreamBuilder to fetch completed orders from Firestore
                      Expanded(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('global_orders')
                              .where('deliveryStatus', isEqualTo: 'Order ready') // Filter for delivered orders
                              .snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator());
                            }
                            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                              return const Center(child: Text("No completed orders"));
                            }

                            final orders = snapshot.data!.docs;

                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: orders.length,
                              itemBuilder: (BuildContext context, int index) {
                                var order = orders[index];

                                bool isPickingUp = order['notification'] == 'User is picking up the order!';

                                return GestureDetector(
                                  onTap: isPickingUp
                                      ? () {
                                    // Define the action for tapping on orders with the notification
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => OrderDetailsPage(orderId: order.id),
                                    //   ),
                                    // );
                                    _orderService.updateDeliveryStatus(order.id, 'Order Delivered');
                                    print("done ji");
                                  }
                                      : null,
                                  child: Container(
                                    width: 100,
                                    margin: EdgeInsets.only(right: 10),
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: isPickingUp ? Colors.green.withOpacity(0.2) : Colors.transparent, // Green if picking up, transparent otherwise
                                      border: Border.all(
                                        color: isPickingUp ? Colors.green : Colors.grey.shade300,
                                        width: isPickingUp ? 3 : 1, // Thicker green border if picking up, default otherwise
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          radius: 30,
                                          backgroundImage: AssetImage('assets/images/pasta_img.png'),
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Text(
                                              order['foodTitle'],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                backgroundColor: Colors.black54,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          order['userName'] ?? 'Unknown', // Default to 'Unknown' if userName is null
                                          style: TextStyle(fontSize: 12),
                                          textAlign: TextAlign.center,
                                        ),
                                        Text(
                                          order['userPhone'] ?? 'Not provided', // Default to 'Not provided' if userPhone is null
                                          style: TextStyle(fontSize: 12),
                                          textAlign: TextAlign.center,
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


                      SizedBox(height: 15,),
                      Text("Pending Orders"),
                      Divider(thickness: 1,),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),

              // Pending Orders section
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('global_orders')
                      .where('deliveryStatus', isEqualTo: 'Pending') // Filter for delivered orders
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(child: Text("No orders found"));
                    }

                    final orders = snapshot.data!.docs;

                    return ListView.builder(
                      itemCount: orders.length,
                      itemBuilder: (BuildContext context, int index) {
                        Map<String, dynamic> order = orders[index].data() as Map<String, dynamic>;
                        final orderId = orders[index].id;

                        return MyCard(
                          order: order,
                          orderId: orderId,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
