import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<bool> isSelected1 = [];
  List<bool> isSelected2 = [];
  List<bool> isSelected3 = [];
  var labelStyle = const TextStyle(
      color: Colors.black,
      fontFamily: 'JejuGothic',
      fontSize: 15,
      fontWeight: FontWeight.w400);
  @override
  void initState() {
    isSelected1 = [true, false];
    isSelected2 = [true, false, false];
    isSelected3 = [true, false];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromRGBO(114, 211, 255, 1),
        appBar: AppBar(
          title: const Text('Filter'),
          centerTitle: true,
          actions: [
            TextButton(
                onPressed: () {},
                child: const Text(
                  'Reset',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 32),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nama Transportasi',
                    textAlign: TextAlign.left, style: labelStyle),
                _inputField(
                    icon: const Icon(Icons.directions_bus_filled_rounded)),
                const SizedBox(height: 20),
                Text('Jenis Transportasi',
                    textAlign: TextAlign.left, style: labelStyle),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 36,
                  color: const Color.fromRGBO(208, 233, 251, 1),
                  child: ToggleButtons(
                      color: Colors.black,
                      constraints: BoxConstraints.tight(Size(
                          (MediaQuery.of(context).size.width - 65) / 2, 36)),
                      fillColor: const Color.fromRGBO(47, 145, 251, 1),
                      borderRadius: BorderRadius.circular(0),
                      onPressed: (index) {
                        setState(() {
                          for (int i = 0; i < isSelected1.length; i++) {
                            isSelected1[i] = i == index;
                          }
                        });
                      },
                      isSelected: isSelected1,
                      children: [Text('Bus'), Text('Kereta')]),
                ),
                const SizedBox(height: 20),
                Text('Lokasi Berangkat',
                    textAlign: TextAlign.left, style: labelStyle),
                _inputField(icon: const Icon(Icons.location_on)),
                const SizedBox(height: 20),
                Text('Lokasi Tujuan',
                    textAlign: TextAlign.left, style: labelStyle),
                _inputField(icon: const Icon(Icons.location_on)),
                const SizedBox(height: 20),
                Text('Waktu', textAlign: TextAlign.left, style: labelStyle),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 36,
                  color: const Color.fromRGBO(208, 233, 251, 1),
                  child: ToggleButtons(
                      color: Colors.black,
                      constraints: BoxConstraints.tight(Size(
                          (MediaQuery.of(context).size.width - 66) / 3, 36)),
                      fillColor: const Color.fromRGBO(47, 145, 251, 1),
                      borderRadius: BorderRadius.circular(0),
                      onPressed: (index) {
                        setState(() {
                          for (int i = 0; i < isSelected2.length; i++) {
                            isSelected2[i] = i == index;
                          }
                        });
                      },
                      isSelected: isSelected2,
                      children: [
                        Text('Semua'),
                        Text('Hari Ini'),
                        Text('Besok')
                      ]),
                ),
                const SizedBox(height: 20),
                Text('Status', textAlign: TextAlign.left, style: labelStyle),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 36,
                  color: const Color.fromRGBO(208, 233, 251, 1),
                  child: ToggleButtons(
                      color: Colors.black,
                      constraints: BoxConstraints.tight(Size(
                          (MediaQuery.of(context).size.width - 65) / 2, 36)),
                      fillColor: const Color.fromRGBO(47, 145, 251, 1),
                      borderRadius: BorderRadius.circular(0),
                      onPressed: (index) {
                        setState(() {
                          for (int i = 0; i < isSelected3.length; i++) {
                            isSelected3[i] = i == index;
                          }
                        });
                      },
                      isSelected: isSelected3,
                      children: [Text('Ontime'), Text('Terlambat')]),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(onPressed: () {}, child: const Text('Cari')),
        ));
  }
}

class _inputField extends StatelessWidget {
  _inputField({Key? key, required this.icon}) : super(key: key);
  Icon icon;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: TextField(
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            prefixIcon: icon,
            fillColor: const Color.fromRGBO(208, 233, 251, 1),
            contentPadding: const EdgeInsets.all(5),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color.fromRGBO(208, 233, 251, 1), width: 2.0),
            ),
          )),
    );
  }
}
