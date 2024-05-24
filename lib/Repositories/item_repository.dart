
import 'package:dio/dio.dart';
import 'package:myfirstflutterproject/Common/constants.dart';
import 'package:myfirstflutterproject/Common/logger.dart';
import 'package:myfirstflutterproject/Services/api_service.dart';
import 'package:http/http.dart' as http;

import '../Models/item.dart';

class ItemRepository {
  final APIService _apiService = APIService();


  Future<List<Item>> getItems() async {

    Response response = await _apiService.get("/item/list");
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = response.data;
      List<Item> items = jsonResponse.map((item) => Item.fromJson(item))
          .toList();
      // Print the items for verification
      items.forEach((item) {
        print('Item: ${item.name}, Price: ${item.price}');
      });
      return items;
    } else {
      loggerNoStack.e("Failure in item_repository / getItems call");
      return  [];
    }
  }

}