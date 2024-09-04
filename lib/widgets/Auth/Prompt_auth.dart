import 'package:flutter/material.dart';
import 'package:travel_hotel_booking/constants/Constants.dart';

class AuthPrompt extends StatelessWidget {
  final VoidCallback onAuth;
  final String promttext;
  final String clicktext;

  AuthPrompt({required this.onAuth, required this.clicktext, required this.promttext});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              promttext,
              style: AppConstants.textField,
            ),
            SizedBox(width: 5),
            GestureDetector(
              onTap: onAuth,
              child: Text(
                clicktext,
                style: AppConstants.textHightlight
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          'Or connect',
          style: AppConstants.textField,
        ),
        SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _socialIcon('assets/icons/facebook_icon.png'),
            SizedBox(width: 20),
            _socialIcon('assets/icons/instagram_icon.png'), 
            SizedBox(width: 20),
            _socialIcon('assets/icons/twitter_icon.png'),
          ],
        ),
      ],
    );
  }

  Widget _socialIcon(String assetPath) {
    return ClipOval(
      child: Material(
        child: InkWell(
          onTap: () {},
          child: Image.asset(
            assetPath,
            width: 44,
            height: 44,
          ),
        ),
      ),
    );
  }
}