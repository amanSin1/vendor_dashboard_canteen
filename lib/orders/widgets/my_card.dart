import 'package:flutter/material.dart';
import 'package:vendor_digital_canteen/utils/constants/colors.dart';
import '../service/order_service.dart';

class MyCard extends StatelessWidget {
  final Map<String, dynamic> order;
  final String orderId;

  final OrderService _orderService = OrderService(); // Instantiate the service

  MyCard({super.key, required this.order, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      height: 150,
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                height: 140,
                width: 105,
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(10), // Set the desired radius here
                  child: Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSs2paowiODEqEOJ082fLEWgrlBjvBlGd2GrQ&s',
                    height: 130, // Define the height of the image
                    width: 100, // Define the width of the image
                    fit: BoxFit.cover, // Ensures the image fills the container
                  ),
                ),
              ),
              const SizedBox(width: 5), // Optional spacing between containers
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 4),
                  height: 140,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            order['foodTitle'],
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            order['userName'],
                            style: const TextStyle(
                              color: Color(0xFF707070),
                              // Remove the '#' and add '0xFF' at the beginning
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Order-ID: ${order['userOrderId']}",
                            style: const TextStyle(
                              color: Color(0xFF707070),
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 40,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10.0)),
                              border: Border.all(),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                _orderService.deleteOrder(
                                  orderId,
                                ); 
                              },
                              child: const Center(
                                child: Icon(
                                  Icons.delete_outline,
                                  size: 20, 
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Flexible(
                            child: GestureDetector(
                              onTap: () async {
                                await Future.wait([
                                  _orderService.updateDeliveryStatus(
                                      orderId, 'Order ready'),
                                  _orderService.updateOrderStatus(
                                      order['userId'],
                                      order['userOrderId'],
                                      'Order is Ready'),
                                ]);
                              },
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                    color: NColors.primary,
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Center(
                                  child: Text("Complete Order",
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
