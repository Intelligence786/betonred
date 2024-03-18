import 'package:betonred/data/data_manager.dart';
import 'package:betonred/data/inventory_manager.dart';
import 'package:betonred/data/models/potion_model/potion_model.dart';
import 'package:betonred/data/models/task_models/task_model.dart';
import 'package:betonred/presentation/main_game_screen/progress_bloc/progress_bloc.dart';
import 'package:betonred/widgets/app_bar/custom_app_bar.dart';
import 'package:betonred/widgets/custom_elevated_button.dart';
import 'package:betonred/widgets/reward_screen.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../data/models/inventory_item_model/inventory_item_model.dart';
import '../../widgets/custom_icon_button.dart';
import '../main_game_screen/task_bloc/task_bloc.dart';

class PotionRoomScreen extends StatefulWidget {
  PotionRoomScreen({super.key});

  static Widget builder(BuildContext context) {
    return PotionRoomScreen();
  }

  @override
  State<PotionRoomScreen> createState() => _PotionRoomScreenState();
}

class _PotionRoomScreenState extends State<PotionRoomScreen> {
  List<InventoryItemModel?> brewingIngredients = List.filled(3, null);
  late final TaskBloc taskBloc;
  late Future<List<InventoryItemModel>> inventoryItems;
  int isReward = -1;
  late PotionModel currentPotion;

  @override
  void initState() {
    super.initState();
    loadInventoryItems();
    isReward = -1;
  }

  Future<void> loadInventoryItems() async {
    inventoryItems = InventoryManager.getInventory();
  }

  void addToBrewing(InventoryItemModel item) {
    setState(() {
      final index = brewingIngredients.indexWhere((element) => element == null);
      if (index != -1) {
        brewingIngredients[index] = item;
      } else {
        // Handle case when all slots are filled
      }
    });
  }

  void removeFromBrewing(int index) {
    setState(() {
      brewingIngredients[index] = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    TaskBloc taskBloc = BlocProvider.of<TaskBloc>(context);
    ProgressBloc progressBloc = BlocProvider.of<ProgressBloc>(context);
    return Stack(
      children: [
        Scaffold(
          appBar: CustomAppBar(
            height: 80,
            centerTitle: true,
            title: Text(
              'Potion room',
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
            actions: [
              Container(
                padding: EdgeInsets.all(16.h),
                child: CustomImageView(
                  fit: BoxFit.fitHeight,
                  imagePath: ImageConstant.img14x3,
                  onTap: () {
                    NavigatorService.pushNamed(AppRoutes.bookOfKnowledgeScreen);
                  },
                ),
              ),
            ],
          ),
          extendBody: true,
          body: Container(
            decoration: AppDecoration.gradientMain,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _taskListWidget(context, taskBloc),
                Container(
                  height: 380,
                  decoration: AppDecoration.fillGray,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.v),
                        child: Text(
                          'Brew the potion',
                          style: CustomTextStyles.titleMediumMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(
                          3,
                          (index) => GestureDetector(
                            onTap: () {
                              if (brewingIngredients[index] != null) {
                                removeFromBrewing(index);
                              } else {
                                // Open a dialog or navigate to inventory screen to choose ingredients
                              }
                            },
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: AppDecoration.fillOnPrimary,
                              child: Center(
                                child: brewingIngredients[index] != null
                                    ? CustomImageView(
                                        imagePath: brewingIngredients[index]
                                            ?.supply
                                            .image,
                                      )
                                    : Container(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 30.v, left: 30.h, bottom: 20.v),
                        child: Text(
                          'Choose supplies',
                          style: CustomTextStyles.titleMediumMedium,
                        ),
                      ),
                      FutureBuilder(
                        future: inventoryItems,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else {
                            return Container(
                              height: 80,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: snapshot.data?.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(right: 8.h),
                                    //height: 20,
                                    width: 80,
                                    child: Stack(
                                      children: [
                                        CustomImageView(
                                          fit: BoxFit.fitWidth,
                                          onTap: () {

                                            addToBrewing(snapshot.data![index]);
                                          },
                                          imagePath: snapshot
                                              .data?[index].supply.image,
                                        ),
                                        if (snapshot.data![index].quantity > 1)
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              decoration:
                                                  AppDecoration.potionCounter,
                                              child: Center(
                                                child: Text(
                                                  snapshot.data![index].quantity
                                                      .toString(),
                                                  style: CustomTextStyles
                                                      .titleMediumGray90002,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                        },
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.h, vertical: 50.v),
                  child: CustomElevatedButton(
                    text: 'Start brewing',
                    buttonTextStyle: CustomTextStyles.titleSmallButton,
                    buttonStyle: CustomButtonStyles.buttonMoreRounded,
                    isDisabled:
                        brewingIngredients.any((element) => element == null),
                    onPressed: () async {
                      dynamic potion = DataManager.findPotionsBySupplies(
                          brewingIngredients[0]!.supply,
                          brewingIngredients[1]!.supply,
                          brewingIngredients[2]!.supply);

                      if (potion != null) {
                        currentPotion = potion;
                        print(potion.name);
                        taskBloc.add(
                          TaskCompleteEvent(potion: potion),
                        );
                        progressBloc.add(IncrementProgress(0.5));
                        setState(() {
                          isReward = 1;
                        });
                      } else {
                        currentPotion = DataManager.potionsList[0];
                        progressBloc.add(IncrementProgress(0.5));
                        setState(() {
                          isReward = 0;
                        });
                      }
                      for (int i = 0; i < brewingIngredients.length; i++) {
                        print(brewingIngredients[i]!.supply.name);
                        await InventoryManager.useItemFromInventory(
                            brewingIngredients[i]!);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        if (isReward > -1)
          RewardScreen(
                  childWidget: Container(
                    height: 150,
                    child: CustomImageView(
                      imagePath: currentPotion.image,
                    ),
                  ),
                  mainText: isReward == 0 ? 'Hmm' : 'Done!',
                  secondText: isReward == 0
                      ? 'Looks like this potion was not on list...\nBe careful. You just lost some ingredients'
                      : 'Queen Nefertari is happy! Continue!',
                  character: Character.alchemist)
              .build(context),
      ],
    );
  }

  Widget _taskListWidget(BuildContext context, TaskBloc taskBloc) {
    return Container(
      // decoration: AppDecoration.fillOnPrimary,
      padding:
          EdgeInsets.only(left: 20.h, right: 20.h, top: 20.v, bottom: 10.v),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Today\'s order',
            style: theme.textTheme.titleMedium,
          ),
          SizedBox(
            height: 8.v,
          ),
          Container(
            height: 80.v,
            child: StreamBuilder<List<TaskModel>>(
              stream: taskBloc.tasks, // Подписываемся на изменения в блоке
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                 return ListView.builder(
                    itemCount: snapshot.data?.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(right: 8.h),
                        height: 80.v,
                        width: 80.h,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              child: CustomImageView(
                                imagePath: ImageConstant.imgRectangle4,
                              ),
                            ),
                            Container(
                              child: CustomImageView(
                                fit: BoxFit.fitHeight,
                                imagePath:
                                    snapshot.data?[index].potionModel.image,
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                width: 30.h,
                                height: 30.v,
                                decoration: AppDecoration.fillRedA,
                                child: Center(
                                  child: Text(
                                    snapshot.data?[index].count.toString() ??
                                        '',
                                    style: theme.textTheme.titleMedium,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
