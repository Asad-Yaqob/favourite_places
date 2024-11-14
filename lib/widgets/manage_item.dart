import 'package:favourite_places/models/place.dart';
import 'package:flutter/material.dart';

class ManageItem extends StatelessWidget {
  const ManageItem({
    super.key,
    required this.place,
  });

  final Place place;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: ExpansionTile(
        collapsedBackgroundColor: Theme.of(context).colorScheme.primary,
        backgroundColor: Theme.of(context).colorScheme.primary,
        collapsedIconColor: Theme.of(context).colorScheme.surface,
        iconColor: Theme.of(context).colorScheme.surface,
        childrenPadding: const EdgeInsets.all(
          12,
        ),
        leading: CircleAvatar(
          backgroundImage: FileImage(place.image),
        ),
        title: Text(
          place.placeName,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.surface,
              ),
        ),
        children: [
          Column(
            children: [
              Text(
                place.location.address,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.surface,
                    ),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.edit),
                    style: IconButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      foregroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    label: const Text('Edit'),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.delete),
                    style: IconButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      foregroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    label: const Text('Delete'),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
