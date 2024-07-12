import 'package:carousel_slider/carousel_slider.dart';
import 'package:chatapp/login/login.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'Common/Colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'ChatApp',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: BoxFill,
          hintStyle: const TextStyle(color: Hint),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Primary)),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: BorderBox),
            borderRadius: BorderRadius.circular(12)),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red)),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Primary)),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _currentIndex = 0;

  final List<Widget> _images = [
    Image.asset('assets/images/welcome1.jpg'),
    Image.asset('assets/images/welcome2.jpg'),
    Image.asset('assets/images/welcome3.jpg'),
    Image.asset('assets/images/welcome4.jpg'),
  ];

  final List<Widget> _text = [
    const Text(
      'Welcome to our chat app!',
      style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'Inter-Semibold'
            ),
    ),
    const Text(
      'Talking with your friend,',
      style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'Inter-Semibold'
            ),
    ),
    const Text(
      'Stay connect!',
      style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'Inter-Semibold'
            ),
    ),
    const Text(
      'Anytime and anywhere.',
      style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'Inter-Semibold'
            ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:[
          const Spacer(),
          const SizedBox(height: 40.0),
          _carouselSlider(_images, 306.0),
          const SizedBox(height: 5.0),
          DotsIndicator(
            dotsCount: _images.length,
            position: _currentIndex,
            decorator: const DotsDecorator(
              activeColor: Primary,
              color: D9D9D9,
              size: Size.square(12.0),
              activeSize: Size.square(12.0),
              spacing: EdgeInsets.all(8.0)
            ),
          ),
          const SizedBox(height: 35.0),
          _carouselSlider(_text, 30.0),
          const SizedBox(height: 200.0),
          SizedBox(
            width: 221.0,
            height: 51.0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: BlueBtn,
              ),
              child: const Text(
                'Get start →', 
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => const LoginPage())
                );
              },
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  CarouselSlider _carouselSlider(items, height) {
    return CarouselSlider(
      items: items, 
      options: CarouselOptions(
        disableCenter: false,
        viewportFraction: 0.8,
        enlargeCenterPage: true,
        autoPlay: true,
        height: height,
        onPageChanged: (index, reason) {
          _currentIndex = index;
          setState(() {});
        }
      ),
    );
  }

}
