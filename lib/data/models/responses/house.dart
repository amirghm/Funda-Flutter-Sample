import 'dart:convert';

import 'package:fund_sample/data/models/Kenmerken.dart';
import 'package:fund_sample/data/models/Media.dart';

HouseResponseModel houseResponseModelFromJson(String str) => HouseResponseModel.fromJson(json.decode(utf8.decode(str.codeUnits)));

String houseResponseModelToJson(HouseResponseModel data) => json.encode(data.toJson());

class HouseResponseModel {

  HouseResponseModel({
    this.aantalBadkamers,
    this.aantalKamers,
    this.adres,
    this.bouwjaar,
    this.id,
    this.kenmerken,
    this.kenmerkenKort,
    this.makelaar,
    this.makelaarId,
    this.makelaarTelefoon,
    this.media,
    this.mobileUrl,
    this.plaats,
    this.url,
    this.volledigeOmschrijving,
    this.wgs84X,
    this.wgs84Y,
    this.woonOppervlakte,
    this.koopPrijs,
    this.shortUrl,
  });

  int? aantalBadkamers;
  int? aantalKamers;
  String? adres;
  String? bouwjaar;
  int? id;
  List<Kenmerken>? kenmerken;
  Kenmerken? kenmerkenKort;
  String? makelaar;
  int? makelaarId;
  String? makelaarTelefoon;
  List<Media>? media;
  String? mobileUrl;
  String? plaats;
  String? url;
  String? volledigeOmschrijving;
  double? wgs84X;
  double? wgs84Y;
  int? woonOppervlakte;
  int? koopPrijs;
  String? shortUrl;

  factory HouseResponseModel.fromJson(Map<String?, dynamic> json) => HouseResponseModel(
    aantalBadkamers: json["AantalBadkamers"] == null ? null : json["AantalBadkamers"],
    aantalKamers: json["AantalKamers"] == null ? null : json["AantalKamers"],
    adres: json["Adres"] == null ? null : json["Adres"],
    bouwjaar: json["Bouwjaar"] == null ? null : json["Bouwjaar"],
    id: json["Id"] == null ? null : json["Id"],
    kenmerken: json["Kenmerken"] == null ? null : List<Kenmerken>.from(json["Kenmerken"].map((x) => Kenmerken.fromJson(x))),
    kenmerkenKort: json["KenmerkenKort"] == null ? null : Kenmerken.fromJson(json["KenmerkenKort"]),
    makelaar: json["Makelaar"] == null ? null : json["Makelaar"],
    makelaarId: json["MakelaarId"] == null ? null : json["MakelaarId"],
    makelaarTelefoon: json["MakelaarTelefoon"] == null ? null : json["MakelaarTelefoon"],
    media: json["Media"] == null ? null : List<Media>.from(json["Media"].map((x) => Media.fromJson(x))),
    mobileUrl: json["MobileURL"] == null ? null : json["MobileURL"],
    plaats: json["Plaats"] == null ? null : json["Plaats"],
    url: json["URL"] == null ? null : json["URL"],
    volledigeOmschrijving: json["VolledigeOmschrijving"] == null ? null : json["VolledigeOmschrijving"],
    wgs84X: json["WGS84_X"] == null ? null : json["WGS84_X"].toDouble(),
    wgs84Y: json["WGS84_Y"] == null ? null : json["WGS84_Y"].toDouble(),
    woonOppervlakte: json["WoonOppervlakte"] == null ? null : json["WoonOppervlakte"],
    koopPrijs: json["KoopPrijs"] == null ? null : json["KoopPrijs"],
    shortUrl: json["ShortURL"] == null ? null : json["ShortURL"],
  );

  Map<String?, dynamic> toJson() => {
    "AantalBadkamers": aantalBadkamers == null ? null : aantalBadkamers,
    "AantalKamers": aantalKamers == null ? null : aantalKamers,
    "Adres": adres == null ? null : adres,
    "Bouwjaar": bouwjaar == null ? null : bouwjaar,
    "Id": id == null ? null : id,
    "Kenmerken": kenmerken == null ? null : List<dynamic>.from(kenmerken!.map((x) => x.toJson())),
    "KenmerkenKort": kenmerkenKort == null ? null : kenmerkenKort?.toJson(),
    "Makelaar": makelaar == null ? null : makelaar,
    "MakelaarId": makelaarId == null ? null : makelaarId,
    "MakelaarTelefoon": makelaarTelefoon == null ? null : makelaarTelefoon,
    "Media": media == null ? null : List<dynamic>.from(media!.map((x) => x.toJson())),
    "MobileURL": mobileUrl == null ? null : mobileUrl,
    "Plaats": plaats == null ? null : plaats,
    "URL": url == null ? null : url,
    "VolledigeOmschrijving": volledigeOmschrijving == null ? null : volledigeOmschrijving,
    "WGS84_X": wgs84X == null ? null : wgs84X,
    "WGS84_Y": wgs84Y == null ? null : wgs84Y,
    "WoonOppervlakte": woonOppervlakte == null ? null : woonOppervlakte,
    "KoopPrijs": koopPrijs == null ? null : koopPrijs,
    "ShortURL": shortUrl == null ? null : shortUrl,
  };
}




