import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_hotel_booking/constants/Constants.dart';
import 'package:travel_hotel_booking/models/User/User.dart';
import 'package:travel_hotel_booking/services/api_service.dart';
import 'package:travel_hotel_booking/validators/user_validator.dart';
import 'package:travel_hotel_booking/views/Auths/SignIn_view.dart';
import 'package:travel_hotel_booking/widgets/Auth/Header_auth.dart';
import 'package:travel_hotel_booking/widgets/Auth/Prompt_auth.dart';
import 'package:travel_hotel_booking/widgets/Custom/Custom_button.dart';
import 'package:travel_hotel_booking/widgets/Custom/Custom_passtextfeild.dart';
import 'package:travel_hotel_booking/widgets/Custom/Custom_textfield.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullnameController = TextEditingController();
  final ApiService apiService = ApiService();
  String? errorMessage;

  void signup() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    
    // Kiểm tra tính hợp lệ của email
    String? emailError = UserValidator.validateEmail(email);
    if (emailError != null) {
      setState(() {
        errorMessage = emailError;
      });
      return;
    }

    // Kiểm tra độ dài mật khẩu
    String? passwordError = UserValidator.validatePassword(password);
    if (passwordError != null) {
      setState(() {
        errorMessage = passwordError;
      });
      return;
    }
    final user = User(
      fullname: _fullnameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      
    );
    

    final result = await apiService.signupUser(user);
      if (result != null && result['token'] != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', result['token']);
        await prefs.setString('userId', result['user']['_id']); 

        setState(() {
         errorMessage = 'Registration successful!';
        });
        Future.delayed(Duration(seconds: 2), () {
          _navigateToSignIn();
        });
      } else {
        setState(() {
          errorMessage = result?['message'] ?? 'Unknown error occurred.';
        });
      }
    }

  void _navigateToSignIn() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignInView()),
    );
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
                title: 'Sign up now',
                subtitle: 'Please fill the details and create account'),
              SizedBox(height: 30),
              CustomTextField(
                controller: _fullnameController,
                label: 'Fullname',
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 20),
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
                alignment: Alignment.topLeft,
                child: Text(
                  'Password must be 8 character',
                  style: AppConstants.textField
                )
              ),
              SizedBox(height: 30),
              Column(
                children: [
                  CustomButton(
                    title: 'Sign Up',
                    onPressed: signup),
                  SizedBox(height: 20),
                  if (errorMessage!= null)
                    Text(errorMessage!, style: TextStyle(color: Colors.red)),
                  SizedBox(height: 30),
                  AuthPrompt(
                    onAuth: _navigateToSignIn,
                    clicktext: "Sign in",
                    promttext: "Already have an account")
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}