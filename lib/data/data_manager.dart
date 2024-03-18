import 'package:betonred/core/app_export.dart';
import 'package:betonred/data/models/potion_model/potion_model.dart';
import 'package:betonred/data/models/supply_model/supply_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataManager {
  static List<SupplyModel> suppliesList = [
    SupplyModel(id: 1, name: 'sup_1', image: ImageConstant.imageSup1),
    SupplyModel(id: 2, name: 'sup_2', image: ImageConstant.imageSup2),
    SupplyModel(id: 3, name: 'sup_3', image: ImageConstant.imageSup3),
    SupplyModel(id: 4, name: 'sup_4', image: ImageConstant.imageSup4),
    SupplyModel(id: 5, name: 'sup_5', image: ImageConstant.imageSup5),
    SupplyModel(id: 6, name: 'sup_6', image: ImageConstant.imageSup6),
    SupplyModel(id: 7, name: 'sup_7', image: ImageConstant.imageSup7),
    SupplyModel(id: 8, name: 'sup_8', image: ImageConstant.imageSup8),
    SupplyModel(id: 9, name: 'sup_9', image: ImageConstant.imageSup9),
    SupplyModel(id: 10, name: 'sup_10', image: ImageConstant.imageSup10),
    SupplyModel(id: 11, name: 'sup_11', image: ImageConstant.imageSup11),
    SupplyModel(id: 12, name: 'sup_12', image: ImageConstant.imageSup12),
    SupplyModel(id: 13, name: 'sup_13', image: ImageConstant.imageSup13),
    SupplyModel(id: 14, name: 'sup_14', image: ImageConstant.imageSup14),
    SupplyModel(id: 15, name: 'sup_15', image: ImageConstant.imageSup15),
    SupplyModel(id: 16, name: 'sup_16', image: ImageConstant.imageSup16),
    SupplyModel(id: 17, name: 'sup_17', image: ImageConstant.imageSup17),
    SupplyModel(id: 18, name: 'sup_18', image: ImageConstant.imageSup18),
    SupplyModel(id: 19, name: 'sup_19', image: ImageConstant.imageSup19),
    SupplyModel(id: 20, name: 'sup_20', image: ImageConstant.imageSup20),
    SupplyModel(id: 21, name: 'sup_21', image: ImageConstant.imageSup21),
    SupplyModel(id: 22, name: 'sup_22', image: ImageConstant.imageSup22),
    SupplyModel(id: 23, name: 'sup_23', image: ImageConstant.imageSup23),
    SupplyModel(id: 24, name: 'sup_24', image: ImageConstant.imageSup24),
    SupplyModel(id: 25, name: 'sup_25', image: ImageConstant.imageSup25),
    SupplyModel(id: 26, name: 'sup_26', image: ImageConstant.imageSup26),
    SupplyModel(id: 27, name: 'sup_27', image: ImageConstant.imageSup27),
    SupplyModel(id: 28, name: 'sup_28', image: ImageConstant.imageSup28),
  ];
  static List<PotionModel> potionsList = [
    PotionModel(
      name: 'potion_1',
      image: ImageConstant.imagePotion1,
      suppliesModels: [
        suppliesList[0],
        suppliesList[1],
        suppliesList[2],
      ],
      isOpened: true,
    ),
    PotionModel(
      name: 'potion_2',
      image: ImageConstant.imagePotion2,
      suppliesModels: [
        suppliesList[3],
        suppliesList[4],
        suppliesList[5],
      ],
      isOpened: true,
    ),
    PotionModel(
      name: 'potion_3',
      image: ImageConstant.imagePotion3,
      suppliesModels: [
        suppliesList[6],
        suppliesList[7],
        suppliesList[8],
      ],
    ),
    PotionModel(
      name: 'potion_4',
      image: ImageConstant.imagePotion4,
      suppliesModels: [
        suppliesList[9],
        suppliesList[10],
        suppliesList[11],
      ],
    ),
    PotionModel(
      name: 'potion_5',
      image: ImageConstant.imagePotion5,
      suppliesModels: [
        suppliesList[12],
        suppliesList[13],
        suppliesList[14],
      ],
    ),
    PotionModel(
      name: 'potion_6',
      image: ImageConstant.imagePotion6,
      suppliesModels: [
        suppliesList[15],
        suppliesList[16],
        suppliesList[17],
      ],
    ),
    PotionModel(
      name: 'potion_7',
      image: ImageConstant.imagePotion7,
      suppliesModels: [
        suppliesList[18],
        suppliesList[19],
        suppliesList[20],
      ],
    ),
    PotionModel(
      name: 'potion_8',
      image: ImageConstant.imagePotion8,
      suppliesModels: [
        suppliesList[21],
        suppliesList[22],
        suppliesList[23],
      ],
    ),
    PotionModel(
      name: 'potion_9',
      image: ImageConstant.imagePotion9,
      suppliesModels: [
        suppliesList[24],
        suppliesList[25],
        suppliesList[26],
      ],
    ),
    PotionModel(
      name: 'potion_10',
      image: ImageConstant.imagePotion10,
      suppliesModels: [
        suppliesList[27],
        suppliesList[9],
        suppliesList[19],
      ],
    ),
    PotionModel(
      name: 'potion_11',
      image: ImageConstant.imagePotion11,
      suppliesModels: [
        suppliesList[10],
        suppliesList[7],
        suppliesList[12],
      ],
    ),
    PotionModel(
      name: 'potion_12',
      image: ImageConstant.imagePotion12,
      suppliesModels: [
        suppliesList[1],
        suppliesList[13],
        suppliesList[4],
      ],
    ),
    PotionModel(
      name: 'potion_13',
      image: ImageConstant.imagePotion13,
      suppliesModels: [
        suppliesList[2],
        suppliesList[6],
        suppliesList[18],
      ],
    ),
    PotionModel(
      name: 'potion_14',
      image: ImageConstant.imagePotion14,
      suppliesModels: [
        suppliesList[4],
        suppliesList[21],
        suppliesList[8],
      ],
    ),
    PotionModel(
      name: 'potion_15',
      image: ImageConstant.imagePotion15,
      suppliesModels: [
        suppliesList[15],
        suppliesList[5],
        suppliesList[26],
      ],
    ),
    PotionModel(
      name: 'potion_16',
      image: ImageConstant.imagePotion16,
      suppliesModels: [
        suppliesList[2],
        suppliesList[24],
        suppliesList[23],
      ],
    ),
  ];

  static dynamic findPotionsBySupplies(
      SupplyModel supply1, SupplyModel supply2, SupplyModel supply3) {
    List<PotionModel> foundPotions = [];

    for (var potion in potionsList) {
      bool isMatched = potion.suppliesModels.length == 3 &&
          potion.suppliesModels[0].id == supply1.id &&
          potion.suppliesModels[1].id == supply2.id &&
          potion.suppliesModels[2].id == supply3.id;

      if (isMatched) {
        foundPotions.add(potion);
        return foundPotions[0];
      }
    }

    return null;
  }

  static const _searchButtonKey = 'search_button_state';
  static const _lastUpdateTimeKey = 'last_update_time';
  static const _potionIndexKey = 'potion_index_key';
  static const _progressKey = 'progress_key';

  static Future<PotionModel> getCurrentPotion() async
  {
    int index = await getPotionIndexKey();

    return potionsList[index];
  }

  static Future<void> setSearchButtonState(bool isEnabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_searchButtonKey, isEnabled);
  }

  static Future<bool> getSearchButtonState() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_searchButtonKey) ?? true;
  }

  static Future<DateTime> getLastUpdateTime() async {
    final prefs = await SharedPreferences.getInstance();
    final timestamp = prefs.getInt(_lastUpdateTimeKey);
    return timestamp != null
        ? DateTime.fromMillisecondsSinceEpoch(timestamp)
        : DateTime.now();
  }

  static Future<void> setLastUpdateTime(DateTime time) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_lastUpdateTimeKey, time.millisecondsSinceEpoch);
  }

  static Future<int> getPotionIndexKey() async {
    final prefs = await SharedPreferences.getInstance();
    int indexKey = 1;
    if (prefs.containsKey(_potionIndexKey))
      indexKey = await prefs.getInt(_potionIndexKey)!;
    return indexKey;
  }

  static Future<void> setPotionIndexKey() async {
    final prefs = await SharedPreferences.getInstance();
    int indexKey = await getPotionIndexKey();
    await prefs.setInt(_potionIndexKey, indexKey + 1);
  }

  static Future<void> setProgress(double progress) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setDouble(_progressKey, progress);
  }

  static Future<double> getProgress() async {
    final prefs = await SharedPreferences.getInstance();
    double progressSaved = 0;
    if (prefs.containsKey(_progressKey))
      progressSaved = await prefs.getDouble(_progressKey)!;

    return progressSaved;
  }
}
