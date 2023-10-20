// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat_app/constants/FirestoreConstants.dart';

class ChatMessages {
  String idFrom;
  String idTo;
  String timestamp;
  String content;
  int type;
  ChatMessages({
    required this.idFrom,
    required this.idTo,
    required this.timestamp,
    required this.content,
    required this.type,
  });

  ChatMessages copyWith({
    String? idFrom,
    String? idTo,
    String? timestamp,
    String? content,
    int? type,
  }) {
    return ChatMessages(
      idFrom: idFrom ?? this.idFrom,
      idTo: idTo ?? this.idTo,
      timestamp: timestamp ?? this.timestamp,
      content: content ?? this.content,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idFrom': idFrom,
      'idTo': idTo,
      'timestamp': timestamp,
      'content': content,
      'type': type,
    };
  }

  factory ChatMessages.fromMap(Map<String, dynamic> map) {
    return ChatMessages(
      idFrom: map['idFrom'] as String,
      idTo: map['idTo'] as String,
      timestamp: map['timestamp'] as String,
      content: map['content'] as String,
      type: map['type'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatMessages.fromDocument(DocumentSnapshot documentSnapshot) {
    String idFrom = documentSnapshot.get(FirestoreConstants.idFrom);
    String idTo = documentSnapshot.get(FirestoreConstants.idTo);
    String timestamp = documentSnapshot.get(FirestoreConstants.timestamp);
    String content = documentSnapshot.get(FirestoreConstants.content);
    int type = documentSnapshot.get(FirestoreConstants.type);

    return ChatMessages(
        idFrom: idFrom,
        idTo: idTo,
        timestamp: timestamp,
        content: content,
        type: type);
  }

  factory ChatMessages.fromJson(String source) =>
      ChatMessages.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatMessages(idFrom: $idFrom, idTo: $idTo, timestamp: $timestamp, content: $content, type: $type)';
  }

  @override
  bool operator ==(covariant ChatMessages other) {
    if (identical(this, other)) return true;

    return other.idFrom == idFrom &&
        other.idTo == idTo &&
        other.timestamp == timestamp &&
        other.content == content &&
        other.type == type;
  }

  @override
  int get hashCode {
    return idFrom.hashCode ^
        idTo.hashCode ^
        timestamp.hashCode ^
        content.hashCode ^
        type.hashCode;
  }
}
