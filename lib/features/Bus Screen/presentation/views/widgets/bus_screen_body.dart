import 'dart:async'; // استيراد مكتبة التعامل مع التدفقات الزمنية

import 'package:edunourish/core/utils/constants.dart';
import 'package:edunourish/core/widgets/base_scaffold.dart';
import 'package:edunourish/features/Bus%20Screen/bloc/bus_bloc.dart';
import 'package:edunourish/features/Bus%20Screen/bloc/bus_state.dart';
import 'package:edunourish/features/Bus%20Screen/presentation/views/widgets/bus_info.dart';
import 'package:flutter/material.dart'; // استيراد عناصر الواجهة من فلاتر
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart'; // استيراد مكتبة الخرائط
import 'package:latlong2/latlong.dart'; // استيراد مكتبة النقاط الجغرافية
import 'package:geolocator/geolocator.dart'; // استيراد مكتبة تحديد الموقع

// الواجهة الرئيسية لشاشة الباص مع إمكانية السحب للتحديث
class BusScreenBody extends StatefulWidget {
  final int initialIndex; // متغير لتحديد الفهرس الأولي (غير مستخدم هنا)
  const BusScreenBody({super.key, required this.initialIndex}); // مُنشئ الواجهة مع تعيين الفهرس الأولي

  @override
  BusScreenBodyState createState() => BusScreenBodyState();
}

class BusScreenBodyState extends State<BusScreenBody> {
  int _mapRefreshKey = 0; // مفتاح لإعادة إنشاء ويدجت الخريطة عند التحديث

  // دالة التعامل مع السحب للتحديث
  Future<void> _handleRefresh() async {
    // عند السحب لإعادة تحميل الخريطة تماماً كأول دخول
    setState(() {
      _mapRefreshKey++; // تغيير المفتاح لإعادة بناء LiveMap
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      initialIndex: widget.initialIndex, // تعيين الفهرس الأولي
      appBartTitle: 'Bus Screen', // عنوان الشاشة
      child: RefreshIndicator(
        onRefresh: _handleRefresh, // ربط السحب مع الدالة
        child: SingleChildScrollView(
          physics:
              const AlwaysScrollableScrollPhysics(), // للسماح بالتمرير حتى لو المحتوى صغير
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0), // حواف أفقية
                child: Container(
                  height: 500, // ارتفاع ثابت للحاوية
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ourMainColor,
                      width: 3.0,
                    ),
                    borderRadius: BorderRadius.circular(12), // زوايا مستديرة
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10), // قليلاً أصغر من الإطار الخارجي
                    child: LiveMap(key: ValueKey(_mapRefreshKey)),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                    top: 30, left: 16), // مسافة من الأعلى واليسار
                child: Text(
                  'Bus schedules', // عنوان جدول المواعيد
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              BlocBuilder<BusBloc, BusState>(
                builder: (context, state) {
                  if (state is BusLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is BusLoaded) {
                    return BusInfo(bus: state.bus);
                  } else if (state is BusError) {
                    return Center(
                      child: Text('Error:${state.message}'),
                    );
                  }
                  return const Center(child: Text("try again later!"));
                },
              ), // ويدجت جدول المواعيد
            ],
          ),
        ),
      ),
    );
  }
}

class LiveMap extends StatefulWidget {
  const LiveMap({super.key});

  @override
  LiveMapState createState() => LiveMapState();
}

class LiveMapState extends State<LiveMap> {
  final MapController _mapController = MapController();
  // final Geolocator _geolocator = Geolocator(); // 👈 Geolocator instance
  LatLng? _currentLatLng;

  static const LatLng _destination = LatLng(30.900731, 29.875344);
   Marker destinationMarker = const Marker(
    point: _destination,
    width: 40,
    height: 40,
    child: Icon(
      Icons.school,
      size: 40,
      color: Colors.redAccent,
    ),
);

  Marker? _studentMarker;
  StreamSubscription<Position>? _positionStream;
  bool _firstFix = true;

  @override
  void initState() {
    super.initState();
    _startLocationTracking();
  }

  Future<void> _startLocationTracking() async {
    // Check location service enabled
    if (!await Geolocator.isLocationServiceEnabled()) { 
      _showError('Location services are disabled. Please enable them.');
      return;
    }

    // Check permissions
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || 
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && 
          permission != LocationPermission.always) {
        _showError('Location permission denied. Please enable in settings.');
        return;
      }
    }

    try {
      // Get initial position
      final Position pos = await Geolocator.getCurrentPosition(
    locationSettings: const LocationSettings( // 👈 Correct parameter name
      accuracy: LocationAccuracy.high,
    ),
  ).timeout(const Duration(seconds: 30));
      _updatePosition(pos);
    } catch (e) {
      debugPrint('Initial GPS fix failed: $e');
      _showError('Could not get initial location.');
      return;
    }

    // Position stream
    _positionStream = Geolocator.getPositionStream( // 👈 Instance method
      locationSettings: const LocationSettings( // 👈 New parameter format
        accuracy: LocationAccuracy.high,
        distanceFilter: 0,
      ),
    ).listen(_updatePosition);
  }

  void _updatePosition(Position pos) {
    final latLng = LatLng(pos.latitude, pos.longitude);
    setState(() {
      _currentLatLng = latLng;
      _studentMarker = Marker(
        width: 40,
        height: 40,
        point: latLng,
        child: const Icon(
          Icons.location_on,
          size: 40,
          color: Colors.blueAccent,
        ),
      );
      
      if (_firstFix) {
        _mapController.move(latLng, 14.0);
        _firstFix = false;
      }
    });
  }

  void _showError(String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    });
  }

  @override
  void dispose() {
    _positionStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: _currentLatLng ?? _destination,
        initialZoom: 14.0,
        minZoom: 3,
        maxZoom: 18,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: const ['a', 'b', 'c'],
          userAgentPackageName: 'com.example.your_app',
        ),
        MarkerLayer(
          markers: [
            if (_studentMarker != null) _studentMarker!,
            destinationMarker,
          ],
        ),
      ],
    );
  }
}