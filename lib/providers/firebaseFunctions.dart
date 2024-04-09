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
    required String contactNumber,
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
      'contactNumber': contactNumber,
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
    required String contactNumber,
  }) async {
    await _firestore.collection('ENABLED_locations').doc(locationID).update({
      'description': description,
      'name': name,
      'location': location,
      'accessibility': accessibility,
      'overallRating': overallRating,
      'contactNumber': contactNumber,
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

  // Create a new user
  Future<void> createUser({
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String profilePicture,
    required String password,
  }) async {
    DocumentReference docRef =
        _firestore.collection('ENABLED_ENABLED_users').doc();
    String userId = docRef.id; // Generate userId
    await docRef.set({
      'userId': userId, // Set userId
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture,
      'password': password,
    });
  }

  // Update an existing user
  Future<void> updateUser({
    required String userId,
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String profilePicture,
    required String password,
  }) async {
    await _firestore.collection('ENABLED_users').doc(userId).update({
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture,
      'password': password,
    });
  }

  // Delete an existing user
  Future<void> deleteUser(String userId) async {
    await _firestore.collection('ENABLED_users').doc(userId).delete();
  }

  // Get all ENABLED_users
  Stream<QuerySnapshot> getAllENABLED_users() {
    return _firestore.collection('ENABLED_users').snapshots();
  }

  // Get a specific user by userId
  Future<DocumentSnapshot> getUserById(String userId) {
    return _firestore.collection('ENABLED_users').doc(userId).get();
  }
}

class ENABLED_userservice {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> getUserDetails(String userId) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('ENABLED_users').doc(userId).get();
      if (snapshot.exists) {
        return snapshot.data() as Map<String, dynamic>;
      } else {
        throw 'User not found';
      }
    } catch (e) {
      throw 'Error getting user details: $e';
    }
  }
}
