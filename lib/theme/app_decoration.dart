import 'package:betonred/core/app_export.dart';
import 'package:flutter/material.dart';

class AppDecoration {
  // Fill decorations
  static BoxDecoration get fillGray => BoxDecoration(
        color: appTheme.gray90002,
      );

  static BoxDecoration get fillOnPrimary => BoxDecoration(
        color: theme.colorScheme.onPrimary,
    borderRadius: BorderRadius.circular(20),
      );

  static BoxDecoration get fillOnPrimaryContainer => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
      );

  static BoxDecoration get fillBlack => BoxDecoration(
    color: Colors.black.withOpacity(0.95),
  );

  static BoxDecoration get fillRedA => BoxDecoration(
        color: appTheme.redA400,
    borderRadius: BorderRadius.circular(10),
      );

  static BoxDecoration get buttonDecoration => BoxDecoration(
    color: appTheme.blueGray900,
    borderRadius: BorderRadius.circular(12),
  );


  // Gradient decorations
  static BoxDecoration get gradientGrayToGray => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.5, 0),
          end: Alignment(0.5, 1),
          colors: [
            appTheme.gray900,
            appTheme.gray900.withOpacity(0),
          ],
        ),
      );

  static BoxDecoration get onboardingBackround => BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image:ExactAssetImage(ImageConstant.imgOnboardingBackground)
        ),
      );

  static BoxDecoration get gradientGreenToGray => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.9, 0.15),
          end: Alignment(0.13, 0.81),
          colors: [
            appTheme.green900,
            appTheme.gray90001,
          ],
        ),
    borderRadius: BorderRadius.circular(12),
      );

  static BoxDecoration get potionCounter => BoxDecoration(
    color: theme.colorScheme.primary,
    borderRadius: BorderRadius.circular(10),
  );

  static BoxDecoration get gradientPrimaryContainerToGray => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.9, 0.15),
          end: Alignment(0.13, 0.81),
          colors: [
            theme.colorScheme.primaryContainer,
            appTheme.gray90001,
          ],
        ),
      );

  static BoxDecoration get gradientMain  => BoxDecoration(
    gradient: LinearGradient(

      begin: Alignment(0.9, 0.15),
      end: Alignment(0.13, 0.81),
      colors: [
        Color(0XFF314326),
        Color(0XFF5A2D2A),

      ],
    ),
  );
}

class BorderRadiusStyle {
  // Rounded borders
  static BorderRadius get roundedBorder13 => BorderRadius.circular(
        13.h,
      );

  static BorderRadius get roundedBorder20 => BorderRadius.circular(
        20.h,
      );

  static BorderRadius get roundedBorder31 => BorderRadius.circular(
        31.h,
      );

  static BorderRadius get roundedBorder9 => BorderRadius.circular(
        9.h,
      );
}

// Comment/Uncomment the below code based on your Flutter SDK version.

// For Flutter SDK Version 3.7.2 or greater.

double get strokeAlignInside => BorderSide.strokeAlignInside;

double get strokeAlignCenter => BorderSide.strokeAlignCenter;

double get strokeAlignOutside => BorderSide.strokeAlignOutside;

// For Flutter SDK Version 3.7.1 or less.

// StrokeAlign get strokeAlignInside => StrokeAlign.inside;
//
// StrokeAlign get strokeAlignCenter => StrokeAlign.center;
//
// StrokeAlign get strokeAlignOutside => StrokeAlign.outside;
