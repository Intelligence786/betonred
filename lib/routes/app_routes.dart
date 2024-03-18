import 'package:betonred/presentation/book_of_knowledge_screen/book_of_knowledge_screen.dart';
import 'package:betonred/presentation/hunt_for_supplies_screen/hunt_for_supplies_screen.dart';
import 'package:betonred/presentation/main_game_screen/main_game_screen.dart';
import 'package:betonred/presentation/onboarding_screen/onboarding_screen.dart';
import 'package:betonred/presentation/potion_room_screen/potion_room_screen.dart';
import 'package:betonred/presentation/settings_screen/settings_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String initialRoute = '/initialRoute';
  static const String onboardingScreen = '/onboardingScreen';
  static const String mainGameScreen = '/mainGameScreen';
  static const String settingsScreen = '/settingsScreen';
  static const String bookOfKnowledgeScreen = '/bookOfKnowledgeScreen';
  static const String huntForSuppliesScreen = '/huntForSuppliesScreen';
  static const String potionRoomScreen = '/potionRoomScreen';

  static Map<String, WidgetBuilder> get routes => {
        onboardingScreen: OnboardingScreen.builder,
        mainGameScreen: MainGameScreen.builder,
        bookOfKnowledgeScreen: BookOfKnowledgeScreen.builder,
        settingsScreen: SettingsScreen.builder,
        huntForSuppliesScreen: HuntForSuppliesScreen.builder,
        potionRoomScreen: PotionRoomScreen.builder,
      };
}
