import 'package:betonred/core/app_export.dart';
import 'package:betonred/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

import '../../data/models/onboarding_models/onboarding_model.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({super.key});

  static Widget builder(BuildContext context) {
    return OnboardingScreen();
  }

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController controller = PageController();
  int currentPage = 0;
  List<OnboardingModel> pages = [
    OnboardingModel(
      text:
      'Ah, Senet, come closer. I\'ve been thinking about the potions we discussed earlier. Have you made any progress?',
      name: 'Queen Nefertari',
      imagePath: ImageConstant.imgQueenOnboard,
    ),
    OnboardingModel(
      name: 'Senet, Royal Alchemist',
      text:
      'Yes, Your Majesty. I\'ve been experimenting with a blend of lotus petals and myrrh resin for a potion to enhance vitality and beauty.',
      imagePath: ImageConstant.imgAlchemistOnboard,
      reversePosition: true,
    ),
    OnboardingModel(
      name: 'Queen Nefertari',
      text: 'How intriguing! And what results have you seen?',
      imagePath: ImageConstant.imgQueenOnboard,
      reversePosition: false,
    ),
    OnboardingModel(
      name: 'Senet, Royal Alchemist',
      text:
      'Initial trials have shown promising effects, Your Majesty. Subjects report increased energy and a noticeable improvement in skin complexion.',
      imagePath: ImageConstant.imgAlchemistOnboard,
      reversePosition: true,
    ),
    OnboardingModel(
      name: 'Queen Nefertari',
      text:
      'Excellent news, Senet. But I wonder, can we refine it further? I desire a potion that not only enhances physical appearance but also sharpens the mind and soothes the spirit.',
      imagePath: ImageConstant.imgQueenOnboard,
      reversePosition: false,
    ),
    OnboardingModel(
      name: 'Senet, Royal Alchemist',
      text:
      'Of course, Your Majesty. I shall incorporate ingredients such as sacred blue lily and frankincense to achieve such effects. It will require delicate balance and precise brewing, but I am confident in my abilities.',
      imagePath: ImageConstant.imgAlchemistOnboard,
      reversePosition: true,
    ),
    OnboardingModel(
      name: 'Queen Nefertari',
      text:
      'Very well, Senet. Your dedication to your craft is admirable. I eagerly await the results of your endeavors. Potion-making truly is an art form, don\'t you think?',
      imagePath: ImageConstant.imgQueenOnboard,
      reversePosition: false,
    ),
    OnboardingModel(
      name: 'Senet, Royal Alchemist',
      text:
      'It is a privilege to serve you and contribute to your beauty and well-being through the wonders of alchemy.',
      imagePath: ImageConstant.imgAlchemistOnboard,
      reversePosition: true,
    ),
    OnboardingModel(
      name: 'Queen Nefertari',
      text: 'Hope to see you soon, Senet',
      imagePath: ImageConstant.imgQueenOnboard,
      reversePosition: false,
    ),
    OnboardingModel(
      name: '',
      text:
      'Queen Nefertari wants her potions as soon as possible! But Senet doesn’t have this time. Potions take too much time',
      imagePath: '',
      reversePosition: true,
    ),
    OnboardingModel(
      name: 'Senet, Royal Alchemist',
      text: 'Hey! Can you help me?',
      imagePath: ImageConstant.imgAlchemistOnboard,
      reversePosition: true,
    ),
    OnboardingModel(
      name: 'Senet, Royal Alchemist',
      text:
      'Please! I need someone to help! I’ll tech you how to brew excellent potions. You’’ ll be best in Egypt.',
      imagePath: ImageConstant.imgAlchemistOnboard,
      reversePosition: true,
    ),
    OnboardingModel(
      name: 'Senet, Royal Alchemist',
      text: '... after me, of course. So?',
      imagePath: ImageConstant.imgAlchemistOnboard,
      reversePosition: true,
    ),
    OnboardingModel(
      name: 'Senet, Royal Alchemist',
      text: 'Oh, good! I knew you’re a good person. Let’s take a first class.',
      imagePath: ImageConstant.imgAlchemistOnboard,
      reversePosition: true,
    ),
    OnboardingModel(
      name: 'Senet, Royal Alchemist',
      text:
      'On the top of the screen you’’ll see todays order. In a book you can read recipes.',
      imagePath: ImageConstant.imgAlchemistOnboard,
      reversePosition: true,
    ),
    OnboardingModel(
      name: 'Senet, Royal Alchemist',
      text: 'Keep helping me and I’ll give you new recipes.',
      imagePath: ImageConstant.imgAlchemistOnboard,
      reversePosition: true,
    ),
    OnboardingModel(
      name: 'Senet, Royal Alchemist',
      text: 'Go for a hunt if ypu don’t have enough supplies. See you soon!',
      imagePath: ImageConstant.imgAlchemistOnboard,
      reversePosition: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: AppDecoration.onboardingBackround,
        child: PageView.builder(
          onPageChanged: (index) {
            currentPage = index;
          },
          controller: controller,
          physics: PageScrollPhysics(),
          itemCount: pages.length,
          itemBuilder: (context, index) {
            return listPageItem(context, pages[index]);
          },
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.all(20.h),
        child: CustomElevatedButton(
          text: 'Next',
          onPressed: () {
            if (currentPage == pages.length - 1) {
              Navigator.pushNamed(context, AppRoutes.mainGameScreen,
                  arguments: 0);
            } else {
              // Переход на следующую стадию
              controller.nextPage(
                duration: Duration(milliseconds: 500),
                curve: Curves.ease,
              );
            }
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget listPageItem(BuildContext context, OnboardingModel model) {
    return Stack(
      alignment:
      model.reversePosition ? Alignment.bottomRight : Alignment.bottomLeft,
      children: [
        if (model.imagePath != '')
          CustomImageView(
            imagePath: model.imagePath,
          ),
        Positioned(
          top: 550,
          left: 20,
          right: 20,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 20.v),
            //height: 120.v,
            decoration: AppDecoration.fillGray
                .copyWith(borderRadius: BorderRadiusStyle.roundedBorder20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (model.name != '')
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.v),
                    child: Text(
                      model.name,
                      textAlign: model.reversePosition
                          ? TextAlign.right
                          : TextAlign.left,
                      style: CustomTextStyles.titleSmallRedA400,
                    ),
                  ),
                Text(
                  model.text,
                  textAlign: model.imagePath != ''
                      ? model.reversePosition
                      ? TextAlign.right
                      : TextAlign.left
                      : TextAlign.center,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
