import 'package:betonred/core/app_export.dart';
import 'package:flutter/material.dart';

enum Character { queen, alchemist }

class RewardScreen {
  final Widget childWidget;
  final String mainText;
  final String secondText;

  final Character character;

  final VoidCallback? onTap; // Используем VoidCallback? для onTap

  RewardScreen({
    required this.childWidget,
    this.mainText = '',
    this.secondText = '',
    this.character = Character.queen,
    VoidCallback? onTap, // onTap теперь типизирован как VoidCallback?
  }): onTap = onTap ?? NavigatorService.goBack;

  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecoration.fillBlack,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () {
            onTap?.call();
          },
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 50.h),
                child: Container(
                  width: double.infinity,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CustomImageView(
                        fit: BoxFit.fitHeight,
                        imagePath: ImageConstant.imgReward,
                      ),
                      Container(
                          height: 500.v,
                          width: 500.h,
                          child: Center(child: childWidget)),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: CustomImageView(
                  alignment: character == Character.queen
                      ? Alignment.bottomCenter
                      : Alignment.bottomRight,
                  imagePath: character == Character.queen
                      ? ImageConstant.imgQueenMoreHalf
                      : ImageConstant.imgAlchemistMoreHalf,
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.only(top: 50.v, bottom: 20.v),
                        child: Text(
                          mainText,
                          style: theme.textTheme.headlineMedium,
                        ),
                      ),
                    ),
                    if (secondText != '')
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 10.v),
                          child: Text(
                            secondText,
                            style: CustomTextStyles.titleMediumMedium,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    Flexible(
                      child: Text(
                        'Tap anywhere to continue',
                        style:
                            CustomTextStyles.titleSmallOnPrimaryContainerMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
