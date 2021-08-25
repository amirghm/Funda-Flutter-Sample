import 'package:funda_sample/data/models/specificatie.dart';

class Kenmerken {
  Kenmerken({
    this.kenmerken,
    this.lokNummer,
    this.titel,
  });

  List<Specificatie>? kenmerken;
  int? lokNummer;
  String? titel;

  factory Kenmerken.fromJson(Map<String?, dynamic> json) => Kenmerken(
    kenmerken: json["Kenmerken"] == null ? null : List<Specificatie>.from(json["Kenmerken"].map((x) => Specificatie.fromJson(x))),
    lokNummer: json["LokNummer"] == null ? null : json["LokNummer"],
    titel: json["Titel"] == null ? null : json["Titel"],
  );

  Map<String?, dynamic> toJson() => {
    "Kenmerken": kenmerken == null ? null : List<dynamic>.from(kenmerken!.map((x) => x.toJson())),
    "LokNummer": lokNummer == null ? null : lokNummer,
    "Titel": titel == null ? null : titel,
  };
}