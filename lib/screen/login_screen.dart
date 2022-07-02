import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:public_transport_tracking/main.dart';
import 'package:public_transport_tracking/screen/fgpass_screen.dart';
import 'package:public_transport_tracking/screen/profile_screen.dart';
import 'package:public_transport_tracking/screen/register_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

  Future logIn() async {
    var errorMessage;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => LoadingCircle());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
      errorMessage = e.message;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage),
        backgroundColor: Colors.redAccent,
      ));
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromRGBO(47, 145, 251, 1),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(90)),
                color: Color.fromRGBO(225, 245, 254, 1),
              ),
            ),
            Center(
              child: SizedBox(
                width: 320,
                child: Column(
                  children: [
                    const SizedBox(width: 1, height: 140),
                    Text('LOGIN',
                        style: GoogleFonts.itim(
                            fontSize: 50,
                            color: Colors.white,
                            textStyle: Theme.of(context).textTheme.headline4)),
                    const SizedBox(width: 1, height: 76),
                    _inputfield(emailController, false, Colors.white, 'Email',
                        const TextStyle(color: Colors.white)),
                    const SizedBox(width: 1, height: 20),
                    _inputfield(passwordController, true, Colors.white,
                        'Password', const TextStyle(color: Colors.white)),
                    const SizedBox(width: 1, height: 46),
                    _textButton('LOGIN', logIn),
                    const SizedBox(width: 1, height: 14),
                    TextButton(
                        onPressed: () {},
                        child: InkWell(
                          onTap: (() => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => ForgotPassword()))),
                          child: const Text(
                            'Forgot Password',
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                    RichText(
                      text: TextSpan(
                          style: const TextStyle(color: Colors.white),
                          children: [
                            const TextSpan(text: 'Do not have an account?  '),
                            TextSpan(
                                text: 'Sign up',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterPage()));
                                  },
                                style: const TextStyle(
                                  decoration: TextDecoration.underline,
                                )),
                          ]),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _textButton(String _text, VoidCallback pressed) {
    return TextButton(
      onPressed: pressed,
      style: ButtonStyle(
          fixedSize: MaterialStateProperty.all(const Size(320, 50)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          backgroundColor: MaterialStateProperty.all(Colors.white)),
      child: Text(
        _text,
        style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 22,
            color: Color.fromRGBO(13, 71, 161, 1)),
      ),
    );
  }

  Widget _inputfield(TextEditingController controller, bool isObscure,
      Color txtcolor, String label, TextStyle labelStyle) {
    return TextField(
      controller: controller,
      cursorColor: txtcolor,
      obscureText: isObscure,
      style: TextStyle(color: txtcolor),
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(5),
          labelText: label,
          labelStyle: labelStyle,
          floatingLabelStyle: labelStyle,
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
          )),
    );
  }
}
