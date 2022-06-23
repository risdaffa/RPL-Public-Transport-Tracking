import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final drawerProvider = StateProvider<bool>((ref) => false);

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    final _drawerState = ref.watch(drawerProvider);
    return Scaffold(
      onDrawerChanged: (val) {
        if (val) {
          ref.read(drawerProvider.state).state = true;
        } else {
          ref.read(drawerProvider.state).state = false;
        }
      },
      drawer: const NavigationDrawer(),
      appBar: AppBar(
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14.0, top: 14.0),
            child: InkWell(
              borderRadius: BorderRadius.circular(80),
              onTap: () {},
              child: ClipRRect(
                borderRadius: BorderRadius.circular(80),
                child: const Image(
                  image: AssetImage('assets/images/user_placeholder.png'),
                ),
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Container(
            constraints: const BoxConstraints(maxHeight: 236.0),
            decoration: const BoxDecoration(
                color: Color(0xff2f91fb),
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(90.0))),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Home Page'),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Visibility(
        visible: _drawerState,
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

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [_headerDrawer(context), _bodyDrawer(context)]),
    );
  }

  Widget _headerDrawer(context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: const BoxDecoration(color: Color(0xff2f91fb)),
      ),
    );
  }

  Widget _bodyDrawer(context) {
    return Column(
      children: [
        _itemDrawer(const Icon(Icons.home), 'Home'),
        _itemDrawer(const Icon(Icons.list), 'Jadwal Transportasi'),
        _itemDrawer(const Icon(Icons.bookmarks), 'Bookmark'),
        _itemDrawer(const Icon(Icons.settings), 'Settings'),
        _itemDrawer(const Icon(Icons.person), 'Account Settings'),
        const Divider(
          height: 5.0,
          thickness: 1.0,
        ),
        _itemDrawer(const Icon(Icons.logout), 'Logout'),
      ],
    );
  }

  Widget _itemDrawer(Widget icon, String title) {
    return InkWell(
      onTap: () {},
      child: ListTile(
        leading: icon,
        title: Text(title),
      ),
    );
  }
}
