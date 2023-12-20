class SearchRestaurantModel {
  bool error;
  int founded;
  List<SearchRestaurant> restaurants;

  SearchRestaurantModel({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory SearchRestaurantModel.fromJson(Map<String, dynamic> json) =>
      SearchRestaurantModel(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<SearchRestaurant>.from(
            json["restaurants"].map((x) => SearchRestaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "founded": founded,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}

class SearchRestaurant {
  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;

  SearchRestaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  factory SearchRestaurant.fromJson(Map<String, dynamic> json) => SearchRestaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
      };
}
