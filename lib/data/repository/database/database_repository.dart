import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_santa/core/utils/result.dart';
class DatabaseRepository{
  // Access Firestore instance
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Result<List<Map<String, dynamic>>>> fetchCollection(String collectionName) async {
    try {

      // Fetch collection data
      QuerySnapshot querySnapshot = await _firestore.collection(collectionName).get();

      // Convert QuerySnapshot to a list of maps
      List<Map<String, dynamic>> collectionData = querySnapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();

      return Result.ok(collectionData);
    } catch (e) {
      print('Error fetching collection: $e');
      return Result.error(e);
    }
  }

}

