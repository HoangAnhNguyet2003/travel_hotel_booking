import 'package:flutter/material.dart';
import 'package:travel_hotel_booking/constants/Constants.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  AuthHeader({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: AppConstants.contentPage,
        ),
        SizedBox(height: 10),
        Text(
          subtitle,
          style: AppConstants.textField,
        ),
      ],
    );
  }
}