import 'package:json_annotation/json_annotation.dart';

part 'ProfileModel.g.dart';

@JsonSerializable()
class ProfileModel {
  String name, username, profession, DOB, titleline, about, contactnumber;

  ProfileModel({this.name, this.username, this.profession, this.DOB, this.titleline, this.about, this.contactnumber});

  factory ProfileModel.fromJson(Map<String, dynamic> json) => _$ProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}
