
import 'ad_manager.dart';
import 'manager/init_sdk.dart';
import 'manager/listenerManager.dart';

class TopOnSDK {
  static setupSDK() {
    InitManger.setLogEnabled();
    InitManger.setExludeBundleIDArray();
    // InitManger.deniedUploadDeviceInfo();
    InitManger.initTopOn();

    ListenerManager.rewarderListen();
    ListenerManager.interListen();
    ListenerManager.bannerListen();
    ListenerManager.nativeListen();
    ListenerManager.splashListen();

   // adManager.scheduleTask();
  }
}
