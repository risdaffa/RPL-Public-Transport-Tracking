import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:public_transport_tracking/models/transportation.dart';
import 'package:public_transport_tracking/screen/profile_screen.dart';

final drawerProvider = StateProvider<bool>((ref) => false);

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _index = 0;
  List<Transportation> _listTransport = [];
  List<Rute> _lineRoute = [];
  List<Time> _listTime = [];
  final _random = Random();
  // final Transportation _transport;
  // _LihatJadwalPageState(this._transport);
  final db = FirebaseFirestore.instance;

  @override
  void didChangeDependencies() {
    getTransportList();
    getLineList();
    getTimeList();
    super.didChangeDependencies();
  }

  Future getTransportList() async {
    var dataTransport = await db.collection("transportation").get();
    setState(() {
      _listTransport = List.from(
          dataTransport.docs.map((e) => Transportation.fromSnapshot(e)));
    });
  }

  Future getLineList() async {
    var dataLineRoute = await db.collection("rute").get();
    setState(() {
      _lineRoute =
          List.from(dataLineRoute.docs.map((e) => Rute.fromSnapshot(e)));
    });
  }

  Future getTimeList() async {
    var dataTime = await db.collection("time").get();
    setState(() {
      _listTime = List.from(dataTime.docs.map((e) => Time.fromSnapshot(e)));
    });
  }

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
                                    child: Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        _btnTransport(
                                          const Icon(Icons.directions_bus,
                                              size: 38,
                                              color: Color.fromARGB(
                                                  255, 71, 209, 144)),
                                          const Color.fromRGBO(
                                              235, 251, 242, 1),
                                        ),
                                        const Text('Bus',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Color.fromARGB(
                                                    255, 71, 209, 144)))
                                      ],
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
                                    child: Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        _btnTransport(
                                          const Icon(
                                              Icons
                                                  .directions_subway_filled_outlined,
                                              size: 38,
                                              color: Color.fromARGB(
                                                  255, 243, 148, 72)),
                                          const Color.fromRGBO(
                                              253, 245, 235, 1),
                                        ),
                                        const Text('Train',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Color.fromARGB(
                                                    255, 243, 148, 72)))
                                      ],
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
            child: (_lineRoute.isNotEmpty &&
                    _listTransport.isNotEmpty &&
                    _listTime.isNotEmpty)
                ? SizedBox(
                    height: 100,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return _transportCard(
                              '${_lineRoute[_random.nextInt(_lineRoute.length)].rute[_random.nextInt(6)]} - ${_lineRoute[_random.nextInt(_lineRoute.length)].rute[_random.nextInt(6)]}',
                              '${_listTransport[_random.nextInt(_listTransport.length)].name}',
                              '13/06/2022');
                        }),
                  )
                : CircularProgressIndicator(),
          ),
          _subMenuTitle('Real-time Schedule'),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 5,
              (context, index) {
                return (_lineRoute.isNotEmpty &&
                        _listTransport.isNotEmpty &&
                        _listTime.isNotEmpty)
                    ? _realtimeHomeCard(
                        'From ${_lineRoute[_random.nextInt(_lineRoute.length)].rute[_random.nextInt(6)]}',
                        '${_listTransport[_random.nextInt(_listTransport.length)].name}',
                        '04/06/2022',
                        'Now - ${_listTime[_random.nextInt(_listTime.length)].go}',
                        'Solo')
                    : CircularProgressIndicator();
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
      width: 200,
      constraints: BoxConstraints(minWidth: 240),
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
          SizedBox(
            width: 190,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$route',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      overflow: TextOverflow.ellipsis),
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
