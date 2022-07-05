import 'package:flutter/material.dart';
import 'package:public_transport_tracking/models/transportation.dart';

class DetailsPage extends StatelessWidget {
  DetailsPage(
      {Key? key,
      required this.origin,
      required this.destination,
      required this.initTime,
      required this.name})
      : super(key: key);
  String origin;
  Transportation name;
  String initTime;
  String destination;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Lacak Transportasi'),
        ),
        body: Center(
          child: Container(
            width: 340,
            height: MediaQuery.of(context).size.height,
            margin: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                _realtimeHomeCard(
                    origin, name, '04/06/2022', initTime, destination),
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  'The Schedule may be subject to change, and will be updated',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Container(
                      height: 480,
                      width: 23,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blue[900],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }

  Widget _realtimeHomeCard(String origin, Transportation name, String date,
      String time, String city) {
    return Card(
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0, left: 12.0),
              child: (name.type.toString() == 'train')
                  ? const Icon(
                      Icons.directions_subway_filled_outlined,
                      size: 38,
                      color: Color.fromARGB(255, 243, 148, 72),
                    )
                  : const Icon(Icons.directions_bus,
                      size: 38, color: Color.fromARGB(255, 71, 209, 144)),
            ),
            SizedBox(
              width: 160,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'From $origin',
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  Text(
                    '${name.name}',
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
              padding: const EdgeInsets.only(left: 4),
              height: 60,
              width: 100,
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
    );
  }
}
