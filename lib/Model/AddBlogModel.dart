import 'package:json_annotation/json_annotation.dart';

part 'AddBlogModel.g.dart';

@JsonSerializable()
class AddBlogModel {
  @JsonKey(name: "_id") // using this, because dart can't recognise 'String _id'
  String id;
  String coverImage;
  String title;
  String body;
  String username;
  int likes, shares, comments;

  AddBlogModel({
    this.username,
    this.body,
    this.title,
    this.comments,
    this.coverImage,
    this.likes,
    this.shares,
  });

  factory AddBlogModel.fromJson(Map<String, dynamic> json) => _$AddBlogModelFromJson(json);
  Map<String, dynamic> toJson() => _$AddBlogModelToJson(this);
}
