// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AddBlogModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddBlogModel _$AddBlogModelFromJson(Map<String, dynamic> json) {
  return AddBlogModel(
    username: json['username'] as String,
    body: json['body'] as String,
    title: json['title'] as String,
    comments: json['comments'] as int,
    coverImage: json['coverImage'] as String,
    likes: json['likes'] as int,
    shares: json['shares'] as int,
  );
}

Map<String, dynamic> _$AddBlogModelToJson(AddBlogModel instance) =>
    <String, dynamic>{
      'coverImage': instance.coverImage,
      'title': instance.title,
      'body': instance.body,
      'username': instance.username,
      'likes': instance.likes,
      'shares': instance.shares,
      'comments': instance.comments,
    };
