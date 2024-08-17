import 'package:crud_app/app/api/api_service.dart';
import 'package:crud_app/app/model/irem_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  var username = ''.obs;
  var items = <Item>[].obs;
  var isLoading = false.obs;

  final ApiService _apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    loadUserData();
    fetchItems();
  }

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    username.value = prefs.getString('username') ?? 'Guest';
  }

  Future<void> fetchItems() async {
    try {
      isLoading.value = true;
      final fetchedItems = await _apiService.fetchItems();
      items.assignAll(fetchedItems);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load items');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addItem(Item item) async {
    try {
      isLoading.value = true;
      final newItem = await _apiService.addItem(item);
      items.insert(0, newItem);
    } catch (e) {
      Get.snackbar('Error', 'Failed to add item');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateItem(int index, Item item) async {
    try {
      isLoading.value = true;
      await _apiService.updateItem(items[index].id!, item);
      items[index] = item;
    } catch (e) {
      Get.snackbar('Error', 'Failed to update item');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteItem(int index) async {
    try {
      isLoading.value = true;
      await _apiService.deleteItem(items[index].id!);
      items.removeAt(index);
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete item');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    Get.offAllNamed('/login');
  }
}
