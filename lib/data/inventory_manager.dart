import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/inventory_item_model/inventory_item_model.dart';

class InventoryManager {
  static const _key = 'inventory';

  static Future<List<InventoryItemModel>> getInventory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_key);
    if (data != null) {
      Iterable decoded = jsonDecode(data);
      return decoded.map((item) => InventoryItemModel.fromJson(item)).toList();
    }
    return [];
  }

  static Future<void> saveInventory(List<InventoryItemModel> inventory) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonData = inventory.map((item) => item.toJson()).toList();
    await prefs.setString(_key, jsonEncode(jsonData));
  }

  static Future<void> addItemToInventory(InventoryItemModel newItem) async {
    List<InventoryItemModel> inventory = await getInventory();
    bool found = false;
    for (int i = 0; i < inventory.length; i++) {
      if (inventory[i].supply.id == newItem.supply.id) {
        inventory[i].quantity += newItem.quantity;
        found = true;
        print('found');
        print(newItem.supply.name);
        break;
      }
    }
    if (!found) {
      inventory.add(newItem);
    }
    await saveInventory(inventory);
  }

  static Future<void> useItemFromInventory(InventoryItemModel item) async {
    List<InventoryItemModel> inventory = await getInventory();
    int index = inventory.indexWhere((element) => element.supply.id == item.supply.id);
    if (index != -1) {
      inventory[index].quantity--;
      if (inventory[index].quantity < 1) {
        inventory.removeAt(index);
      }
      await saveInventory(inventory);
    }
  }

  static  Future<void> removeItemFromInventory(InventoryItemModel item) async {
    List<InventoryItemModel> inventory = await getInventory();
    inventory.removeWhere((element) => element.supply.id == item.supply.id);
    await saveInventory(inventory);
  }
}
