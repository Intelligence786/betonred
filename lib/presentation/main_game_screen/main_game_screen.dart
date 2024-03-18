import 'package:betonred/core/app_export.dart';
import 'package:betonred/data/data_manager.dart';
import 'package:betonred/data/models/potion_model/potion_model.dart';
import 'package:betonred/presentation/main_game_screen/hunt_timer_cubit/hunt_time_cubit.dart';
import 'package:betonred/presentation/main_game_screen/progress_bloc/progress_bloc.dart';
import 'package:betonred/presentation/main_game_screen/task_bloc/task_bloc.dart';
import 'package:betonred/widgets/app_bar/custom_app_bar.dart';
import 'package:betonred/widgets/custom_elevated_button.dart';
import 'package:betonred/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';

import '../../data/models/task_models/task_model.dart';
import '../../widgets/reward_screen.dart';

class MainGameScreen extends StatefulWidget {
  MainGameScreen({super.key});

  static Widget builder(BuildContext context) {
    return MainGameScreen();
  }

  @override
  State<MainGameScreen> createState() => _MainGameScreenState();
}

class _MainGameScreenState extends State<MainGameScreen> {
  bool isReward = false;
  late PotionModel curreModel;

  @override
  Widget build(BuildContext context) {
    final taskBloc = BlocProvider.of<TaskBloc>(context);
    return Stack(
      children: [
        Scaffold(
          extendBody: true,
          // extendBodyBehindAppBar: true,
          appBar: CustomAppBar(
            height: 80,
            title: Container(
              margin: EdgeInsets.only(left: 20, right: 100),
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 41),
                    width: 200,
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        LinearProgressIndicator(
                          minHeight: 14,
                          backgroundColor: appTheme.blueGray900,
                          color: appTheme.redA400,
                          value: 0,
                          borderRadius: BorderRadius.horizontal(
                            right: Radius.circular(9),
                          ),
                        ),
                        Container(
                          height: 8.v,
                          padding: EdgeInsets.only(right: 4),
                          child: BlocConsumer<ProgressBloc, ProgressState>(
                            listener: (context, state) {
                              if (state is ProgressLoadedState) {
                                if (state.isOpened) {
                                  setState(() {
                                    isReward = true;
                                  });
                                }
                              }
                            },
                            builder: (context, state) {
                              if (state is ProgressLoadedState) {
                                return LinearProgressIndicator(
                                  minHeight: 8,
                                  backgroundColor: Colors.transparent,
                                  color: appTheme.redA400,
                                  value: state.progress,
                                  borderRadius: BorderRadius.horizontal(
                                    right: Radius.circular(9),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    child: CustomImageView(
                      imagePath: ImageConstant.img14x3,
                      onTap: () {
                        NavigatorService.pushNamed(
                            AppRoutes.bookOfKnowledgeScreen);
                      },
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(
                  right: 10.h,
                ),
                child: CustomIconButton(
                  decoration: AppDecoration.buttonDecoration,
                  onTap: () {
                    NavigatorService.pushNamed(AppRoutes.settingsScreen);
                  },
                  height: 50,
                  width: 50,
                  child: Icon(
                    Icons.settings,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          body: Container(
            decoration: AppDecoration.gradientMain,
            child: Column(
              children: [
                _taskListWidget(context, taskBloc),
                _mainMenuPanel(
                  context,
                  mainText: 'To the potion room',
                  buttonText: 'Start brewing',
                  imagePath: ImageConstant.imgBoiler,
                  backgroundImagePath: ImageConstant.imgGradGreen,
                  onTap: () {
                    NavigatorService.pushNamed(AppRoutes.potionRoomScreen);
                  },
                ),
                SizedBox(
                  height: 5.v,
                ),
                BlocConsumer<HuntTimeCubit, HuntTimeState>(
                  listener: (context, state) {
                    // Вы можете добавить обработку событий, если это необходимо
                  },
                  builder: (context, state) {
                    if (state is HuntTimeUpdatedState) {
                      final minutes = (state.timeRemaining ~/ 60)
                          .toString()
                          .padLeft(2, '0');
                      final seconds =
                          (state.timeRemaining % 60).toString().padLeft(2, '0');
                      return _mainMenuPanel(
                        context,
                        mainText: 'Hunt for supplies',
                        buttonText: state.isSearchEnabled
                            ? 'Start hunt'
                            : 'In ${minutes}:$seconds',
                        imagePath: ImageConstant.imgTorch,
                        backgroundImagePath: ImageConstant.imgGradRed,
                        onTap: state.isSearchEnabled
                            ? () {
                              BlocProvider.of<HuntTimeCubit>(context)
                                    .startSearch();
                                NavigatorService.pushNamed(
                                    AppRoutes.huntForSuppliesScreen);
                              }
                            : null,
                        isDisabled: !state.isSearchEnabled,
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
                SizedBox(
                  height: 10.v,
                ),
                Flexible(child: _bottomImages(context)),
              ],
            ),
          ),
        ),
        if (isReward)
          FutureBuilder<PotionModel>(
            future: DataManager.getCurrentPotion(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final potion = snapshot.data!;
                return RewardScreen(
                        onTap: () {
                          setState(() {
                            isReward = false;
                          });
                        },
                        childWidget: Container(
                          height: 150,
                          child: CustomImageView(
                            imagePath: potion.image,
                          ),
                        ),
                        mainText: 'New potion recipe!',
                        secondText: 'You are going to be a master!',
                        character: Character.alchemist)
                    .build(context);
              } else
                return Container();
            },
          ),
      ],
    );
  }
}

Widget _taskListWidget(BuildContext context, TaskBloc taskBloc) {
  return Container(
    // decoration: AppDecoration.fillOnPrimary,
    padding: EdgeInsets.only(left: 20.h, right: 20.h, top: 20.v, bottom: 10.v),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                  snapshot.data?[index].count.toString() ?? '',
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

Widget _mainMenuPanel(
  BuildContext context, {
  required String imagePath,
  required String mainText,
  required String buttonText,
  required String backgroundImagePath,
  Function()? onTap,
  bool isDisabled = false,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20.h),
    child: Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          height: 150.v,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(backgroundImagePath), fit: BoxFit.fill),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  child: Text(
                    mainText,
                    style: theme.textTheme.titleMedium,
                  ),
                ),
                SizedBox(
                  height: 20.v,
                ),
                CustomElevatedButton(
                  text: buttonText,
                  width: 150,
                  height: 50,
                  isDisabled: isDisabled,
                  buttonTextStyle: CustomTextStyles.titleSmallButton,
                  buttonStyle: CustomButtonStyles.fillPrimaryTL10,
                  onPressed: () {
                    onTap?.call();
                  },
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 175,
          child: CustomImageView(
            width: 150,
            fit: BoxFit.fitHeight,
            imagePath: imagePath,
          ),
        )
      ],
    ),
  );
}

Widget _bottomImages(BuildContext context) {
  return Stack(
    alignment: Alignment.bottomCenter,
    children: [
      Align(
        alignment: Alignment.bottomLeft,
        child: CustomImageView(
          fit: BoxFit.fitWidth,
          imagePath: ImageConstant.imgQueenHalf,
        ),
      ),
      Align(
        alignment: Alignment.bottomRight,
        child: CustomImageView(
          fit: BoxFit.fitWidth,
          imagePath: ImageConstant.imgAlchemistHalf,
        ),
      ),
    ],
  );
}
