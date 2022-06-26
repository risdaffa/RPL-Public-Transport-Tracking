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
      // appBar: AppBar(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: false,
            // pinned: true,
            elevation: 0.0,
            leading: Padding(
              padding: const EdgeInsets.only(left: 14.0, top: 8.0),
              child: Builder(
                builder: (context) => IconButton(
                  icon: const Icon(
                    Icons.menu_rounded,
                    size: 38,
                  ),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
            ),
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
          SliverToBoxAdapter(
            child: Stack(
              children: [
                Container(
                  constraints: const BoxConstraints(maxHeight: 180.0),
                  decoration: const BoxDecoration(
                      color: Color(0xff2f91fb),
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(90.0))),
                ),
                Container(
                  decoration: const BoxDecoration(),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 60.0, left: 30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'All Transportation',
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontFamily: 'JejuGothic'),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 30.0, top: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: Material(
                                  color: Colors.white,
                                  child: InkWell(
                                    onTap: () {
                                      print('Bus');
                                    },
                                    child: _btnTransport(
                                      const Icon(Icons.directions_bus,
                                          size: 38,
                                          color: Color.fromARGB(
                                              255, 71, 209, 144)),
                                      const Color.fromRGBO(235, 251, 242, 1),
                                    ),
                                  ),
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: Material(
                                  color: Colors.white,
                                  child: InkWell(
                                    splashColor:
                                        const Color.fromRGBO(253, 245, 235, 1),
                                    onTap: () {},
                                    child: _btnTransport(
                                      const Icon(
                                          Icons
                                              .directions_subway_filled_outlined,
                                          size: 38,
                                          color: Color.fromARGB(
                                              255, 243, 148, 72)),
                                      const Color.fromRGBO(253, 245, 235, 1),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          _subMenuTitle('History Tracking'),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 100,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return _transportCard('Jogja - Solo', 'KRL', '13/06/2022');
                  }),
            ),
          ),
          _subMenuTitle('Real-time Schedule'),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 5,
              (context, index) {
                return _realtimeHomeCard('From St. Balapan', 'KRL',
                    '00/00/0000', 'Now - 20.35', 'Solo');
              },
            ),
          )
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

  Widget _realtimeHomeCard(
      String origin, String name, String date, String time, String city) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Card(
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 10.0, left: 12.0),
                child: Icon(
                  Icons.directions_subway_filled_outlined,
                  size: 38,
                  color: Color.fromARGB(255, 243, 148, 72),
                ),
              ),
              SizedBox(
                width: 180,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$origin',
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    Text(
                      '$name',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '$date',
                      style: const TextStyle(fontSize: 12),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 4),
                height: 60,
                width: 80,
                decoration: const BoxDecoration(
                    border: Border(
                        left: BorderSide(color: Colors.black, width: 1.0))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$time',
                      style: const TextStyle(fontSize: 12),
                    ),
                    Text('$city'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _transportCard(String route, String name, String date) {
    return Container(
      margin: const EdgeInsets.only(left: 20),
      width: 150,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 4.0, left: 4),
            child: Icon(
              Icons.directions_subway_filled_outlined,
              size: 38,
              color: Color.fromARGB(255, 243, 148, 72),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$route',
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              Text(
                '$name',
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(
                '$date',
                style: const TextStyle(fontSize: 12),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _subMenuTitle(String submenu) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 30, top: 45.0, bottom: 9.0),
        child: Text(
          '$submenu',
          style: const TextStyle(
              fontSize: 22,
              color: Color.fromRGBO(13, 71, 161, 1),
              fontFamily: 'JejuGothic'),
        ),
      ),
    );
  }

  Widget _btnTransport(Widget icon, Color circleColor) {
    return SizedBox(
      width: 125,
      height: 125,
      child: Container(
        width: 75,
        height: 75,
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: circleColor,
        ),
        child: icon,
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
