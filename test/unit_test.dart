import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_v2/data/models/restaurant_detail_model.dart';
import 'package:restaurant_v2/data/models/restaurant_model.dart';
import 'package:restaurant_v2/data/models/search_restaurant_model.dart';
import 'package:restaurant_v2/data/services/api_services.dart';

void main() {
  
  group('ApiService Tests', () {
    late ApiService apiService;

    setUp(() {
      apiService = ApiService();
    });

    test('Test getRestaurant success', () async {
      final result = await apiService.getRestaurant();
      expect(result, isA<RestaurantModel>());
    });

    test('Test getRestaurantDetail success', () async {
      const restaurantId =
          'rqdv5juczeskfw1e867';
      final result = await apiService.getRestaurantDetail(restaurantId);
      expect(result, isA<RestaurantDetailModel>());
    });

    test('Test getSearchRestaurant success', () async {
      const query = 'Melting';
      final result = await apiService.getSearchRestaurant(query);
      expect(result, isA<SearchRestaurantModel>());
    });
  });

  // Test Json Parsing
  test('Json parsing should work correctly for RestaurantModel', () {
    // Arrange
    Map<String, dynamic> jsonData = {
      'error': false,
      'message': 'Success',
      'count': 1,
      'restaurants': [
        {
          'id': 'rqdv5juczeskfw1e867',
          'name': 'Melting Pot',
          'description':
              'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.',
          'pictureId': '14',
          'city': 'Medan',
          'rating': 4.2,
        },
      ],
    };

    // Act
    RestaurantModel restaurantModel = RestaurantModel.fromJson(jsonData);

    // Assert
    expect(restaurantModel.error, false);
    expect(restaurantModel.message, 'Success');
    expect(restaurantModel.count, 1);
    expect(restaurantModel.restaurants.length, 1);

    expect(restaurantModel.restaurants[0].id, 'rqdv5juczeskfw1e867');
    expect(restaurantModel.restaurants[0].name, 'Melting Pot');
    expect(restaurantModel.restaurants[0].description,
        'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.');
    expect(restaurantModel.restaurants[0].pictureId, '14');
    expect(restaurantModel.restaurants[0].city, 'Medan');
    expect(restaurantModel.restaurants[0].rating, 4.2);
  });
}
