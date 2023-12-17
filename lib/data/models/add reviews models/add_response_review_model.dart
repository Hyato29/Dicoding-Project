class AddResponseReviewsModel {
    bool error;
    String message;
    List<CustomerReview> customerReviews;

    AddResponseReviewsModel({
        required this.error,
        required this.message,
        required this.customerReviews,
    });

    factory AddResponseReviewsModel.fromJson(Map<String, dynamic> json) => AddResponseReviewsModel(
        error: json["error"],
        message: json["message"],
        customerReviews: List<CustomerReview>.from(json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "customerReviews": List<dynamic>.from(customerReviews.map((x) => x.toJson())),
    };
}

class CustomerReview {
    String name;
    String review;
    Date date;

    CustomerReview({
        required this.name,
        required this.review,
        required this.date,
    });

    factory CustomerReview.fromJson(Map<String, dynamic> json) => CustomerReview(
        name: json["name"],
        review: json["review"],
        date: dateValues.map[json["date"]]!,
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "review": review,
        "date": dateValues.reverse[date],
    };
}

enum Date {
    THE_13_NOVEMBER_2019,
    THE_15_DESEMBER_2023
}

final dateValues = EnumValues({
    "13 November 2019": Date.THE_13_NOVEMBER_2019,
    "15 Desember 2023": Date.THE_15_DESEMBER_2023
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
