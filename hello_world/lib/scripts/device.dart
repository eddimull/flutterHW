import 'package:device_info/device_info.dart';
import 'dart:io';

class Device {
  Device();
  
  static Future<String> name() async{
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String deviceName = '';
    try{
      if(Platform.isAndroid){
        var build = await deviceInfo.androidInfo;
        
          deviceName = build.model;
        
      }else if(Platform.isIOS){
        var build = await deviceInfo.iosInfo;
        
          deviceName = build.model;
        
      }
    } catch(e){
      
        deviceName = 'Unspecified device';
      
    }

    return deviceName;
  }
}