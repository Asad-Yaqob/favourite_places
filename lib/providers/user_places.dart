import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:favourite_places/services/database.dart';
import 'package:favourite_places/models/place.dart';

final _database = DatabaseService();

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() : super(const []);

  Future loadPlaces() async {
    final snapshots = await _database.loadPlaces;

    List<Place> places = snapshots.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return Place(
        id: data['id'],
        placeName: data['placeName'],
        image: data['image'],
        location: PlaceLocation(
            latitude: data['location']['latitude'],
            longitude: data['location']['longitude'],
            address: data['location']['address']),
      );
    }).toList();

    state = places;
  }

  Future addPlace(
      String title, File image, PlaceLocation location, BuildContext context) async {

    final isAdded = await _database.addPlace(title, image, location, context);

    if (isAdded.isNotEmpty) {
      final imageUrl = await _database.getImageUrl(isAdded);
      final newPlace =
          Place(placeName: title, image: imageUrl, location: location);

      state = [newPlace, ...state];
   
    }
  }

  Future removePlace(String id, BuildContext context) async {
    await _database.removePlace(id, context);
    state = state.where((p) => p.id != id).toList();
  }

  Future updatePlace({
    required String id,
    required String title,
    required PlaceLocation location,
    File? image,
    String? initialImage,
    BuildContext? context,
  }) async {

    if (initialImage != null && initialImage.isNotEmpty) {
      await _database.updatePlace(
        id: id,
        name: title,
        location: location,
        initialImage: initialImage,
        context: context,
      );
    } else if (image != null) {
      await _database.updatePlace(
        id: id,
        name: title,
        location: location,
        image: image,
        context: context,
      );
    }
    
    final imageUrl = await _database.getImageUrl(id);

    state = state
        .map((place) => place.id == id
            ? Place(
                id: id, placeName: title, image: imageUrl, location: location)
            : place)
        .toList();
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Place>>(
  (ref) => UserPlacesNotifier(),
);
