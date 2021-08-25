
class MediaItem {
  static const int IMAGE_ITEM_SELECTED_CATEGORY = 6;

  MediaItem({
    this.category,
    this.url,
  });

  int? category;
  String? url;

  factory MediaItem.fromJson(Map<String?, dynamic> json) => MediaItem(
    category: json["Category"] == null ? null : json["Category"],
    url: json["Url"] == null ? null : json["Url"],
  );

  Map<String?, dynamic> toJson() => {
    "Category": category == null ? null : category,
    "Url": url == null ? null : url,
  };
}
