import 'package:json_annotation/json_annotation.dart';

part 'AddBlogModel.g.dart';

@JsonSerializable()
class AddBlogModel {
  String coverImage, title, body, username;
  int likes, shares, comments;

  AddBlogModel({this.username, this.body, this.title, this.comments, this.coverImage, this.likes, this.shares});

  factory AddBlogModel.fromJson(Map<String, dynamic> json) => _$AddBlogModelFromJson(json);
  Map<String, dynamic> toJson() => _$AddBlogModelToJson(this);
}
