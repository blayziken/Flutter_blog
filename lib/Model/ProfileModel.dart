import 'package:flutter/material.dart';

part 'profileModel.g.dart';

@JsonSerializable()
class ProfileModel {
  String name, username, profession, DOB, titleline, about, contactnumber;

  ProfileModel({this.name, this.username, this.profession, this.DOB, this.titleline, this.about, this.contactnumber});

  factory ProfileModel.fromJson(Map<String, dynamic> json) => _$ProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}
