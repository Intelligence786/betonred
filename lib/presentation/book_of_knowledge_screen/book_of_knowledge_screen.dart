import 'package:betonred/data/data_manager.dart';
import 'package:betonred/data/models/potion_model/potion_model.dart';
import 'package:betonred/widgets/app_bar/custom_app_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_icon_button.dart';

class BookOfKnowledgeScreen extends StatefulWidget {
  BookOfKnowledgeScreen({super.key});

  static Widget builder(BuildContext context) {
    return BookOfKnowledgeScreen();
  }

  @override
  State<BookOfKnowledgeScreen> createState() => _BookOfKnowledgeScreenState();
}

class _BookOfKnowledgeScreenState extends State<BookOfKnowledgeScreen> {
  int currentItemIndex = 0;
  int openedIndex = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        height: 80,
        centerTitle: true,
        title: Text(
          'Book of knowledge',
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
      extendBody: true,
      body:
      FutureBuilder<int>(
        future: isOpenedIndex(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final index = snapshot.data!;
            return Container(
              decoration: AppDecoration.gradientMain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CarouselSlider.builder(
                    options: CarouselOptions(
                      viewportFraction: 0.5,
                      //height: 200.v,
                      //aspectRatio: 2.0,
                      onPageChanged: (itemIndex, CarouselPage) {
                        setState(() {
                          currentItemIndex = itemIndex;
                        });
                      },
                    ),
                    itemCount: DataManager.potionsList.length,
                    itemBuilder: (BuildContext context,
                        int itemIndex,
                        int pageViewIndex,) {
                      return Container(
                        margin: EdgeInsets.only(right: 8.h),
                        height: 180.v,
                        width: 180.h,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              child: CustomImageView(
                                imagePath: ImageConstant.imgRectangle4,
                              ),
                            ),

                            Container(
                              child: index >= itemIndex
                                  ? CustomImageView(
                                  height: 150.v,
                                  fit: BoxFit.fitHeight,
                                  imagePath:
                                  DataManager.potionsList[itemIndex].image)
                                  : CustomImageView(
                                height: 100.v,
                                fit: BoxFit.fitHeight,
                                imagePath: ImageConstant.img,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    'Potion supplies',
                    style: CustomTextStyles.titleMediumMedium,
                  ),
                  Container(
                    height: 100.v,
                    child: _potionSupllies(
                        context, index),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
          return Text('Error');
          } else {
          return Text('Loading...');
          }
        },
      ),


    );
  }

  Future<int> isOpenedIndex() async {
    int potionIndex = await DataManager.getPotionIndexKey();
    return potionIndex;
  }

  Widget _potionSupllies(BuildContext context, int index) {
    if (index >= currentItemIndex) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(
            imagePath: DataManager
                .potionsList[currentItemIndex].suppliesModels[0].image,
          ),
          CustomImageView(
            imagePath: DataManager
                .potionsList[currentItemIndex].suppliesModels[1].image,
          ),
          CustomImageView(
            imagePath: DataManager
                .potionsList[currentItemIndex].suppliesModels[2].image,
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: 10.v,
          ),
          Container(
            height: 50.v,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.img,
                ),
                CustomImageView(
                  imagePath: ImageConstant.img,
                ),
                CustomImageView(
                  imagePath: ImageConstant.img,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.v,
          ),
          Text('Keep playing to open')
        ],
      );
    }
  }
}
