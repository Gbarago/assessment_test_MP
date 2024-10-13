import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:real_estate_abiodun/UI/screens/widgets/search_map_widgets/map-searchbar_widget.dart';
import 'package:real_estate_abiodun/UI/screens/widgets/search_map_widgets/markers.dart';

class SearchScreenTab extends StatefulWidget {
  const SearchScreenTab({super.key});

  @override
  _SearchScreenTabState createState() => _SearchScreenTabState();
}

class _SearchScreenTabState extends State<SearchScreenTab> {
  late GoogleMapController mapController;
  final LatLng _center =
      const LatLng(37.7749, -122.4194); // Initial map center (San Francisco)
  final Set<Marker> _markers = {};
  String? _mapStyle; // Variable to hold the dark map style

  @override
  void initState() {
    super.initState();

    // Load the dark map style from assets
    rootBundle.loadString('assets/map_styles/dark_map.json').then((string) {
      setState(() {
        _mapStyle = string; // Update the state with the loaded style
      });
    });

    // Add markers with chat bubble widgets
    _addMarkers();
  }

  // Function to add 6 markers
  void _addMarkers() {
    _markers.add(
      Marker(
        markerId: MarkerId('marker_1'),
        position: LatLng(37.7769, -122.4194), // Position for marker 1
        infoWindow: InfoWindow(
          title: 'Marker 1',
          snippet: 'This is a custom chat bubble!',
        ),
        onTap: () {
          _showChatBubble(context, 'This is marker 1!');
        },
      ),
    );

    // Adding 5 more markers
    for (int i = 2; i <= 6; i++) {
      _markers.add(
        Marker(
          markerId: MarkerId('marker_$i'),
          position: LatLng(37.7749 + i * 0.01,
              -122.4194 - i * 0.04), // Adjusted position for markers 2-6
          infoWindow: InfoWindow(
            title: 'Marker $i',
            snippet: 'This is a custom chat bubble!',
          ),
          // onTap: () {
          //   _showChatBubble(context, 'This is marker $i!');
          // },
        ),
      );
    }
  }

  // Function to display the chat bubble dialog
  void _showChatBubble(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
            // markers: _markers,
            // Set the style directly in the GoogleMap widget
            style: _mapStyle,
          ),
          //  const MapSearchBarWidget(),
          const ListOfMarkersWidget(
            isExpanded: true,
          )
        ],
      ),
    );
  }
}
