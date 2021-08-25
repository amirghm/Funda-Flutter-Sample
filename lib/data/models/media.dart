import 'package:fund_sample/data/models/media_item.dart';
import 'package:collection/collection.dart';

class Media {
  static const int MEDIA_IMAGE_CATEGORY = 1;

  Media({
    this.categorie,
    this.id,
    this.indexNumber,
    this.mediaItems,
  });

  int? categorie;
  String? id;
  int? indexNumber;
  List<MediaItem>? mediaItems;

  factory Media.fromJson(Map<String?, dynamic> json) => Media(
        categorie: json["Categorie"] == null ? null : json["Categorie"],
        id: json["Id"] == null ? null : json["Id"],
        indexNumber: json["IndexNumber"] == null ? null : json["IndexNumber"],
        mediaItems: json["MediaItems"] == null
            ? null
            : List<MediaItem>.from(
                json["MediaItems"].map((x) => MediaItem.fromJson(x))),
      );

  Map<String?, dynamic> toJson() => {
        "Categorie": categorie == null ? null : categorie,
        "Id": id == null ? null : id,
        "IndexNumber": indexNumber == null ? null : indexNumber,
        "MediaItems": mediaItems == null
            ? null
            : List<dynamic>.from(mediaItems!.map((x) => x.toJson())),
      };

  String? get imageUrl => (categorie == MEDIA_IMAGE_CATEGORY)
      ? mediaItems?.firstWhereOrNull((element) =>
              element.category == MediaItem.IMAGE_ITEM_SELECTED_CATEGORY)?.url : null;
}
