import 'package:flutter/material.dart';
import 'package:travel_hotel_booking/constants/Constants.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const CustomButton({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .9,
      height: 55,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          title,
          style: AppConstants.textButton
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppConstants.buttonColor,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}