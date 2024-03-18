import 'package:flutter/material.dart';
import 'package:betonred/core/utils/size_utils.dart';
import 'package:betonred/theme/theme_helper.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Display text style
  static get displaySmallRedA400 => theme.textTheme.displaySmall!.copyWith(
        color: appTheme.redA400,
      );
  // Title text style
  static get titleMediumBlack => theme.textTheme.titleMedium!.copyWith(
        fontSize: 16.fSize,
        fontWeight: FontWeight.w900,
      );
  static get titleMediumGray90002 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.gray90002,
        fontSize: 16.fSize,
        fontWeight: FontWeight.w900,
      );
  static get titleMediumMedium => theme.textTheme.titleMedium!.copyWith(
        fontWeight: FontWeight.w500,
      );
  static get titleSmallOnPrimaryContainer =>
      theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
      );
  static get titleSmallOnPrimaryContainerMedium =>
      theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(0.53),
        fontWeight: FontWeight.w500,
      );
  static get titleSmallOnPrimaryContainer_1 =>
      theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.background.withOpacity(1),
      );
  static get titleSmallButton =>
      theme.textTheme.titleSmall!.copyWith(
        color: appTheme.gray900.withOpacity(1),
      );
  static get titleSmallRedA400 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.redA400,
      );
}

extension on TextStyle {
  TextStyle get inter {
    return copyWith(
      fontFamily: 'Inter',
    );
  }
}
