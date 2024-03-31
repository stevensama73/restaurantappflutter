import 'package:flutter/material.dart';
import 'package:restaurant_app2/data/api/api_service.dart';
import 'package:restaurant_app2/data/model/detail_restaurant.dart';
import 'package:restaurant_app2/utils/result_state.dart';

class DetailRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  final String? id;

  DetailRestaurantProvider({required this.apiService, this.id}) {
    _fetchDetailRestaurant(id!);
  }

  late DetailRestaurantResult _detailRestaurantResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;
  DetailRestaurantResult get detailRestaurantResult => _detailRestaurantResult;
  ResultState get state => _state;

  Future<dynamic> _fetchDetailRestaurant(String id) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final detailRestaurant = await apiService.detailRestaurant(id);
      if (detailRestaurant.restaurant == null) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Data kosong';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _detailRestaurantResult = detailRestaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Periksa kembali apakah jaringan tersedia';
    }
  }
}