import 'package:flutter/material.dart';
import 'package:restaurant_v2/data/models/loading_state.dart';
import 'package:restaurant_v2/data/models/restaurant_model.dart';
import 'package:restaurant_v2/data/services/api_services.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    _fetchAllRestaurant();
  }

  late RestaurantModel _restauranResult;
  late LoadingState _state;
  String _message = "";

  String get message => _message;

  RestaurantModel get restauranResult => _restauranResult;

  LoadingState get state => _state;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = LoadingState.loading;
      notifyListeners();
      final restaurant = await apiService.getRestaurant();
      if (restaurant.restaurants.isEmpty) {
        _state = LoadingState.noData;
        notifyListeners();
        return _message = "Empty Data";
      } else {
        _state = LoadingState.loaded;
        notifyListeners();
        return _restauranResult = restaurant;
      }
    } catch (e) {
      _state = LoadingState.error;
      notifyListeners();
      return _message = "Failed Load Data or No Internet Connection";
    }
  }
}
