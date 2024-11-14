import 'package:favourite_places/providers/user_places.dart';
import 'package:favourite_places/widgets/manage_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ManageScreen extends ConsumerStatefulWidget {
  const ManageScreen({super.key});

  @override
  ConsumerState<ManageScreen> createState() => _ManageScreenState();
}

class _ManageScreenState extends ConsumerState<ManageScreen> {
  late Future<void> _placesFuture;

  @override
  void initState() {
      super.initState();

      _placesFuture = ref.read(userPlacesProvider.notifier).loadPlaces();
  }
  @override
  Widget build(BuildContext context) {

   final placesList = ref.watch(userPlacesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Places.'),
      ),
      body: FutureBuilder(
        future: _placesFuture,
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(child: CircularProgressIndicator())
                : ManageList(
                    places: placesList,
                  ),
      ),
    );
  }
}
