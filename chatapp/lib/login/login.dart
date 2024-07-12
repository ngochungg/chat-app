import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Common/Colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: const Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LoginWidget()
          ]
        ),
      ),
    );
  }
}

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {

    bool _isKeyboard = MediaQuery.of(context).viewInsets.bottom == 0;

    return Column(
      children: [
        Stack(
          children: [
            Visibility(
              visible: _isKeyboard,
              maintainAnimation: true,
              maintainState: true,
              replacement: const SizedBox.shrink(),
              child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.decelerate,
                  opacity: _isKeyboard ? 1 : 0,
                  child: Image.asset('assets/images/logo.png')
              )
            ),
            const Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 259.0,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      'Log in with your email or social account',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontFamily: 'Inter-Semibold'
                      ),
                    ),
                  ),
                )
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.center,
          child: AnimatedPadding(
            padding: MediaQuery.of(context).viewInsets,
            duration: const Duration(milliseconds: 200),
            curve: Curves.decelerate,
            child: const FieldTextWidget()
          )
        ),
      ]
    );
  }
}

class FieldTextWidget extends StatelessWidget {
  const FieldTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: SizedBox(
            width: 343.0,
            height: 50.0,
            child: TextFormField(
              onTap: () => print('box1'),
              decoration: const InputDecoration(
                filled: true,
                fillColor: BoxFill,
                border: OutlineInputBorder(),
                hintText: 'Enter your email',
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: SizedBox(
            width: 343.0,
            height: 50.0,
            child: TextFormField(
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              onTap: () => print('box2'),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Password',
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 16.0),
          child: SizedBox(
            width: 343.0,
            height: 48,
            child: ElevatedButton(
              onPressed: null, 
              child: Text(
                'Login',
                style: TextStyle(
                  fontFamily: 'Inter-Bold',
                  fontSize: 16.0,
                  color: LightGrey
                ),
              ),
            )
          ),
        ),
        const SizedBox(
          width: 343.0,
          height: 48,
          child: ElevatedButton(
            onPressed: null, 
            child: Text(
              'Create new account',
              style: TextStyle(
                fontFamily: 'Inter-Bold',
                fontSize: 16.0,
                color: Colors.black
              ),
            ),
          )
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 16.0),
          child: TextButton(
            onPressed: null, 
            child: Text(
              'Forgot your password?',
              style: TextStyle(
                fontFamily: 'Inter-Semibold',
                fontSize: 16.0,
                color: BlueBtn
              ),
            )
          ),
        ),
        const SizedBox(
          width: 74.0,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(FontAwesomeIcons.facebook, color: FBBlue, size: 25.0),
              Icon(FontAwesomeIcons.google, color: Colors.red, size: 25.0)
            ],
          ),
        )
      ],
    );
  }
}