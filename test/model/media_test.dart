
import 'package:flutter_test/flutter_test.dart';
import 'package:fund_sample/data/models/media.dart';
import 'package:fund_sample/data/models/media_item.dart';

void main() {

  test('Check If we have different media',(){

    MediaItem mockMediaItem = MediaItem(category: 42,url:'link');
    Media mockMedia = Media(categorie: 2,mediaItems: [mockMediaItem]);

    expect(mockMedia.imageUrl, null);
  });

  test('Check If we null media items', (){

    MediaItem mockMediaItem = MediaItem(category: 42,url:'link');
    Media mockMedia = Media(categorie: Media.MEDIA_IMAGE_CATEGORY,mediaItems: null);

    expect(mockMedia.imageUrl, null);
  });

  test('Check If we don\'t have requested media item category', ()  {

    MediaItem mockMediaItem = MediaItem(category: 42,url:'link');
    Media mockMedia = Media(categorie: Media.MEDIA_IMAGE_CATEGORY,mediaItems: [mockMediaItem]);

    expect(mockMedia.imageUrl, null);
  });

  test('Check If we have requested media and media item category', ()  {

    MediaItem mockMediaItem = MediaItem(category: MediaItem.IMAGE_ITEM_SELECTED_CATEGORY,url:'link');
    Media mockMedia = Media(categorie: Media.MEDIA_IMAGE_CATEGORY,mediaItems: [mockMediaItem]);

    expect(mockMedia.imageUrl, 'link');
  });
}
