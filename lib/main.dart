// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:public_transport_tracking/screen/home_screen.dart';
import 'package:public_transport_tracking/screen/list_screen.dart';
import 'package:public_transport_tracking/screen/profile_screen.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.light,
      theme: FlexThemeData.light(
        colors: const FlexSchemeColor(
          primary: Color(0xff2f91fb),
          primaryContainer: Color(0xff90caf9),
          secondary: Color(0xff039be5),
          secondaryContainer: Color(0xffcbe6ff),
          tertiary: Color(0xff0277bd),
          tertiaryContainer: Color(0xffbedcff),
          appBarColor: Color(0xffcbe6ff),
          error: Color(0xffb00020),
        ),
        surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
        blendLevel: 20,
        appBarOpacity: 1.0,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 20,
          blendOnColors: false,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        // To use the playground font, add GoogleFonts package and uncomment
        // fontFamily: GoogleFonts.notoSans().fontFamily,
      ),
      darkTheme: FlexThemeData.dark(
        colors: const FlexSchemeColor(
          primary: Color(0xff90caf9),
          primaryContainer: Color(0xff0d47a1),
          secondary: Color(0xff81d4fa),
          secondaryContainer: Color(0xff004b73),
          tertiary: Color(0xffe1f5fe),
          tertiaryContainer: Color(0xff1a567d),
          appBarColor: Color(0xff004b73),
          error: Color(0xffcf6679),
        ),
        surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
        blendLevel: 15,
        appBarStyle: FlexAppBarStyle.background,
        appBarOpacity: 0.90,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 30,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        // To use the playground font, add GoogleFonts package and uncomment
        // fontFamily: GoogleFonts.notoSans().fontFamily,
      ),
      home: const BottomNavigation(),
    );
  }
}

class BottomNavigation extends ConsumerStatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  ConsumerState<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends ConsumerState<BottomNavigation> {
  int _index = 0;

  final screen = [const HomePage(), const ListPage(), const ProfilePage()];

  @override
  Widget build(BuildContext context) {
    final _drawerState = ref.watch(drawerProvider);
    return Scaffold(
      body: screen[_index],
      bottomNavigationBar: Visibility(
        visible: !_drawerState,
        child: NavigationBar(
          selectedIndex: _index,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.list_alt),
              label: 'Jadwal',
            ),
            NavigationDestination(
              icon: Icon(Icons.person),
              label: 'Profil',
            ),
          ],
          onDestinationSelected: (int selectedIndex) {
            setState(() {
              _index = selectedIndex;
            });
          },
        ),
      ),
    );
  }
}
