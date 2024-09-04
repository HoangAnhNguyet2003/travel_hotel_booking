import 'package:flutter/material.dart';
import 'package:travel_hotel_booking/constants/Constants.dart';
import 'package:travel_hotel_booking/views/Auths/SignUp_view.dart';
import 'package:travel_hotel_booking/views/Home/Home.dart';
import 'package:travel_hotel_booking/widgets/Auth/Header_auth.dart';
import 'package:travel_hotel_booking/widgets/Auth/Prompt_auth.dart';
import 'package:travel_hotel_booking/widgets/Custom/Custom_button.dart';
import 'package:travel_hotel_booking/widgets/Custom/Custom_passtextfeild.dart';
import 'package:travel_hotel_booking/widgets/Custom/Custom_textfield.dart';
import 'package:travel_hotel_booking/services/api_service.dart';
class SignInView extends StatefulWidget {
  const SignInView({super.key});
  
  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ApiService apiService = ApiService();
  String? errorMessage;

  void _navigateToSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpView()),
    );
  }

  void signin() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    final result = await apiService.signinUser(email, password);
    
    if (result != null && result['token'] != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } else {
      setState(() {
        errorMessage = result?['message'] ?? 'Login failed.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              AuthHeader(
                title: 'Sign in now',
                subtitle: 'Please sign in to continue our app'
              ),
              SizedBox(height: 30),
              CustomTextField(
                controller: _emailController,
                label: 'Email',
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 20),
              CustomPass(
                controller: _passwordController,
                label: 'Password',
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 10),
              Container(
                alignment: Alignment.topRight,
                child: Text(
                  'Forget Password?',
                  style: AppConstants.textHightlight
                )
              ),
              SizedBox(height: 30),
              Column(
                children: [
                  CustomButton(
                    title: 'Sign In',
                    onPressed: signin 
                  ),
                  SizedBox(height: 20),
                  if (errorMessage != null)
                    Text(errorMessage!, style: TextStyle(color: Colors.red)),
                  SizedBox(height: 30),
                  AuthPrompt(
                    onAuth: _navigateToSignUp,
                    clicktext: "Sign up",
                    promttext: "Don't have an account?"
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}