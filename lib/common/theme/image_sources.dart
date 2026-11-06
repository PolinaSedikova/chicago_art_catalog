abstract final class ImageSources {
  /// Официальный CDN Чикагского института искусств по image_id
  static String getArtworkImageUrl(String imageId) =>
      'https://www.artic.edu/iiif/2/$imageId/full/843,/0/default.jpg';
}