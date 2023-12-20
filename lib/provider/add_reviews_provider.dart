import 'package:flutter/material.dart';
import 'package:restaurant_v2/data/models/customer_reviews/add_request_review_model.dart';
import 'package:restaurant_v2/data/models/customer_reviews/add_response_review_model.dart';
import 'package:restaurant_v2/data/models/loading_state.dart';
import 'package:restaurant_v2/data/models/restaurant_detail_model.dart';
import 'package:restaurant_v2/data/services/api_services.dart';

class AddReviewsProvider extends ChangeNotifier {
  final ApiService apiService;
  String id;
  AddReviewsProvider({required this.apiService, required this.id}) {
    fetchAllRestaurant();
  }

  late AddResponseReviewsModel _reviews;
  AddResponseReviewsModel get reviews => _reviews;

  late RestaurantDetailModel _restauranReviews;
  RestaurantDetailModel get restauranReviews => _restauranReviews;

  late LoadingState _state = LoadingState.initialData;
  LoadingState get state => _state;

  String get message => _message;
  String _message = "";

  Future<dynamic> postReview(AddRequestReviewsModel reviewModel) async {
    try {
      _state = LoadingState.loading;
      notifyListeners();
      final AddResponseReviewsModel addResponse =
          await apiService.postReview(reviewModel);
      if (addResponse.customerReviews.isEmpty) {
        _state = LoadingState.noData;
        notifyListeners();
        return _message = "Nothing Reviews";
      } else {
        _state = LoadingState.loaded;
        notifyListeners();
        return _reviews = addResponse;
      }
    } catch (error) {
      _state = LoadingState.error;
      notifyListeners();
      return _message = "Failed to send review";
    }
  }

  Future<dynamic> fetchAllRestaurant() async {
    try {
      _state = LoadingState.loading;
      notifyListeners();
      final reviews = await apiService.getRestaurantDetail(id);
      if (reviews.restaurant.id.isEmpty) {
        _state = LoadingState.noData;
        notifyListeners();
        return _message = "Empty Data";
      } else {
        _state = LoadingState.loaded;
        notifyListeners();
        return _restauranReviews = reviews;
      }
    } catch (e) {
      _state = LoadingState.error;
      notifyListeners();
      return _message = "Failed Load Data";
    }
  }
}
