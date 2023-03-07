import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/pages/map_page.dart';
import 'package:location/location.dart';

import '../utils/location_util.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectedPosition;

  const LocationInput(this.onSelectedPosition, {super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl = "";

  void _showPreview(double lat, double lng) {
    final staticMapImageUrl = LocationUtil.generateLocationPreviewImage(
      latitude: lat,
      longitude: lng,
    );
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _getCurrentUserLocation() async {
    try {
      final locaData = await Location().getLocation();
      _showPreview(locaData.latitude!, locaData.longitude!);
      widget.onSelectedPosition(LatLng(
        locaData.latitude!,
        locaData.longitude!,
      ));
    } catch (e) {
      // tratar com uma mensagem para o usuário
      return;
    }
  }

  Future<void> _selectedOnMap() async {
    final LatLng selectedPosition = await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => const MapPage(),
      ),
    );

    // ignore: unnecessary_null_comparison
    if (selectedPosition == null) return;

    _showPreview(selectedPosition.latitude, selectedPosition.longitude);
    widget.onSelectedPosition(LatLng(
      selectedPosition.latitude,
      selectedPosition.longitude,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _previewImageUrl == ""
              ? const Text('Localização não informada')
              : Image.network(
                  _previewImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: _getCurrentUserLocation,
              icon: const Icon(Icons.location_on),
              label: const Text('Localização Atual'),
              style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).primaryColor),
            ),
            TextButton.icon(
              onPressed: _selectedOnMap,
              icon: const Icon(Icons.map),
              label: const Text('Selecione no mapa'),
              style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).primaryColor),
            ),
          ],
        )
      ],
    );
  }
}
