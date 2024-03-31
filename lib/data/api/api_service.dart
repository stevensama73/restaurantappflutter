import 'dart:convert';

import 'package:restaurant_app2/data/model/detail_restaurant.dart';
import 'package:restaurant_app2/data/model/restaurant.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app2/data/model/review_restaurant.dart';
import 'package:restaurant_app2/data/model/search_restaurant.dart';

class ApiService {
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static final String pictureUrl = 'https://restaurant-api.dicoding.dev/images/large/';
  static final String _apiKey = '12345';

  Future<RestaurantResult> listRestaurants() async {
    final response = await http.get(Uri.parse(_baseUrl + 'list'));
    if (response.statusCode == 200){
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load list restaurants');
    }
  }

  Future<DetailRestaurantResult> detailRestaurant(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + 'detail/$id'));
    if (response.statusCode == 200) {
      return DetailRestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load detail restaurant');
    }
  }

  static Future<http.Response> reviewRestaurant(ReviewRestaurant reviewRestaurant) async {
    return await http.post(Uri.parse(_baseUrl + 'review'),
        headers: {
          'Content-Type': 'application/json',
          'X-Auth-Token': _apiKey
        },
        body: reviewRestaurantToJson(reviewRestaurant)
    );
  }

  Future<SearchRestaurantResult> searchRestaurants(String query) async {
    final response = await http.get(Uri.parse(_baseUrl + 'search?q=$query'));
    if (response.statusCode == 200){
      return SearchRestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to search restaurants');
    }
  }
}