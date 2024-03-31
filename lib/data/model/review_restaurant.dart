import 'dart:convert';

String reviewRestaurantToJson(ReviewRestaurant data) => json.encode(data.toJson());

class ReviewRestaurant {
  String id;
  String name;
  String review;

  ReviewRestaurant({
    required this.id,
    required this.name,
    required this.review
  });

  factory ReviewRestaurant.fromJson(Map<String, dynamic> json) => ReviewRestaurant(
    id: json["id"],
    name: json["name"],
    review: json["review"],
  );

  Map<String, String> toJson() => {
    "id": id,
    "name": name,
    "review": review
  };
}