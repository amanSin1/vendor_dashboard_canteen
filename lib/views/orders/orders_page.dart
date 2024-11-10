import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vendor_digital_canteen/orders/widgets/my_card.dart';
import 'package:vendor_digital_canteen/views/orders/completed_items.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(),
              const SizedBox(height: 10),
              Text(
                "Completed Orders",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade500,
                ),
              ),
              const SizedBox(height: 20),
              CompletedItems(),
              const SizedBox(height: 20),
              Text(
                "Pending Orders",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade500,
                ),
              ),
              const Divider(),
              const SizedBox(height: 20,),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('global_orders')
                      .where('deliveryStatus', isEqualTo: 'Pending')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text("No orders found"));
                    }
              
                    final orders = snapshot.data!.docs;
              
                    return ListView.builder(
                      itemCount: orders.length,
                      itemBuilder: (BuildContext context, int index) {
                        Map<String, dynamic> order =
                            orders[index].data() as Map<String, dynamic>;
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
