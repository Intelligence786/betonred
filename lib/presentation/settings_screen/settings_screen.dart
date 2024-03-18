import 'package:betonred/core/app_export.dart';
import 'package:betonred/widgets/app_bar/custom_app_bar.dart';
import 'package:betonred/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_icon_button.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  static Widget builder(BuildContext context) {
    return SettingsScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar( height: 80,
        centerTitle: true,
        title: Text(
          'Settings',
          style: CustomTextStyles.titleMediumMedium,
        ),
        leadingWidth: 65,
        leading: Padding(
          padding: EdgeInsets.only(
            left: 10.h,
          ),
          child: Container(
            child: CustomIconButton(
              decoration: AppDecoration.buttonDecoration,
              onTap: () {
                NavigatorService.goBack();
              },
              height: 50,
              width: 50,
              child: Icon(
                Icons.arrow_back,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: AppDecoration.gradientMain,
        padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 40.v),
        child: Column(
          children: [
            CustomElevatedButton(text: 'Privacy Policy'),
            SizedBox(height: 15.v,),
            CustomElevatedButton(text: 'Terms of Use'),
            SizedBox(height: 15.v,),
            CustomElevatedButton(text: 'Rate App'),
          ],
        ),
      ),
    );
  }
}
