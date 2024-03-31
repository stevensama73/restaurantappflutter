import 'dart:convert';

import 'package:restaurant_app2/data/model/detail_restaurant.dart';
import 'package:restaurant_app2/data/model/restaurant.dart';
import 'package:restaurant_app2/data/model/review_restaurant.dart';
import 'package:restaurant_app2/data/model/search_restaurant.dart';
import 'package:http/http.dart' as http;

class DummyApiService {
  final String baseUrl = 'https://restaurant-api.dicoding.dev/';
  final String apiKey = '12345';

  final http.Client client;
  DummyApiService(this.client);

  Future<RestaurantResult> listRestaurants() async {
    final response = await client.get(Uri.parse(baseUrl + 'list'));
    if (response.statusCode == 200){
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load list restaurants');
    }
  }

  Future<DetailRestaurantResult> detailRestaurant(String id) async {
    final response = await client.get(Uri.parse(baseUrl + 'detail/$id'));
    if (response.statusCode == 200) {
      return DetailRestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load detail restaurant');
    }
  }

  Future<http.Response> reviewRestaurant(ReviewRestaurant reviewRestaurant) async {
    return await client.post(Uri.parse(baseUrl + 'review'),
        headers: {
          'Content-Type': 'application/json',
          'X-Auth-Token': apiKey
        },
        body: reviewRestaurantToJson(reviewRestaurant)
    );
  }

  Future<SearchRestaurantResult> searchRestaurants(String query) async {
    final response = await client.get(Uri.parse(baseUrl + 'search?q=$query'));
    if (response.statusCode == 200){
      return SearchRestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to search restaurants');
    }
  }
}