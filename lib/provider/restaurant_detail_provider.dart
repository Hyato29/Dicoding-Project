import 'package:flutter/material.dart';
import 'package:restaurant_v2/data/models/loading_state.dart';
import 'package:restaurant_v2/data/models/restaurant_detail_model.dart';
import 'package:restaurant_v2/data/services/api_services.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  String id;

  RestaurantDetailProvider({required this.apiService, required this.id}) {
    _fetchAllRestaurant();
  }

  late RestaurantDetailModel _restauranDetailResult;
  late LoadingState _state;
  String _message = "";

  String get message => _message;

  RestaurantDetailModel get restauranDetailResult => _restauranDetailResult;

  LoadingState get state => _state;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = LoadingState.loading;
      notifyListeners();
      final restaurantDetail = await apiService.getRestaurantDetail(id);
      if (restaurantDetail.restaurant.id.isEmpty) {
        _state = LoadingState.noData;
        notifyListeners();
        return _message = "Empty Data";
      } else {
        _state = LoadingState.loaded;
        notifyListeners();
        return _restauranDetailResult = restaurantDetail;
      }
    } catch (e) {
      _state = LoadingState.error;
      notifyListeners();
      return _message = "Failed Load Data";
    }
  }
}
