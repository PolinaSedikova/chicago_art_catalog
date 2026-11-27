abstract final class ImageSources {
  // URL изображения экспоната по ID
  static String getArtworkImageUrl(String imageId) =>
      'https://www.artic.edu/iiif/2/$imageId/full/843,/0/default.jpg';
}
