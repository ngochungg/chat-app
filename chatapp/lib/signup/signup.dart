import 'package:chatapp/login/login.dart';
import 'package:flutter/material.dart';
import '../Common/Colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../auth/auth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
              SignUpWidget()
            ]
          ),
        ),
      ),
    );
  }
}

class SignUpWidget extends StatelessWidget {
  const SignUpWidget({super.key});

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
                      'Sign up with your email or social account',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22.0,
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
            child: const FieldText()
          )
        ),
      ]
    );
  }
}

class FieldText extends StatefulWidget {
  const FieldText({super.key});

  @override
  State<FieldText> createState() => _FieldTextState();
}

class _FieldTextState extends State<FieldText> {
  // Initially password is obscure
  bool _isObscure = true;
  bool _isObscure2 = true;

  //errorMessage
  String? errorMessage = '';

  //Field check
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _inputController2 = TextEditingController();
  final TextEditingController _inputController3 = TextEditingController();
  final TextEditingController _inputController4 = TextEditingController();
  bool enable = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _inputController.dispose();
    _inputController2.dispose();
    _inputController3.dispose();
    _inputController4.dispose();
    super.dispose();
  }

    Future<void> createUserwithEmailAndPassword() async {
    try {
      await Auth().createUserwithEmailAndPassword(
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
                    'Sign up with your email or social account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22.0,
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
                };
              },
              onChanged: (data) {
                if(_inputController.text.isEmpty ||
                    _inputController2.text.isEmpty ||
                    _inputController3.text.isEmpty ||
                    _inputController4.text.isEmpty) {
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
              validator: (val) {
                if(val!.isEmpty) {
                  return 'Empty';
                } else if (val.length < 8){
                  return "Password must be atleast 8 characters long";
                } else {
                  return null;
                }
              },
              onChanged: (data) {
                if(_inputController.text.isEmpty ||
                    _inputController2.text.isEmpty ||
                    _inputController3.text.isEmpty ||
                    _inputController4.text.isEmpty) {
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
          padding: const EdgeInsets.only(bottom: 24.0),
          child: SizedBox(
            width: 343.0,
            height: 50.0,
            child: TextFormField(
              obscureText: _isObscure2,
              enableSuggestions: false,
              autocorrect: false,
              controller: _inputController3,
              validator: (val) {
                if(val!.isEmpty) {
                  return 'Empty';
                } else if(val != _inputController2.text) {
                  return 'Not match';
                } else if (val.length < 8){
                  return "Password must be atleast 8 characters long";
                } else {
                  return null;
                }
              },
              onChanged: (data) {
                if(_inputController.text.isEmpty ||
                    _inputController2.text.isEmpty ||
                    _inputController3.text.isEmpty ||
                    _inputController4.text.isEmpty) {
                      enable = false;
                    } else {
                      enable = true;
                    }
                    setState(() {});
              },
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Confirm password',
                suffix: TextButton(
                  onPressed: () {
                    setState(() {
                      _isObscure2 = !_isObscure2;
                    });
                   }, 
                  child: Text(
                    _isObscure2 
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
          padding: const EdgeInsets.only(bottom: 24.0),
          child: SizedBox(
            width: 343.0,
            height: 50.0,
            child: TextFormField(
              controller: _inputController4,
              onChanged: (data) {
                if(_inputController.text.isEmpty ||
                    _inputController2.text.isEmpty ||
                    _inputController3.text.isEmpty ||
                    _inputController4.text.isEmpty) {
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
                hintText: 'Name',
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
                'Sign up',
                style: TextStyle(
                  fontFamily: 'Inter-Bold',
                  fontSize: 16.0,
                  color: enable ? Colors.white : LightGrey
                ),
              ),
            )
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage())
            );
          }, 
          child: const Text(
            'Already have account?',
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
        ),
        const SizedBox(
          height: 50.0,
        )
      ],
    );
  }
}