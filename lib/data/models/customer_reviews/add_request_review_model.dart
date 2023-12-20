class AddRequestReviewsModel {
  String id;
  String name;
  String review;

  AddRequestReviewsModel({
    required this.id,
    required this.name,
    required this.review,
  });

  factory AddRequestReviewsModel.fromJson(Map<String, dynamic> json) =>
      AddRequestReviewsModel(
        id: json["id"],
        name: json["name"],
        review: json["review"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "review": review,
      };
}
