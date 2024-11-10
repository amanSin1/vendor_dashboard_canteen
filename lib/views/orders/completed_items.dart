import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vendor_digital_canteen/orders/service/order_service.dart';
import 'completed_item.dart';

class CompletedItems extends StatelessWidget {
  final OrderService _orderService = OrderService();

  CompletedItems({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('global_orders')
                    .where('deliveryStatus', isEqualTo: 'Order ready')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
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
                      bool isPickingUp = order['notification'] ==
                          'User is picking up the order!';

                      return CompletedItem(
                        foodTitle: order['foodTitle'],
                        userName: order['userName'] ?? 'Unknown',
                        userPhone: order['userPhone'] ?? 'Not provided',
                        isPickingUp: isPickingUp,
                        onTap: () => isPickingUp
                            ? () {
                                _orderService.updateDeliveryStatus(
                                    order.id, 'Order Delivered');
                                print("done ji");
                              }
                            : null,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
