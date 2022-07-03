import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:public_transport_tracking/models/transportation.dart';
import 'package:public_transport_tracking/screen/bookmark_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:public_transport_tracking/screen/details_screen.dart';
import 'package:public_transport_tracking/screen/profile_screen.dart';

class ListPage extends StatefulWidget {
  ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final _controller = ScrollController();
  bool _isvisible = true;

  void _scrollToTop() {
    _controller.animateTo(0,
        duration: const Duration(milliseconds: 600), curve: Curves.easeIn);
  }

  // @override
  // void initState() {
  //   _controller.addListener(() {
  //     if (_controller.offset > _controller.position.minScrollExtent) {
  //       setState(() {
  //         _isvisible = true;
  //       });
  //     } else {
  //       setState(() {
  //         _isvisible = false;
  //       });
  //     }
  //   });
  //   super.initState();
  // }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: CircleAvatar(
          radius: 30,
          backgroundColor: Color.fromARGB(255, 0, 170, 255),
          child: IconButton(
            color: Colors.white,
            icon: const Icon(Icons.arrow_upward),
            onPressed: _scrollToTop,
          ),
        ),
        body: NestedScrollView(
          controller: _controller,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                  floating: true,
                  title: const Text('Jadwal Transportasi'),
                  actions: [
                    IconButton(onPressed: () {}, icon: const Icon(Icons.search))
                  ],
                  bottom: const TabBar(
                    tabs: [Tab(text: 'Lihat Jadwal'), Tab(text: 'Bookmark')],
                  ))
            ];
          },
          body: TabBarView(children: [
            LihatJadwalPage(),
            BookmarkPage(),
          ]),
        ),
      ),
    );
  }
}

class LihatJadwalPage extends StatefulWidget {
  LihatJadwalPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LihatJadwalPage> createState() => _LihatJadwalPageState();
}

class _LihatJadwalPageState extends State<LihatJadwalPage> {
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
    return (_lineRoute.isNotEmpty &&
            _listTransport.isNotEmpty &&
            _listTime.isNotEmpty)
        ? ListView.builder(
            itemCount: 100,
            itemBuilder: ((context, index) {
              return _realtimeHomeCard(
                  '${_lineRoute[_random.nextInt(_lineRoute.length)].rute[_random.nextInt(6)]}',
                  '${_listTransport[_random.nextInt(_listTransport.length)].name}',
                  '${_listTime[_random.nextInt(_listTime.length)].go}',
                  '${_listTime[_random.nextInt(_listTime.length)].arrive}',
                  '${_lineRoute[_random.nextInt(_lineRoute.length)].rute[_random.nextInt(6)]}');
              // _realtimeHomeCard(
              //     'Solo Balapan', 'COMMUTER LINE', '19.30', '21.10', 'Yogyakarta');
            }))
        : LoadingCircle();
  }

  Widget _realtimeHomeCard(String origin, String name, String initTime,
      String endTime, String destination) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 9.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
            return DetailsPage(
              origin: origin,
              name: name,
              initTime: initTime,
              destination: destination,
            );
          })));
        },
        child: Card(
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(right: 10.0, left: 12.0),
                      child: const Icon(
                        Icons.directions_subway_filled_outlined,
                        size: 70,
                        color: Color.fromARGB(255, 243, 148, 72),
                      ),
                    ),
                    Text('#${Random().nextInt(1000)}')
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$name',
                      style: GoogleFonts.bebasNeue(
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w500,
                          fontSize: 25,
                          height: 1.2),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 140,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('From : ',
                                  style: TextStyle(height: 0.8)),
                              Text(
                                '$origin',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                              Text(
                                '$initTime',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 12, top: 3),
                          height: 60,
                          decoration: const BoxDecoration(
                              border: Border(
                                  left: BorderSide(
                                      color: Colors.black, width: 1.0))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('To : ',
                                  style: const TextStyle(height: 0.8)),
                              Text(
                                '$destination',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                              Text(
                                '$endTime',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
