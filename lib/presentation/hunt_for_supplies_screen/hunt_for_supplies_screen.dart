import 'dart:math';

import 'package:betonred/data/data_manager.dart';
import 'package:betonred/data/inventory_manager.dart';
import 'package:betonred/data/models/inventory_item_model/inventory_item_model.dart';
import 'package:betonred/data/models/supply_model/supply_model.dart';
import 'package:betonred/widgets/app_bar/custom_app_bar.dart';
import 'package:betonred/widgets/reward_screen.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_icon_button.dart';

class HuntForSuppliesScreen extends StatefulWidget {
  HuntForSuppliesScreen({super.key});

  static Widget builder(BuildContext context) {
    return HuntForSuppliesScreen();
  }

  @override
  State<HuntForSuppliesScreen> createState() => _HuntForSuppliesScreenState();
}

class _HuntForSuppliesScreenState extends State<HuntForSuppliesScreen> {
  List<bool> isOpen = List.generate(9, (index) => false);

  List<bool> isCompleted = List.generate(9, (index) => false);

  List<SupplyModel> supplies = [];

  List<SupplyModel> chooseSupplies = [];

  @override
  void initState() {
    supplies = getRandomElements(DataManager.suppliesList, 9);
    super.initState();
  }

  int taps = 0;

  int maxTaps = 3;

  List<SupplyModel> getRandomElements<SupplyModel>(
      List<SupplyModel> list, int count) {
    if (count > DataManager.suppliesList.length) {
      throw ArgumentError(
          'Count cannot be greater than the length of the list.');
    }
    Random random = Random();
    List<SupplyModel> randomElements = [];

    while (randomElements.length < count) {
      int randomIndex = random.nextInt(DataManager.suppliesList.length);
      SupplyModel element = list[randomIndex];

      randomElements.add(element);
    }

    return randomElements;
  }

  void _onTileTap(int index) {
    if (!isOpen[index] && taps < maxTaps) {
      setState(() {
        isOpen[index] = true;
        taps++;
      });
      chooseSupplies.add(supplies[index]);
      if (taps == maxTaps) {
        Future.delayed(Duration(milliseconds: 500), () async {
          for (int i = 0; i < chooseSupplies.length; i++) {
            InventoryItemModel iim =
                InventoryItemModel(supply: chooseSupplies[i], quantity: 1);
           await InventoryManager.addItemToInventory(iim);
          }
          taps = 0;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: CustomAppBar(
            height: 80,
            centerTitle: true,
            title: Text(
              'Hunt for supplies',
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
                  height: 50.v,
                  width: 50.h,
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
          body: Container(
            padding: EdgeInsets.all(20.h),
            decoration: AppDecoration.gradientMain,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 30.v),
                  child: Text(
                    'Open 3 random cards',
                    style: CustomTextStyles.titleSmallOnPrimaryContainer_1,
                  ),
                ),
                Flexible(
                  child: Container(
                    child: GridView.builder(
                        itemCount: isOpen.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => _onTileTap(index),
                            child: Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.all(6),
                                  child: CustomImageView(
                                    imagePath: ImageConstant.imgRectangle4,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(6),
                                  child: Center(
                                    child: isCompleted[index]
                                        ? Icon(Icons.check, color: Colors.white)
                                        : isOpen[index]
                                            ? Container(
                                                height: 100.v,
                                                child: CustomImageView(
                                                  imagePath:
                                                      supplies[index].image,
                                                ),
                                              )
                                            : Container(
                                                height: 50.v,
                                                child: CustomImageView(
                                                  imagePath: ImageConstant.img,
                                                ),
                                              ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (chooseSupplies.length >= 3)
          RewardScreen(
                  childWidget: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomImageView(
                        imagePath: chooseSupplies[0].image,
                      ),
                      CustomImageView(
                        imagePath: chooseSupplies[1].image,
                      ),
                      CustomImageView(
                        imagePath: chooseSupplies[2].image,
                      ),
                    ],
                  ),
                  mainText: 'Good!')
              .build(context)
      ],
    );
  }
}
