import 'package:crud_app/app/model/irem_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<Item>> fetchItems() async {
    final response = await http.get(Uri.parse('$baseUrl/posts'));
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((json) => Item.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load items');
    }
  }

  Future<Item> addItem(Item item) async {
    final response = await http.post(
      Uri.parse('$baseUrl/posts'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(item.toJson()),
    );
    if (response.statusCode == 201) {
      return Item.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add item');
    }
  }

  Future<void> updateItem(int id, Item item) async {
    final response = await http.put(
      Uri.parse('$baseUrl/posts/$id'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(item.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update item');
    }
  }

  Future<void> deleteItem(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/posts/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete item');
    }
  }
}
