// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat_app/constants/FirestoreConstants.dart';
import 'package:flutter/foundation.dart';

class ChatUser {
  final String id;
  final String photoUrl;
  final String displayName;
  final String phoneNumber;
  final String aboutMe;
  ChatUser({
    required this.id,
    required this.photoUrl,
    required this.displayName,
    required this.phoneNumber,
    required this.aboutMe,
  });

  ChatUser copyWith({
    String? id,
    String? photoUrl,
    String? displayName,
    String? phoneNumber,
    String? aboutMe,
  }) {
    return ChatUser(
      id: id ?? this.id,
      photoUrl: photoUrl ?? this.photoUrl,
      displayName: displayName ?? this.displayName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      aboutMe: aboutMe ?? this.aboutMe,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'photoUrl': photoUrl,
      'displayName': displayName,
      'phoneNumber': phoneNumber,
      'aboutMe': aboutMe,
    };
  }

  factory ChatUser.fromMap(Map<String, dynamic> map) {
    return ChatUser(
      id: map['id'] as String,
      photoUrl: map['photoUrl'] as String,
      displayName: map['displayName'] as String,
      phoneNumber: map['phoneNumber'] as String,
      aboutMe: map['aboutMe'] as String,
    );
  }

  factory ChatUser.fromDocument(DocumentSnapshot snapshot) {
    String photoUrl = "";
    String nickname = "";
    String phoneNumber = "";
    String aboutMe = "";

    try {
      photoUrl = snapshot.get(FirestoreConstants.photoUrl);
      nickname = snapshot.get(FirestoreConstants.displayName);
      phoneNumber = snapshot.get(FirestoreConstants.phoneNumber);
      aboutMe = snapshot.get(FirestoreConstants.aboutMe);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return ChatUser(
        id: snapshot.id,
        photoUrl: photoUrl,
        displayName: nickname,
        phoneNumber: phoneNumber,
        aboutMe: aboutMe);
  }

  String toJson() => json.encode(toMap());

  factory ChatUser.fromJson(String source) =>
      ChatUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatUser(id: $id, photoUrl: $photoUrl, displayName: $displayName, phoneNumber: $phoneNumber, aboutMe: $aboutMe)';
  }

  @override
  bool operator ==(covariant ChatUser other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.photoUrl == photoUrl &&
        other.displayName == displayName &&
        other.phoneNumber == phoneNumber &&
        other.aboutMe == aboutMe;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        photoUrl.hashCode ^
        displayName.hashCode ^
        phoneNumber.hashCode ^
        aboutMe.hashCode;
  }
}
