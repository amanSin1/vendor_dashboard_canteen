import 'package:flutter/material.dart';

class CompletedItem extends StatelessWidget {
  final String foodTitle;
  final String userName;
  final String userPhone;
  final bool isPickingUp;
  final VoidCallback onTap;

  const CompletedItem({
    super.key,
    required this.foodTitle,
    required this.userName,
    required this.userPhone,
    required this.isPickingUp,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          color:
              isPickingUp ? Colors.green.withOpacity(0.2) : Colors.transparent,
          border: Border.all(
            color: isPickingUp ? Colors.green : Colors.grey.shade300,
            width: isPickingUp ? 3 : 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: const AssetImage('assets/images/pasta_img.png'),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  foodTitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    backgroundColor: Colors.black54,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              userName,
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
            Text(
              userPhone,
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
