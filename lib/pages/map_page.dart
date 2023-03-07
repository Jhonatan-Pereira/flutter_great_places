import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/models/place.dart';

class MapPage extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isReadonly;

  const MapPage(
      {this.initialLocation = const PlaceLocation(
        latitude: 37.419857,
        longitude: -122.078827,
      ),
      this.isReadonly = false,
      super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late LatLng _pickedPosition = LatLng(
    widget.initialLocation.latitude,
    widget.initialLocation.longitude,
  );

  void _selectPosition(LatLng position) {
    setState(() {
      _pickedPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecione...'),
        actions: <Widget>[
          if (!widget.isReadonly)
            IconButton(
              onPressed: () {
                Navigator.of(context).pop(_pickedPosition);
              },
              icon: const Icon(Icons.check),
            )
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ),
          zoom: 13,
        ),
        onTap: widget.isReadonly ? null : _selectPosition,
        // ignore: unnecessary_null_comparison
        markers: _pickedPosition == null
            ? <Marker>{}
            : {
                Marker(
                  markerId: const MarkerId('p1'),
                  position: _pickedPosition,
                ),
              },
      ),
    );
  }
}
