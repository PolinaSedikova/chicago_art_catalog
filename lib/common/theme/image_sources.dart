import 'package:flutter/material.dart';

abstract final class ImageSources {
  static String getPlaceholderLetter(String title) =>
      title.isNotEmpty ? title.characters.first.toUpperCase() : '?';

  static String getArtworkImageUrl(String imageId) =>
      'https://www.artic.edu/iiif/2/$imageId/full/843,/0/default.jpg';
}