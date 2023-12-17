import 'package:flutter/material.dart';
import 'package:restaurant_v2/data/models/loading_state.dart';
import 'package:restaurant_v2/data/models/search_restaurant_model.dart';
import 'package:restaurant_v2/data/services/api_services.dart';

class SearchRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchRestaurantProvider({required this.apiService});

  late SearchRestaurantModel _searchRestaurantResult =
      SearchRestaurantModel(error: true, founded: 0, restaurants: []);
  SearchRestaurantModel get searchRestauranResult => _searchRestaurantResult;

  String _message = "";
  String get message => _message;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  late LoadingState _state;
  LoadingState get state => _state;

  Future<dynamic> searchRestaurant(String query) async {
    try {
      _state = LoadingState.loading;
      _isLoading = true;
      notifyListeners();
      final searchRestaurant = await apiService.getSearchRestaurant(query);
      if (searchRestaurant.restaurants.isEmpty) {
        _state = LoadingState.noData;
        _isLoading = false;
        notifyListeners();
        return _message = "Restaurant not Found!";
      } else {
        _state = LoadingState.loaded;
        _isLoading = false;
        notifyListeners();
        return _searchRestaurantResult = searchRestaurant;
      }
    } catch (e) {
      _state = LoadingState.error;
      _isLoading = false;
      notifyListeners();
      return _message = "Failed Load Data or No Internet Connection";
    }
  }
}
