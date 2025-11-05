import 'dart:convert';
import 'package:chats_app/core/location_service.dart';
import 'package:chats_app/features/chat/data/models/message_model.dart';
import 'package:chats_app/features/chat/presentation/view_models/chat_cubit/chat_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart' as loc;

class MapViewBody extends StatefulWidget {
  const MapViewBody({super.key,required this.senderEmail, required this.reciverEmail});
   final String senderEmail;
   final String reciverEmail;

  @override
  State<MapViewBody> createState() => _MapViewBodyState();
}

class _MapViewBodyState extends State<MapViewBody> {
  late LocationService locationService;
  late CameraPosition initioalCameraPostion;
  late GoogleMapController googleMapController;

 LatLng ? choosenLocation;
  final TextEditingController _searchController = TextEditingController();
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    locationService = LocationService();
    initioalCameraPostion = const CameraPosition(
      target: LatLng(26.559384450639264, 31.69553645791201),
      zoom: 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          markers: markers,
          initialCameraPosition: initioalCameraPostion,
          onMapCreated: (controller) {
            googleMapController = controller;
            Future.delayed(const Duration(milliseconds: 500), updateMyLocation);
          },
          onTap: (LatLng tappedPoint) {
            choosenLocation = tappedPoint;
            setMarkerForMyLocation(tappedPoint);
          },
        ),

        // 🔍 مربع البحث فوق الخريطة
        Positioned(
          top: 30,
          left: 16,
          right: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: "Search for a place...",
                border: InputBorder.none,
                suffixIcon: Icon(Icons.search),
              ),
              onSubmitted: (value) {
                searchAndGoToPlace(value);
              },
            ),
          ),
        ),

        // 📍 زر الإرسال في الأسفل
        Positioned(
          left: 35,
          right: 35,
          bottom: 16,
          child: ElevatedButton(
            onPressed: () {
               sendLocation(context);
           
            GoRouter.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueGrey),
            child: const Text(
              "Send Location",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  void sendLocation(BuildContext context) {
           final messageId = FirebaseFirestore.instance
       .collection('temp')
       .doc()
       .id;
    
                  // 2️⃣ إنشاء الموديل
                  var msg = MessageModel(
     id: messageId,
     from: widget.senderEmail,
     to: widget.reciverEmail,
     content:"",
     type: "location",
     lat: choosenLocation!.latitude,
     lng: choosenLocation!.longitude,
     createdAt: DateTime.now(),
                  );
    
                  // 3️⃣ إرسال الرسالة
                  BlocProvider.of<ChatCubit>(context).addMessage(
     senderEmail:widget.senderEmail,
     reciverEmail: widget.reciverEmail,
     message: msg,
                  );
  }

  // 📍 تحديث الموقع الحالي
  void updateMyLocation() async {
    try {
      var myLocation = await locationService.getLocationData();
      LatLng pos = LatLng(myLocation.latitude!, myLocation.longitude!);
      setMarkerForMyLocation(pos);
      setCameraPostion(myLocation);
      choosenLocation = pos;
    } catch (e) {
      debugPrint("Location error: $e");
    }
  }

  // 🎯 تحريك الكاميرا
  void setCameraPostion(loc.LocationData locationData) {
    var cameraPostion = CameraPosition(
      target: LatLng(locationData.latitude!, locationData.longitude!),
      zoom: 14,
    );
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(cameraPostion),
    );
  }

  // 🗺️ إنشاء ماركر جديد
  void setMarkerForMyLocation(LatLng position) async {
    var markerIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "assets/image/marker.png",
    );

    setState(() {
      markers.clear();
      markers.add(
        Marker(
          markerId: const MarkerId("selected_location"),
          icon: markerIcon,
          position: position,
        ),
      );
    });

    googleMapController.animateCamera(
      CameraUpdate.newLatLng(position),
    );
  }

  // 🔍 البحث عن مكان باستخدام OpenStreetMap (بدون Google API)
  Future<void> searchAndGoToPlace(String placeName) async {
    try {
      final url = Uri.parse(
        'https://nominatim.openstreetmap.org/search?q=$placeName&format=json&limit=1',
      );

      final response = await http.get(url, headers: {
        'User-Agent': 'FlutterApp (seramasumi808@gmail.com)', // مطلوب من Nominatim
      });

      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("data : $data");
        if (data.isNotEmpty) {
          final lat = double.parse(data[0]['lat']);
          final lon = double.parse(data[0]['lon']);
          LatLng position = LatLng(lat, lon);
          choosenLocation = position;
          setMarkerForMyLocation(position);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Location not found")),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error fetching location")),
        );
      }
    } catch (e) {
      debugPrint("Search error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error searching for location")),
      );
    }
  }
}
