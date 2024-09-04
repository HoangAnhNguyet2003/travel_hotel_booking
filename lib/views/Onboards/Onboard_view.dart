import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travel_hotel_booking/models/Onboard_model/Onboard_items.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_hotel_booking/views/Auths/SignIn_view.dart';
import 'package:travel_hotel_booking/widgets/Custom/Custom_button.dart';

class OnboardView extends StatefulWidget {
  const OnboardView({super.key});

  @override
  State<OnboardView> createState() => _OnboardViewState();
}

class _OnboardViewState extends State<OnboardView> {
  final controller = OnboardItems();
  final pageController = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: controller.items.length,
              controller: pageController,
              onPageChanged: (index) {
                setState(() {
                  isLastPage = index == controller.items.length - 1;
                });
              },
              itemBuilder: (BuildContext context, int index) {
                return SingleChildScrollView( 
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        child: Image.asset(
                          controller.items[index].image,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 2,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          children: [
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: controller.items[index].title
                                        .substring(0, controller.items[index].title.lastIndexOf(' ')),
                                    style: GoogleFonts.abhayaLibre(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' ' + controller.items[index].title.split(' ').last,
                                    style: GoogleFonts.abhayaLibre(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(255, 112, 41, 1),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              controller.items[index].descriptions,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.anticSlab(
                                fontSize: 18,
                                color: Color.fromRGBO(125, 132, 141, 1),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SmoothPageIndicator(
            controller: pageController,
            count: controller.items.length,
            onDotClicked: (index) => pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
            ),
            effect: WormEffect(
              activeDotColor: Color.fromRGBO(255, 112, 41, 1),
              dotHeight: 10,
              dotWidth: 10,
            ),
          ),
          const SizedBox(height: 25),
          BottomSheet(
            onClosing: () {},
            builder: (context) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    isLastPage ? getStarted() : CustomButton(
                      title: 'Next',
                      onPressed: () => pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget getStarted() {
    return CustomButton(
      title: "Get started",
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignInView()),
        );
      },
    );
  }
}