import 'package:flutter/material.dart';
import 'package:great_places/pages/map_page.dart';
import 'package:path/path.dart';

import '../models/place.dart';

class PlaceDetailPage extends StatelessWidget {
  const PlaceDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    Place? place = ModalRoute.of(context)?.settings.arguments as Place?;

    return Scaffold(
      appBar: AppBar(
        title: Text(place!.title),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 250,
            width: double.infinity,
            child: Image.file(
              place.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            place.location.address!,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => MapPage(
                    isReadonly: true,
                    initialLocation: place.location,
                  ),
                ),
              );
            },
            icon: Icon(Icons.map),
            label: Text('Ver no Mapa'),
            style: ElevatedButton.styleFrom(
                foregroundColor: Theme.of(context).primaryColor,
                backgroundColor: Colors.white),
          ),
        ],
      ),
    );
  }
}
