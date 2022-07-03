class Transportation {
  String? name;
  String? type;
  int? id;
  Transportation(this.id, this.name, this.type);
  Map<String, dynamic> toJson() => {'name': name, 'type': type, 'id': id};
  Transportation.fromSnapshot(snapshot)
      : name = snapshot.data()['name'],
        type = snapshot.data()['type'],
        id = snapshot.data()['id'];
}

class Rute {
  String? tipe_rute;
  List<String> rute;
  int? id_rute;
  Rute(this.id_rute, this.rute, this.tipe_rute);
  Map<String, dynamic> toJson() => {
        'rute': List<dynamic>.from(rute.map((x) => x)),
        'tipe_rute': tipe_rute,
        'id_rute': id_rute
      };
  Rute.fromSnapshot(snapshot)
      : rute = List<String>.from(snapshot.data()['rute'].map((x) => x)),
        tipe_rute = snapshot.data()['tipe_rute'],
        id_rute = snapshot.data()['id_rute'];
}

class Time {
  String? arrive;
  String? go;
  int? id_time;
  Time(this.id_time, this.arrive, this.go);
  Map<String, dynamic> toJson() =>
      {'arrive': arrive, 'go': go, 'id_time': id_time};
  Time.fromSnapshot(snapshot)
      : arrive = snapshot.data()['arrive'],
        go = snapshot.data()['go'],
        id_time = snapshot.data()['id_time'];
}
