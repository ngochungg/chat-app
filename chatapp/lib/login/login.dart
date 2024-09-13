import 'package:chatapp/signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../auth/auth.dart';
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
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LoginWidget()
            ]
          ),
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

class FieldTextWidget extends StatefulWidget {
  const FieldTextWidget({super.key});

  @override
  State<FieldTextWidget> createState() => FieldTextState();
}

class FieldTextState extends State<FieldTextWidget> {

  // Initially password is obscure
  bool _isObscure = true;

  //Field check
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _inputController2 = TextEditingController();

  //show/hide password btn
  bool enable = false;

  //check login
  bool isLogin = true;

  //errorMessage
  String? errorMessage = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _inputController.dispose();
    _inputController2.dispose();
    super.dispose();
  }

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: _inputController.text, 
        password: _inputController2.text
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    bool _isKeyboard = MediaQuery.of(context).viewInsets.bottom == 0;
  
    return Column(
      children: [
        Visibility(
          visible: !_isKeyboard,
          maintainAnimation: true,
          maintainState: true,
          replacement: const SizedBox.shrink(),
          child: const Padding(
            padding: EdgeInsets.only(top: 120.0),
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
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: SizedBox(
            width: 343.0,
            height: 50.0,
            child: TextFormField(
              controller: _inputController,
              validator: (val) {
                if (val!.isEmpty) {
                  return 'Enter your Email address';
                } else if (!RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(val)) {
                  return 'Enter a Valid Email address';
                } else {
                  return null;
                }
              },
              onChanged: (data) {
                if(_inputController.text.isEmpty ||
                    _inputController2.text.isEmpty) {
                      enable = false;
                    } else {
                      enable = true;
                    }
                    setState(() {});
              },
              decoration: const InputDecoration(
                filled: true,
                fillColor: BoxFill,
                border: OutlineInputBorder(),
                hintText: 'Email',
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
              obscureText: _isObscure,
              enableSuggestions: false,
              autocorrect: false,
              controller: _inputController2,
              onChanged: (data) {
                if(_inputController.text.isEmpty ||
                    _inputController2.text.isEmpty ||
                    _inputController2.text.length < 6) {
                      enable = false;
                    } else {
                      enable = true;
                    }
                    setState(() {});
              },
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Password',
                suffix: TextButton(
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                   }, 
                  child: Text(
                    _isObscure 
                  ? 'Show' 
                  : 'Hide',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Primary,
                    fontFamily: 'Inter',
                    fontSize: 16.0,
                  ),),
                )
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: SizedBox(
            width: 343.0,
            height: 48,
            child: ElevatedButton(
              onPressed: enable ? () {} : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: BlueBtn
              ),
              child: Text(
                'Login',
                style: TextStyle(
                  fontFamily: 'Inter-Bold',
                  fontSize: 16.0,
                  color: enable ? Colors.white : LightGrey
                ),
              ),
            )
          ),
        ),
        SizedBox(
          width: 343.0,
          height: 48,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => const SignUpPage())
                );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: GreyBtn
            ),
            child: const Text(
              'Create new account',
              style: TextStyle(
                fontFamily: 'Inter-Bold',
                fontSize: 16.0,
                color: Colors.black
              ),
            ),
          )
        ),
        TextButton(
          onPressed: () { }, 
          child: const Text(
            'Forgot your password?',
            style: TextStyle(
              fontFamily: 'Inter-Semibold',
              fontSize: 16.0,
              color: BlueBtn
            ),
          )
        ),
        SizedBox(
          width: 96.0,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(
                  FontAwesomeIcons.facebook,
                  color: FBBlue, 
                  size: 25.0, 
                ),
                onPressed: () {}
              ),
              IconButton(
                icon: const Icon(
                  FontAwesomeIcons.google,
                  color: Colors.red, 
                  size: 25.0, 
                ),
                onPressed: () {}
              ),
            ],
          ),
        )
      ],
    );
  }
}