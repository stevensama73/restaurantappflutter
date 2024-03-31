import 'package:flutter/material.dart';
import 'package:restaurant_app2/data/api/api_service.dart';
import 'package:restaurant_app2/data/model/restaurant.dart';
import 'package:restaurant_app2/data/model/search_restaurant.dart';
import 'package:restaurant_app2/utils/result_state.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
      _fetchAllRestaurants();
  }

  late RestaurantResult _restaurantResult;
  late SearchRestaurantResult _searchRestaurantResult;
  late ResultState _state;
  String _message = '';
  late String _id;
  bool _search = false;

  set restaurantId(String id) {
    this._id = id;
    notifyListeners();
  }

  String get message => _message;
  RestaurantResult get restaurantResult => _restaurantResult;
  SearchRestaurantResult get searchRestaurantResult => _searchRestaurantResult;
  ResultState get state => _state;
  bool get search => _search;
  String get id => _id;

  void checkQuery(String value) {
    if (value.length == 0) {
      _search = false;
      notifyListeners();
    } else {
      _fetchSearchRestaurants(value);
      _search = true;
      notifyListeners();
    }
  }

  Future<dynamic> _fetchAllRestaurants() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await apiService.listRestaurants();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Data kosong';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Periksa kembali apakah jaringan tersedia';
    }
  }

  Future<dynamic> _fetchSearchRestaurants(String query) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final searchRestaurants = await apiService.searchRestaurants(query);
      if (searchRestaurants.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Data yang dicari tidak ada';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _searchRestaurantResult = searchRestaurants;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Periksa kembali apakah jaringan tersedia';
    }
  }
}