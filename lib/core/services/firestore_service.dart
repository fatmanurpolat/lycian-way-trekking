import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<QueryDocumentSnapshot>> getAllRoutes() async {
    QuerySnapshot querySnapshot = await firestore.collection('allRoutes').get();
    return querySnapshot.docs;
  }
}
