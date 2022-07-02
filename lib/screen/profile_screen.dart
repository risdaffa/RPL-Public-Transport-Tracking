import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:public_transport_tracking/screen/login_screen.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromRGBO(225, 245, 254, 1),
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              return snapshot.hasData ? ProfileLoggedIn() : const LoginPage();
            } else {
              return LoadingCircle();
            }
          }),
    );
  }
}

class ProfileLoggedIn extends StatelessWidget {
  ProfileLoggedIn({Key? key}) : super(key: key);
  final FirebaseAuth _fbAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromRGBO(225, 245, 254, 1),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                width: 2,
                height: 60,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(180),
                child: SizedBox(
                  width: 155,
                  height: 155,
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://images.squarespace-cdn.com/content/v1/519d1bb9e4b09e4694bff22c/1582149849802-ZC7E0T9PBX3Q9SF7AV23/profile-placeholder.png?format=500w',
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              const SizedBox(width: 2, height: 39),
              _subText('USERNAME'),
              Container(
                alignment: AlignmentDirectional.centerStart,
                width: 265,
                height: 37,
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Text(
                  _fbAuth.currentUser!.displayName.toString(),
                  style: const TextStyle(fontSize: 15),
                ),
              ),
              const SizedBox(width: 2, height: 15),
              _subText('EMAIL'),
              _valueContainer(
                FirebaseAuth.instance.currentUser!.email.toString(),
                const Color.fromRGBO(222, 222, 222, 0.7),
              ),
              const SizedBox(height: 25),
              TextButton(
                onPressed: () {},
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(const Size(265, 55)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    const Color.fromRGBO(9, 128, 42, 1),
                  ),
                ),
                child: Text(
                  'UBAH PROFIL',
                  style: GoogleFonts.bebasNeue(
                      color: Colors.white, fontSize: 28, letterSpacing: 2),
                ),
              ),
              const SizedBox(height: 16),
              _iconTextBtn(
                  'BOOKMARK',
                  28,
                  Icons.share_location,
                  const Size(265, 55),
                  const Color.fromRGBO(13, 71, 161, 1),
                  () {}),
              const SizedBox(height: 100),
              _iconTextBtn('KELUAR', 20, Icons.exit_to_app, const Size(147, 50),
                  const Color.fromRGBO(255, 0, 0, 1), () async {
                await FirebaseAuth.instance.signOut();
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconTextBtn(String label, double fontSize, IconData iconLabel,
      Size btnSize, Color btnColor, VoidCallback btnPressed) {
    return TextButton.icon(
      onPressed: btnPressed,
      label: Text(
        label,
        style: GoogleFonts.bebasNeue(
            color: Colors.white, fontSize: fontSize, letterSpacing: 2),
      ),
      icon: Padding(
        padding: const EdgeInsets.only(right: 2.0),
        child: Icon(
          iconLabel,
          color: Colors.white,
          size: 32,
        ),
      ),
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all(btnSize),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        backgroundColor: MaterialStateProperty.all(
          btnColor,
        ),
      ),
    );
  }

  Widget _subText(String text) {
    return SizedBox(
      width: 245,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 4.0),
        child: Text(
          text,
          textAlign: TextAlign.left,
          style: GoogleFonts.bebasNeue(fontSize: 22),
        ),
      ),
    );
  }

  Widget _valueContainer(String value, Color color) {
    return Container(
      alignment: AlignmentDirectional.centerStart,
      width: 265,
      height: 37,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
      child: Text(
        value,
        style: const TextStyle(fontSize: 15),
      ),
    );
  }
}

class LoadingCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: const Alignment(0.0, 0.0),
        child: const CircularProgressIndicator(),
      ),
    );
  }
}
