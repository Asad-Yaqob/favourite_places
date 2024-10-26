import 'dart:io';
import 'package:favourite_places/models/place.dart';
import 'package:favourite_places/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:favourite_places/providers/user_places.dart';
import 'package:favourite_places/widgets/image_input.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() {
    return _AddPlaceScreenState();
  }
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _placeName = TextEditingController();
  File? _selectedImage;
  PlaceLocation? _location;

  void savePlace() {
    final enteredPlace = _placeName.text;

    if (enteredPlace.isEmpty || _selectedImage == null) {
      return;
    }

    ref
        .read(userPlacesProvider.notifier)
        .addPlace(enteredPlace, _selectedImage!, _location!);

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    super.dispose();

    _placeName.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text(
          'Add Place',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Column(
                children: [
                  TextField(
                    controller: _placeName,
                    decoration: const InputDecoration(
                      labelText: 'Place Name',
                    ),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ImageInput(
                    onPickImage: (image) {
                      _selectedImage = image;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  LocationInput(
                    onSelectCurrentLocation: (currentLocation) {
                      _location = currentLocation;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ElevatedButton.icon(
                    onPressed: savePlace,
                    icon: const Icon(Icons.add),
                    label: const Text('Add Place'),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
