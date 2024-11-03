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
  bool _isInit = true; // check if the markers are loaded for the first time
  Set<Marker> _markers = {};
  final List<LatLng> markerPositions = const [
    LatLng(37.7749, -122.4193),
    LatLng(37.7849, -122.4194),
    LatLng(37.7649, -122.4194),
    LatLng(37.7749, -122.4294),
    LatLng(37.7749, -122.4094),
    LatLng(37.7849, -122.4294),
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
    _initializeMarkersWithDelay();
    super.initState();
  }

  final List<String> titles = [
    '10,3 mn ₽',
    '11 mn ₽',
    '13,3 mn ₽',
    '7,8 mn ₽',
    '8,5 mn ₽',
    '6,95 mn ₽'
  ];

  Future<void> _initializeMarkersWithDelay() async {
    // Delay for  seconds (2000 milliseconds)
    await Future.delayed(const Duration(milliseconds: 920));
    if (mounted) {
      setState(() {
        _markers = Set.from(_createMarkers());
        _isInit = false;
      });
    }
  }

  List<Marker> _createMarkers() {
    return List<Marker>.generate(markerPositions.length, (index) {
      return Marker(
        point: markerPositions[index],
        width: 75,
        height: 60,
        child: ListOfMarkersWidget(
          isExpanded: _isExpanded,
          color: AppTheme.primaryColor,
          markerTitle: 'Marker ${index + 1}',
        ),
      );
    });
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
                subdomains: const ['a', 'b', 'c'],
                retinaMode: true, // Set retina mode here
              ),
              MarkerLayer(
                  markers: _isInit ? _markers.toList() : _createMarkers()),
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
