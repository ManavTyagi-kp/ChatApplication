// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat_app/constants/FirestoreConstants.dart';

class HomeProvider {
  final FirebaseFirestore firebaseFirestore;

  HomeProvider({
    required this.firebaseFirestore,
  });

  Future<void> updateFirestoreData(
      String collectionPath, String path, Map<String, dynamic> updateData) {
    return firebaseFirestore
        .collection(collectionPath)
        .doc(path)
        .update(updateData);
  }

  Stream<QuerySnapshot> getFirestoreData(
      String collectionPath, int limit, String? textSearch) {
    if (textSearch?.isNotEmpty == true) {
      return firebaseFirestore
          .collection(collectionPath)
          .limit(limit)
          .where(FirestoreConstants.displayName, isEqualTo: textSearch)
          .snapshots();
    } else {
      return firebaseFirestore
          .collection(collectionPath)
          .limit(limit)
          .snapshots();
    }
  }
}
