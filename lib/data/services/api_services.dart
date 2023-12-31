import 'dart:convert';
import 'dart:io';

import 'package:restaurant_v2/data/models/customer_reviews/add_request_review_model.dart';
import 'package:restaurant_v2/data/models/customer_reviews/add_response_review_model.dart';
import 'package:restaurant_v2/data/models/restaurant_detail_model.dart';
import 'package:restaurant_v2/data/models/restaurant_model.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_v2/data/models/search_restaurant_model.dart';

import '../models/failure_exception.dart';

class ApiService {
  static const String baseUrl = 'https://restaurant-api.dicoding.dev/';
  final http.Client client;

  ApiService({http.Client? client}) : client = client ?? http.Client();

  Future<RestaurantModel> getRestaurant() async {
    try {
      final response = await client.get(
        Uri.parse("${baseUrl}list"),
      );
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return RestaurantModel.fromJson(data);
      } else {
        throw FailureException('Responses are not success');
      }
    } on SocketException {
      throw FailureException('No Internet Connection');
    } catch (e) {
      throw FailureException('Failed to load list of Restaurant');
    }
  }

  Future<RestaurantDetailModel> getRestaurantDetail(id) async {
    try {
      final response = await client.get(
        Uri.parse("${baseUrl}detail/$id"),
      );
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return RestaurantDetailModel.fromJson(data);
      } else {
        throw FailureException('Responses are not success');
      }
    } on SocketException {
      throw FailureException('No Internet Connection');
    } catch (e) {
      throw FailureException('Failed to load Restaurant');
    }
  }

  Future<SearchRestaurantModel> getSearchRestaurant(query) async {
    try {
      final response = await client.get(
        Uri.parse("${baseUrl}search?q=$query"),
      );
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return SearchRestaurantModel.fromJson(data);
      } else {
        throw FailureException('Responses are not success');
      }
    } on SocketException {
      throw FailureException('No Internet Connection');
    } catch (e) {
      throw FailureException('Failed to Search Restaurant');
    }
  }

  Future<AddResponseReviewsModel> postReview(
      AddRequestReviewsModel addRequestReviewsModel) async {
    try {
      final response = await http.post(
        Uri.parse('${baseUrl}review'),
        body: json.encode(addRequestReviewsModel.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        return AddResponseReviewsModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Gagal mengirim data ke server');
      }
    } catch (error) {
      throw Exception('Gagal mengirim data');
    }
  }
}
