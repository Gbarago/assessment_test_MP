import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show Uint8List, rootBundle;
import 'package:real_estate_abiodun/UI/screens/widgets/search_map_widgets/map-searchbar_widget.dart';
import 'package:real_estate_abiodun/UI/screens/widgets/search_map_widgets/markers.dart';
import 'package:real_estate_abiodun/utils/estensions.dart';
import 'package:real_estate_abiodun/utils/theme.dart';
import 'package:screenshot/screenshot.dart';
import 'widgets/search_map_widgets/map_dialogue.dart';
import 'widgets/search_map_widgets/map_fab_right.dart';

class SearchScreenTab extends StatefulWidget {
  const SearchScreenTab({super.key});

  @override
  _SearchScreenTabState createState() => _SearchScreenTabState();
}

class _SearchScreenTabState extends State<SearchScreenTab>
    with TickerProviderStateMixin {
  late GoogleMapController mapController;
  late AnimationController _animationController;
  final LatLng _center = const LatLng(37.7749, -122.4194); // San Francisco
  // Set<Marker> _markers = {};
  int currentFrameIndex = 0;
  String? _mapStyle;
  final ScreenshotController screenshotController = ScreenshotController();
  Timer? _timer;
  //List<Uint8List> markerFrames = [];
  bool _isExpanded = true;

  // Uint8List? expandedMarker;
  // Uint8List? collapsedMarker;
  // final List<LatLng> markerPositions = const [
  //   LatLng(37.7749, -122.4193), // Center
  //   LatLng(37.7849, -122.4194), // North
  //   LatLng(37.7649, -122.4194), // South
  //   LatLng(37.7749, -122.4294), // West
  //   LatLng(37.7749, -122.4094), // East
  //   LatLng(37.7849, -122.4294), // Northwest
  //   LatLng(37.7649, -122.4094), // Southeast
  // ];

  Future<Uint8List> getBytesFromWidget(
    Widget widget, {
    required ScreenshotController screenshotController,
    required int width,
    //!overlayExpanded ? 35 : 75,  ,
    required int height,
  }) async {
    final Uint8List? imageBytes = await screenshotController.captureFromWidget(
      MediaQuery(
        data: MediaQueryData(size: Size(width.toDouble(), height.toDouble())),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: SizedBox(
            width: width.toDouble(),
            height: height.toDouble(),
            child: widget,
          ),
        ),
      ),
      pixelRatio: 1.5,
    );
    return imageBytes!;
  }

  // @override
  // void initState() {
  //   super.initState();

  //   // Load both expanded and collapsed marker frames once
  //   _loadMarkerFrames();

  //   _animationController = AnimationController(
  //     vsync: this,
  //     duration: 700.ms,
  //     reverseDuration: 500.ms,
  //   );

  //   _animationController.addStatusListener((listener) {
  //     // if (listener == AnimationStatus.completed ||
  //     //     listener == AnimationStatus.dismissed) {
  //     setState(() {
  //       _isExpanded = !_isExpanded;
  //       _loadMarkerFrames().then((_) => _toggleExpansion());
  //     });
  //     //  }
  //   });

  //   // Optional: Load the map style
  //   rootBundle.loadString('assets/map_styles/dark_map.json').then((style) {
  //     setState(() {
  //       _mapStyle = style;
  //     });
  //   });
  // }

  // Future<void> _loadMarkerFrames() async {
  //   expandedMarker = await _generateMarkerFrame(true);
  //   collapsedMarker = await _generateMarkerFrame(false);
  //   _addMarkers(); // Add markers once loaded
  // }

  // Future<Uint8List> _generateMarkerFrame(bool isExpanded) async {
  //   return await getBytesFromWidget(
  //     ListOfMarkersWidget(
  //       isExpanded: isExpanded,
  //       color: AppTheme.primaryColor,
  //     ),
  //     screenshotController: screenshotController,
  //     width: isExpanded ? 75 : 35,
  //     height: 35,
  //   );
  // }

  // void _toggleExpansion() {
  //   setState(() {
  //     _isExpanded = !_isExpanded;
  //     _addMarkers(); // Update markers instantly when _isExpanded changes
  //   });
  // }

  // void _addMarkers() {
  //   final Uint8List markerIcon =
  //       _isExpanded ? expandedMarker! : collapsedMarker!;
  //   _markers = markerPositions.map((position) {
  //     return Marker(
  //       markerId: MarkerId(position.toString()),
  //       position: position,
  //       icon: BitmapDescriptor.bytes(markerIcon),
  //     );
  //   }).toSet();
  // }

  Uint8List? expandedMarker;
  Uint8List? collapsedMarker;
  Set<Marker> _markers = {};
  final List<LatLng> markerPositions = [
    LatLng(37.7749, -122.4193),
    LatLng(37.7849, -122.4194),
    LatLng(37.7649, -122.4194),
    LatLng(37.7749, -122.4294),
    LatLng(37.7749, -122.4094),
    LatLng(37.7849, -122.4294),
    LatLng(37.7649, -122.4094),
  ];

  // final ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: 700.ms,
      reverseDuration: 500.ms,
    );

    _animationController.addStatusListener((listener) {
      _loadMarkerFrames();

      if (listener == AnimationStatus.completed ||
          listener == AnimationStatus.dismissed) {
        setState(() {
          _isExpanded = !_isExpanded;
          // _loadMarkerFrames().then((_) => _updateMarkers());
        });
      }
    });

    _loadMarkerFrames();
    // Optionally: Load the map style

    rootBundle.loadString('assets/map_styles/dark_map.json').then((style) {
      setState(() {
        _mapStyle = style;
      });
    });
  }

  Future<void> _loadMarkerFrames() async {
    expandedMarker = await _generateMarkerFrame(true);
    collapsedMarker = await _generateMarkerFrame(false);
    _addMarkers(); // Add markers after loading frames
  }

  // Future<Uint8List> _generateMarkerFrame(bool isExpanded) async {
  //   return await getBytesFromWidget(
  //     ListOfMarkersWidget(
  //       isExpanded: isExpanded,
  //       color: AppTheme.primaryColor,
  //     ),

  //     // Container(
  //     //   width: 150,
  //     //   height: 50,
  //     //   color: AppTheme.primaryColor,
  //     // ),
  //     screenshotController: screenshotController,
  //     width: isExpanded ? 75 : 35,
  //     height: 35,
  //   );
  // }

  Future<Uint8List> _generateMarkerFrame(bool isExpanded) async {
    final AnimationController animationController = AnimationController(
      vsync: this, // Requires this mixin
      duration: const Duration(milliseconds: 300),
    );
    final Animation<double> animation =
        Tween(begin: 1.0, end: isExpanded ? 1.2 : 0.8)
            .animate(animationController);

    animationController.forward();

    // Capture widget after animation completes
    await Future.delayed(animationController.duration!);

    final Uint8List markerFrame = await getBytesFromWidget(
      ListOfMarkersWidget(
        isExpanded: isExpanded,
        color: AppTheme.primaryColor,
        // animation: animation,
      ),
      screenshotController: screenshotController,
      width: isExpanded ? 75 : 35,
      height: 35,
    );

    animationController.dispose();
    return markerFrame;
  }

  void _toggleExpansion() async {
    setState(() {
      _isExpanded = !_isExpanded;
      _markers.clear(); // Clear markers to refresh
    });
    // Small delay to ensure markers are cleared before re-adding
    await Future.delayed(const Duration(milliseconds: 10));
    _addMarkers(); // Add markers with updated icon
  }

  void _addMarkers() {
    final Uint8List markerIcon =
        _isExpanded ? expandedMarker! : collapsedMarker!;
    setState(() {
      _markers = markerPositions.map((position) {
        return Marker(
          markerId: MarkerId(position.toString()),
          position: position,
          icon: BitmapDescriptor.bytes(markerIcon),
        );
      }).toSet();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          GoogleMap(
            markers: _markers,
            // onMapCreated: (GoogleMapController controller) {
            //   mapController = controller;
            // },
            onMapCreated: (controller) => mapController = controller,

            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 14.0,
            ),
            style: _mapStyle,
          ),
          const ExtendedRightFabBTN(),
          // Positioned(
          //   left: 30,
          //   bottom: context.sizeHeight(0.11),
          //   child: OverlayDialog(
          //     animationController: _animationController,
          //   ),
          //  ),

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







 // Future<Uint8List> getBytesFromWidget(
  //   Widget widget, {
  //   required ScreenshotController screenshotController,
  //   required int width,
  //   //!overlayExpanded ? 35 : 75,  ,
  //   required int height,
  // }) async {
  //   final Uint8List? imageBytes = await screenshotController.captureFromWidget(
  //     MediaQuery(
  //       data: MediaQueryData(size: Size(width.toDouble(), height.toDouble())),
  //       child: Directionality(
  //         textDirection: TextDirection.ltr,
  //         child: SizedBox(
  //           width: width.toDouble(),
  //           height: height.toDouble(),
  //           child: widget,
  //         ),
  //       ),
  //     ),
  //     pixelRatio: 1.5,
  //   );
  //   return imageBytes!;
  // }

  // @override
  // void initState() {
  //   super.initState();

  //   // Load marker frames only when the _isExpanded changes
  //   _loadMarkerFrames().then((_) => _updateMarkers());

  //   _animationController = AnimationController(
  //     vsync: this,
  //     duration: 700.ms,
  //     reverseDuration: 500.ms,
  //   );

  //   _animationController.addStatusListener((listener) {
  //     if (listener == AnimationStatus.completed ||
  //         listener == AnimationStatus.dismissed) {
  //       setState(() {
  //         _isExpanded = !_isExpanded;
  //         _loadMarkerFrames().then((_) => _updateMarkers());
  //       });
  //     }
  //   });

  //   // Load the dark map style from assets
  //   rootBundle.loadString('assets/map_styles/dark_map.json').then((string) {
  //     setState(() {
  //       _mapStyle = string;
  //     });
  //   });
  // }

  // Future<void> _loadMarkerFrames() async {
  //   markerFrames.clear();
  //   for (int i = 0; i < 2; i++) {
  //     final Uint8List markerFrame = await getBytesFromWidget(
  //       ListOfMarkersWidget(
  //         isExpanded: _isExpanded,
  //         color: AppTheme.primaryColor,
  //       ),
  //       screenshotController: screenshotController,
  //       width: _isExpanded ? 75 : 35,
  //       height: 35,
  //     );
  //     markerFrames.add(markerFrame);
  //   }
  // }

  // // Function to update markers with the latest frame only once
  // void _updateMarkers() {
  //   final List<LatLng> markerPositions = [
  //     LatLng(37.7749, -122.4193), // Center
  //     LatLng(37.7849, -122.4194), // North
  //     LatLng(37.7649, -122.4194), // South
  //     LatLng(37.7749, -122.4294), // West
  //     LatLng(37.7749, -122.4094), // East
  //     LatLng(37.7849, -122.4294), // Northwest
  //     LatLng(37.7649, -122.4094), // Southeast
  //   ];

  //   setState(() {
  //     _markers = markerPositions.map((position) {
  //       return Marker(
  //         markerId: MarkerId(position.toString()),
  //         position: position,
  //         icon: BitmapDescriptor.bytes(markerFrames.last),
  //       );
  //     }).toSet();
  //   });
  // }