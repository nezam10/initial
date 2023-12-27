// To parse this JSON data, do
//
//     final jsonPlaceHolderViewModel = jsonPlaceHolderViewModelFromJson(jsonString);

import 'dart:convert';

List<JsonPlaceHolderViewModel> jsonPlaceHolderViewModelFromJson(dynamic str) =>
    List<JsonPlaceHolderViewModel>.from(
        (str as List<dynamic>).map((x) => JsonPlaceHolderViewModel.fromJson(x)));

String jsonPlaceHolderViewModelToJson(List<JsonPlaceHolderViewModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JsonPlaceHolderViewModel {
  final int? userId;
  final int? id;
  final String? title;
  final String? body;

  JsonPlaceHolderViewModel({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  factory JsonPlaceHolderViewModel.fromJson(Map<String, dynamic> json) =>
      JsonPlaceHolderViewModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
      };
}
