import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create a new ENABLED_location
  Future<void> createLocation({
    required String description,
    required String name,
    required GeoPoint location,
    required List<String> accessibility,
    required double overallRating,
  }) async {
    DocumentReference docRef = _firestore.collection('ENABLED_locations').doc();
    String locationID = docRef.id; // Generate locationID
    await docRef.set({
      'locationID': locationID, // Set locationID
      'description': description,
      'name': name,
      'location': location,
      'accessibility': accessibility,
      'overallRating': overallRating,
    });
  }

  // Update an existing ENABLED_location
  Future<void> updateLocation({
    required String locationID,
    required String description,
    required String name,
    required GeoPoint location,
    required List<String> accessibility,
    required double overallRating,
  }) async {
    await _firestore.collection('ENABLED_locations').doc(locationID).update({
      'description': description,
      'name': name,
      'location': location,
      'accessibility': accessibility,
      'overallRating': overallRating,
    });
  }

  // Delete an existing ENABLED_location
  Future<void> deleteLocation(String locationID) async {
    await _firestore.collection('ENABLED_locations').doc(locationID).delete();
  }

  // Get all ENABLED_locations
  Stream<QuerySnapshot> getAllLocations() {
    return _firestore.collection('ENABLED_locations').snapshots();
  }

  // Get a specific ENABLED_location by its locationID
  Future<DocumentSnapshot> getLocationByID(String locationID) {
    return _firestore.collection('ENABLED_locations').doc(locationID).get();
  }

  // Add a new review to a specific ENABLED_location
  Future<void> addReview({
    required String locationID,
    required String feedback,
    required double rating,
    required String userID,
    required String userName,
  }) async {
    DocumentReference reviewRef = _firestore
        .collection('ENABLED_locations')
        .doc(locationID)
        .collection('Reviews')
        .doc();
    String reviewID = reviewRef.id; // Generate reviewID
    await reviewRef.set({
      'reviewID': reviewID, // Set reviewID
      'feedback': feedback,
      'rating': rating,
      'userID': userID,
      'userName': userName,
    });
  }

  // Update a review of a specific ENABLED_location
  Future<void> updateReview({
    required String locationID,
    required String reviewID,
    required String feedback,
    required double rating,
  }) async {
    await _firestore
        .collection('ENABLED_locations')
        .doc(locationID)
        .collection('Reviews')
        .doc(reviewID)
        .update({
      'feedback': feedback,
      'rating': rating,
    });
  }

  // Delete a review from a specific ENABLED_location
  Future<void> deleteReview(String locationID, String reviewID) async {
    await _firestore
        .collection('ENABLED_locations')
        .doc(locationID)
        .collection('Reviews')
        .doc(reviewID)
        .delete();
  }
}
