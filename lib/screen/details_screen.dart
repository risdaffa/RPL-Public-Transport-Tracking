import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  DetailsPage(
      {Key? key,
      required this.origin,
      required this.destination,
      required this.initTime,
      required this.name})
      : super(key: key);
  String origin;
  String name;
  String initTime;
  String destination;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Lacak Transportasi'),
        ),
        body: Container(
          margin: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              _realtimeHomeCard(
                  origin, name, '04/06/2022', initTime, destination)
            ],
          ),
        ));
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
                width: 160,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dari $origin',
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
      ),
    );
  }
}
