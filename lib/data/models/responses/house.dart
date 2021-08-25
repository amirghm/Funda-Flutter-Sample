import 'dart:convert';

import 'package:funda_sample/data/models/kenmerken.dart';
import 'package:funda_sample/data/models/media.dart';

HouseResponseModel houseResponseModelFromJson(String str) => HouseResponseModel.fromJson(json.decode(str));

String houseResponseModelToJson(HouseResponseModel data) => json.encode(data.toJson());

class HouseResponseModel {

  HouseResponseModel({
    this.aantalBadkamers,
    this.aantalKamers,
    this.adres,
    this.id,
    this.kenmerken,
    this.makelaarTelefoon,
    this.media,
    this.url,
    this.woonOppervlakte,
    this.volledigeOmschrijving,
    this.koopPrijs,
  });

  int? aantalBadkamers;
  int? aantalKamers;
  String? adres;
  int? id;
  List<Kenmerken>? kenmerken;
  String? makelaarTelefoon;
  List<Media>? media;
  String? url;
  int? woonOppervlakte;
  String? volledigeOmschrijving;
  int? koopPrijs;

  List<Media>? get photos => media?.where((element) => element.categorie == Media.MEDIA_IMAGE_CATEGORY).toList();

  bool get isPhotoAvailable => media!=null && media!.length>0;

  factory HouseResponseModel.fromJson(Map<String?, dynamic> json) => HouseResponseModel(
    aantalBadkamers: json["AantalBadkamers"] == null ? null : json["AantalBadkamers"],
    aantalKamers: json["AantalKamers"] == null ? null : json["AantalKamers"],
    adres: json["Adres"] == null ? null : json["Adres"],
    id: json["Id"] == null ? null : json["Id"],
    kenmerken: json["Kenmerken"] == null ? null : List<Kenmerken>.from(json["Kenmerken"].map((x) => Kenmerken.fromJson(x))),
    makelaarTelefoon: json["MakelaarTelefoon"] == null ? null : json["MakelaarTelefoon"],
    volledigeOmschrijving: json["VolledigeOmschrijving"] == null ? null : json["VolledigeOmschrijving"],
    media: json["Media"] == null ? null : List<Media>.from(json["Media"].map((x) => Media.fromJson(x))),
    url: json["URL"] == null ? null : json["URL"],
    woonOppervlakte: json["WoonOppervlakte"] == null ? null : json["WoonOppervlakte"],
    koopPrijs: json["KoopPrijs"] == null ? null : json["KoopPrijs"],
  );

  Map<String?, dynamic> toJson() => {
    "AantalBadkamers": aantalBadkamers == null ? null : aantalBadkamers,
    "AantalKamers": aantalKamers == null ? null : aantalKamers,
    "Adres": adres == null ? null : adres,
    "Id": id == null ? null : id,
    "Kenmerken": kenmerken == null ? null : List<dynamic>.from(kenmerken!.map((x) => x.toJson())),
    "MakelaarTelefoon": makelaarTelefoon == null ? null : makelaarTelefoon,
    "Media": media == null ? null : List<dynamic>.from(media!.map((x) => x.toJson())),
    "VolledigeOmschrijving": volledigeOmschrijving == null ? null : volledigeOmschrijving,
    "URL": url == null ? null : url,
    "WoonOppervlakte": woonOppervlakte == null ? null : woonOppervlakte,
    "KoopPrijs": koopPrijs == null ? null : koopPrijs,
  };
}




