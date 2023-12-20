import 'package:flutter/foundation.dart';
import 'package:restaurant_v2/data/db/database_helper.dart';
import 'package:restaurant_v2/data/models/loading_state.dart';
import 'package:restaurant_v2/data/models/restaurant_detail_model.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getFavorites();
  }

  late LoadingState _state = LoadingState.initialData;
  LoadingState get state => _state;

  String _message = '';
  String get message => _message;

  List<RestaurantDetailModel> _favorites = [];
  List<RestaurantDetailModel> get favorites => _favorites;

  void _getFavorites() async {
    _favorites = await databaseHelper.getFavorites();
    if (_favorites.isNotEmpty) {
      _state = LoadingState.loaded;
    } else {
      _state = LoadingState.noData;
      _message = 'Empty Data';
    }
    notifyListeners();
  }

  void addFavorites(RestaurantDetailModel restaurantModel) async {
    try {
      await databaseHelper.insertFavorite(restaurantModel);
      _getFavorites();
    } catch (e) {
      _state = LoadingState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorites(String id) async {
    final favoriteRestaurant = await databaseHelper.getFavoriteById(id);
    return favoriteRestaurant.isNotEmpty;
  }

  void removeFavorites(String id) async {
    try {
      await databaseHelper.removeFavorite(id);
      _getFavorites();
    } catch (e) {
      _state = LoadingState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}
