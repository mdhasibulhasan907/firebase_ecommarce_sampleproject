// To parse this JSON data, do
//
//     final usersModel = usersModelFromJson(jsonString);

import 'dart:convert';

UsersModel usersModelFromJson(String str) => UsersModel.fromJson(json.decode(str));

String usersModelToJson(UsersModel data) => json.encode(data.toJson());

class UsersModel {
    String? uid;
    String? email;
    String? name;
    String? gender;
    String? address;
    String? dob;

    UsersModel({
        this.uid,
        this.email,
        this.name,
        this.gender,
        this.address,
        this.dob,
    });

    factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
        uid: json["uid"],
        email: json["email"],
        name: json["name"],
        gender: json["gender"],
        address: json["address"],
        dob: json["dob"],
    );

    Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "name": name,
        "gender": gender,
        "address": address,
        "dob": dob,
    };
}
