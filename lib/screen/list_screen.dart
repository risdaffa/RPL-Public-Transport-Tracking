import 'package:flutter/material.dart';
import 'package:public_transport_tracking/screen/bookmark_screen.dart';

class ListPage extends StatelessWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              title: const Text('Jadwal Transportasi'),
              bottom: const TabBar(tabs: [
                Tab(text: 'Lihat Jadwal'),
                Tab(text: 'Bookmark'),
              ]),
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.search))
              ],
            ),
            const SliverFillRemaining(
              child: TabBarView(
                  children: [const LihatJadwalScreen(), BookmarkScreen()]),
            )
          ],
        ),
      ),
    );
  }
}

class LihatJadwalScreen extends StatelessWidget {
  const LihatJadwalScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('Jadwal Transportasi'),
        ],
      ),
    );
  }
}
