import 'package:location/location.dart';

class LocationService {
  Location location = Location();

  Future<void>checkAndRequestLocationService() async{
    var isLocationEnable =await location.serviceEnabled();
    if(!isLocationEnable){
      isLocationEnable = await location.requestService();
      if(!isLocationEnable){
       throw LocationServiceException();
      }
    }
   
  }

  Future<void> checkAndRequestLocationPermission()async{
    var permissionStatues = await location.hasPermission();
    if(permissionStatues == PermissionStatus.deniedForever){
      throw LocationPermissionException();
    }

    if(permissionStatues == PermissionStatus.denied){
      permissionStatues = await location.requestPermission();
     if(permissionStatues != PermissionStatus.granted){
      throw LocationPermissionException();
     }
    }
  
  }

   void getRealTimeLocationData(void Function(LocationData)? onData)async {
    // location.changeSettings(
    //  distanceFilter : 2
    // ); // علشان ميعملش اعاده بناء لل يواي كل شويه بس يعملها كل ما المسافه تتغير بمقدار اتنين متر
    await checkAndRequestLocationService();
    await checkAndRequestLocationPermission();
    location.onLocationChanged.listen(onData);
  }

  Future<LocationData> getLocationData()async{
    await checkAndRequestLocationService();
    await checkAndRequestLocationPermission();
    return await location.getLocation();
  }
}

class LocationServiceException implements Exception{}
class LocationPermissionException implements Exception{}