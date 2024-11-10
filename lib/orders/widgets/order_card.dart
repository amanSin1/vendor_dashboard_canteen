import 'package:flutter/material.dart';

import '../../button/custom_button.dart';
import '../service/order_service.dart';

class OrderCard extends StatelessWidget {
  final Map<String, dynamic> order;
  final String orderId;
  final OrderService _orderService = OrderService(); // Instantiate the service

   OrderCard({super.key,required this.order, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.all(8),
      height: 210,

      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 130,
                width: 105,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10), // Set the desired radius here
                  child: Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHAMC0Z2G27sK1SKFD1ex2-qqmOW7WLm7kCQ&s',
                    height: 125, // Define the height of the image
                    width: 100,  // Define the width of the image
                    fit: BoxFit.cover, // Ensures the image fills the container
                  ),
                ),
              ),
              SizedBox(width: 5), // Optional spacing between containers
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 4),
                  height: 130,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(order['foodTitle'],style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),),
                      SizedBox(height: 3),
                      Text(
                        "Ordered by: ${order['userName']}",
                        style: TextStyle(
                          color: Color(0xFF707070),
                        ),
                      ),

                      SizedBox(height: 5),
                      Text(
                        "Order-ID: ${order['userOrderId']}",
                        style: TextStyle(
                          color: Color(0xFF707070),
                        ),
                      ),

                      SizedBox(height: 3,),
                      CustomButton(
                        height: 40.0,
                        width: double.infinity,
                        text: "Cancel Order",
                        color: Colors.white70,

                        textColor: Colors.red,
                        borderColor: Colors.red,
                        onPressed: () {
                          _orderService.updateOrderStatus(order['userId'], order['userOrderId'], 'Not Available');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 6,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  _orderService.deleteOrder(orderId);

                  },

                child: Container(
                  width: 105,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: Colors.black87,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.delete_outline, size: 20, color: Colors.white),
                      Text("Delete Order", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ),

              SizedBox(width: 8,),
              Expanded(
                child: CustomButton(
                  height: 45.0,
                  width: double.infinity,
                  text: "Order Complete",
                  color: Colors.redAccent,
                
                  textColor: Colors.white,
                  borderColor: Colors.green,
                  onPressed: () {
                    _orderService.updateOrderStatus(order['userId'], order['userOrderId'], 'Order Delivered');

                  },
                ),
              ),
            ]
          ),
        ],
      ),
      
    );
  }
}
