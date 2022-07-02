import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:public_transport_tracking/screen/profile_screen.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();
  final FirebaseAuth _fbAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestoreDb = FirebaseFirestore.instance;
  final formKey = GlobalKey<FormState>();

  Future resetPass() async {
    var errorMessage;
    try {
      await _fbAuth.sendPasswordResetEmail(email: emailController.text);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Reset Password Link Sent'),
        backgroundColor: Colors.redAccent,
      ));
      Navigator.of(context)
          .pop(MaterialPageRoute(builder: (context) => LoadingCircle()));
    } on FirebaseAuthException catch (e) {
      errorMessage = e.message;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage),
        backgroundColor: Colors.redAccent,
      ));
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Container(
              margin: EdgeInsets.only(top: 40),
              alignment: Alignment.centerRight,
              width: MediaQuery.of(context).size.width,
              child: IconButton(
                  iconSize: 42,
                  color: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pop(MaterialPageRoute(
                        builder: (context) => ForgotPassword()));
                  },
                  icon: Icon(Icons.close)),
            ),
            Center(
              child: SizedBox(
                width: 320,
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const SizedBox(width: 1, height: 140),
                      Text('Forgot Password',
                          style: GoogleFonts.itim(
                              fontSize: 43,
                              color: Colors.white,
                              textStyle:
                                  Theme.of(context).textTheme.headline4)),
                      const SizedBox(width: 1, height: 65),
                      const Text(
                          'Please enter the email address for your account. We will send you an email on how to reset it',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          )),
                      const SizedBox(width: 1, height: 30),
                      _inputfield(emailController, false, Colors.white, 'Email',
                          const TextStyle(color: Colors.white)),
                      const SizedBox(width: 1, height: 36),
                      _textButton('Reset Password', resetPass),
                    ],
                  ),
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
    return TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
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
          ),
        ),
        validator: (email) {
          email != null && EmailValidator.validate(email)
              ? 'Enter a valid email'
              : null;
        });
  }
}
