import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:real_estate_abiodun/UI/screens/widgets/search_map_widgets/markers.dart';
import 'package:real_estate_abiodun/utils/estensions.dart';
import 'package:real_estate_abiodun/utils/theme.dart';
import 'widgets/search_map_widgets/map-searchbar_widget.dart';
import 'widgets/search_map_widgets/map_dialogue.dart';
import 'widgets/search_map_widgets/map_fab_right.dart';

class SearchScreenTab extends StatefulWidget {
  const SearchScreenTab({super.key});

  @override
  _SearchScreenTabState createState() => _SearchScreenTabState();
}

class _SearchScreenTabState extends State<SearchScreenTab>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = true;
  late AnimationController _animationController;

  Set<Marker> _markers = {};
  final List<LatLng> markerPositions = const [
    LatLng(37.7749, -122.4193),
    LatLng(37.7849, -122.4194),
    LatLng(37.7649, -122.4194),
    LatLng(37.7749, -122.4294),
    LatLng(37.7749, -122.4094),
    LatLng(37.7849, -122.4294),
    LatLng(37.7649, -122.4094),
  ];
  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: 700.ms, reverseDuration: 500.ms);
    _animationController.addStatusListener((listener) {
      if (listener == AnimationStatus.dismissed) {
        setState(() {
          _isExpanded = false;
        });
      } else {
        setState(() {
          _isExpanded = true;
        });
      }
    });

    _createMarkers();

    super.initState();
  }

  List<Marker> _createMarkers() {
    return markerPositions.map((position) {
      return Marker(
        point: position,
        width: 75,
        height: 60,
        child: ListOfMarkersWidget(
          isExpanded: _isExpanded,
          color: AppTheme.primaryColor,
        ),
      );
    }).toList(); // Convert to list to return
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            options: const MapOptions(
              initialCenter: LatLng(37.7749, -122.4194), // San Francisco
              initialZoom: 14.0,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    "https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png",
                subdomains: ['a', 'b', 'c'],
                retinaMode: true, // Set retina mode here
              ),

              MarkerLayer(
                  markers:
                      _createMarkers()), // Call _createMarkers to render all markers
            ],
          ),
          const ExtendedRightFabBTN(),
          Positioned(
            left: 30,
            bottom: context.sizeHeight(0.11),
            child: OverlayDialog(
              animationController: _animationController,
            ),
          ),
          const MapSearchBarWidget(),
        ],
      ),
    );
  }
}
