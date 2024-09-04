import 'package:flutter/material.dart';
import 'package:travel_hotel_booking/constants/constants.dart';

class CustomPass extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType keyboardType;
  final double borderRadius;
  final Color borderColor;
  final Color labelColor;

  CustomPass({
    required this.controller,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.borderRadius = 14.0,
    this.borderColor = AppConstants.borderColor,
    this.labelColor = AppConstants.labelColor,
  });

  @override
  _CustomPassState createState() => _CustomPassState();
}

class _CustomPassState extends State<CustomPass> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .9,
      height: 55,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            obscureText: _obscureText,
            decoration: InputDecoration(
              labelText: widget.label,
              labelStyle: AppConstants.textField,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: BorderSide(color: widget.borderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: BorderSide(color: widget.borderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: BorderSide(color: widget.borderColor, width: 1.0),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}