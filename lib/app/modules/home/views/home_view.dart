import 'package:crud_app/app/model/irem_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              controller.logout();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.items.isEmpty) {
                return const Center(child: Text('No items found.'));
              }
              return ListView.builder(
                itemCount: controller.items.length,
                itemBuilder: (context, index) {
                  final item = controller.items[index];
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      title: Text(
                        item.title,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(item.body),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _showEditItemDialog(context, index, item),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _showDeleteConfirmationDialog(context, index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        _showAddItemDialog(context);
      }, child: Icon(Icons.add),),
    );
  }

  void _showAddItemDialog(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController bodyController = TextEditingController();

    Get.defaultDialog(
      title: 'Add Item',
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: bodyController,
              decoration: const InputDecoration(
                labelText: 'Body',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      textConfirm: 'Add',
      textCancel: 'Cancel',
      confirmTextColor: Colors.white,
      onConfirm: () {
        if (titleController.text.isNotEmpty && bodyController.text.isNotEmpty) {
          final newItem = Item(title: titleController.text, body: bodyController.text);
          controller.addItem(newItem);
          Get.back();
        } else {
          Get.snackbar('Error', 'All fields are required');
        }
      },
    );
  }

  void _showEditItemDialog(BuildContext context, int index, Item item) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController bodyController = TextEditingController();
    titleController.text = item.title;
    bodyController.text = item.body;

    Get.defaultDialog(
      title: 'Edit Item',
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: bodyController,
              decoration: const InputDecoration(
                labelText: 'Body',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      textConfirm: 'Update',
      textCancel: 'Cancel',
      confirmTextColor: Colors.white,
      onConfirm: () {
        if (titleController.text.isNotEmpty && bodyController.text.isNotEmpty) {
          final updatedItem = Item(id: item.id, title: titleController.text, body: bodyController.text);
          controller.updateItem(index, updatedItem);
          Get.back();
        } else {
          Get.snackbar('Error', 'All fields are required');
        }
      },
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, int index) {
    Get.defaultDialog(
      title: 'Delete Item',
      content: const Text('Are you sure you want to delete this item?'),
      textConfirm: 'Delete',
      textCancel: 'Cancel',
      confirmTextColor: Colors.white,
      onConfirm: () {
        controller.deleteItem(index);
        Get.back();
      },
    );
  }
}
