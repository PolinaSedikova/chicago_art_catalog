import 'package:flutter/material.dart';

abstract final class AppColors {
  // Светлая палитра
  static const Color primaryLight = Color(0xFF3F51B5);
  static const Color secondaryLight = Color(0xFF009688);
  static const Color surfaceLight = Color(0xFFF8F9FA);
  static const Color cardLight = Colors.white;

  // Тёмная палитра
  static const Color primaryDark = Color(0xFF9FA8DA);
  static const Color secondaryDark = Color(0xFF80CBC4);
  static const Color surfaceDark = Color(0xFF121212);
  static const Color cardDark = Color(0xFF1E1E1E);

  // Плейсхолдеры для карточек
  static const Color placeholderLight = Color(0xFFE8EAF6);
  static const Color placeholderDark = Color(0xFF282C34);
}