// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProfileModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) {
  return ProfileModel(
    name: json['name'] as String,
    username: json['username'] as String,
    profession: json['profession'] as String,
    DOB: json['DOB'] as String,
    titleline: json['titleline'] as String,
    about: json['about'] as String,
    contactnumber: json['contactnumber'] as String,
  );
}

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'username': instance.username,
      'profession': instance.profession,
      'DOB': instance.DOB,
      'titleline': instance.titleline,
      'about': instance.about,
      'contactnumber': instance.contactnumber,
    };
