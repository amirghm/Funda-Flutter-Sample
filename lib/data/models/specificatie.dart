
class Specificatie {
  Specificatie({
    this.naam,
    this.waarde,
  });

  String? naam;
  String? waarde;

  factory Specificatie.fromJson(Map<String?, dynamic> json) => Specificatie(
    naam: json["Naam"] == null ? null : json["Naam"],
    waarde: json["Waarde"] == null ? null : json["Waarde"],
  );

  Map<String?, dynamic> toJson() => {
    "Naam": naam == null ? null : naam,
    "Waarde": waarde == null ? null : waarde,
  };
}