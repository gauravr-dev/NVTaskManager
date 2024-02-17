import 'package:flutter/material.dart';
import 'package:pomodoro_app/constants/colors.dart';

// Kumbh Sans
// Robot Slab
// Space Mono

// H1 - Bold, 100px, 120px - line, -5px character
// H2 - Bold, 28px, 34px - line
// H3 - Bold, 16px, 19px - line, 15px character
// H4 - Bold, 13px, 16px - line, 5px character

// Body1 - Bold, 14px, 18px - line
// Body2 - Bold, 12px, 14px - line

const String fontFamilyName1 = "KumbhSans";
const String fontFamilyName2 = "RobotoSlab";
const String fontFamilyName3 = "SpaceMono";

abstract class TextStyles {
  static const h1 = TextStyle(
      fontFamily: fontFamilyName1,
      fontWeight: FontWeight.bold,
      fontSize: 100,
      letterSpacing: -5,
      color: Colors.amber);

  static const h2 = TextStyle(
    fontFamily: fontFamilyName1,
    fontWeight: FontWeight.bold,
    fontSize: 28,
  );

  static const h3 = TextStyle(
      fontFamily: fontFamilyName1,
      fontWeight: FontWeight.bold,
      fontSize: 16,
      letterSpacing: 15);

  static const h4 = TextStyle(
      fontFamily: fontFamilyName1,
      fontWeight: FontWeight.bold,
      fontSize: 13,
      letterSpacing: 5);

  static const body1 = TextStyle(
    fontFamily: fontFamilyName1,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );

  static const body2 = TextStyle(
    fontFamily: fontFamilyName1,
    fontWeight: FontWeight.bold,
    fontSize: 12,
    color: AppColors.background,
  );
}
