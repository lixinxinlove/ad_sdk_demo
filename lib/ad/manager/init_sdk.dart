import 'package:anythink_sdk/at_index.dart';

import 'configuration.dart';


final InitManger = InitTool();

class InitTool{

  // 打开SDK的Debug log，强烈建议在测试阶段打开，方便排查问题。
  setLogEnabled() async {
    await ATInitManger
        .setLogEnabled(
      logEnabled: true,
    );
  }
  // 设置渠道，可用于统计数据和进行流量分组
  setChannelStr() async {
    await ATInitManger
        .setChannelStr(
      channelStr: "test_setChannel",
    );
  }
  // 设置子渠道，可用于统计数据和进行流量分组
  setSubchannelStr() async {
    await ATInitManger
        .setSubChannelStr(
      subchannelStr: "test_setSubchannelStr",
    );
  }
  // 设置自定义的Map信息，可匹配后台配置的对应流量分组（App纬度）（可选配置）
  setCustomDataDic() async {
    await ATInitManger.setCustomDataMap(
      customDataMap: {
        'setCustomDataDic': 'myCustomDataDic',
      },
    );
  }
  // 设置排除交叉推广App列表
  setExludeBundleIDArray() async {
    await ATInitManger.setExludeBundleIDArray(
      exludeBundleIDList: ['test_setExludeBundleIDArray'],
    );
  }
  // 设置自定义的Map信息，可匹配后台配置的对应的流量分组（Placement纬度）（可选配置）
  setPlacementCustomData() async {
    await ATInitManger.setPlacementCustomData(
      placementIDStr: 'b5b72b21184aa8',
      placementCustomDataMap: {'setPlacementCustomData': 'test_setPlacementCustomData'},
    );
  }
  // 判断是否位于欧盟地区
  getUserLocation() async {
    await ATInitManger.getUserLocation().then((value) {
      print('flutter: Get user location -- ${value.toString()}');
    });
  }
  // 获取GDPR的授权级别
  getGDPRLevel() async {
    await ATInitManger.getGDPRLevel().then((value) {
      print('flutter:Get GDPR --${value.toString()}');
    });
  }
  setDataConsentSet() async {

    await ATInitManger.setDataConsentSet(
        gdprLevel:
        ATInitManger.dataConsentSetPersonalized());
  }

  deniedUploadDeviceInfo() async {

    await ATInitManger
        .deniedUploadDeviceInfo(
        deniedUploadDeviceInfoList: [ATInitManger.aOAID()]);
  }
  // 初始化TopOn的SDK
  initTopOn() async {
   String initStr = await ATInitManger.initAnyThinkSDK(
        appidStr: Configuration.appidStr,
        appidkeyStr: Configuration.appidkeyStr);


   print("*******************************************");
   print(initStr);

  }
  // 展示GDPR的界面 (v6.2.87废弃，请使用showGDPRConsentDialog()代替)
  showGDPRAuth()async{
    await ATInitManger.showGDPRAuth();
  }
  // v6.2.87+, 展示GDPR的界面(UMP)
  showGDPRConsentDialog()async{
    await ATInitManger.showGDPRConsentDialog();
  }


  // 获取GDPR的监听事件回调
  initListen() {
    ATListenerManager.initEventHandler.listen((value) {

      if (value.userLocation != null) {
        switch (value.userLocation) {
          case InitUserLocation.initUserLocationInEU:
            print("flutter Monitor initial user location in the EU--");

            ATInitManger.getGDPRLevel().then((value) {
              if (value == ATInitManger.dataConsentSetUnknown()) {
                showGDPRAuth();
              }
            });
            break;
          case InitUserLocation.initUserLocationOutOfEU:
            print("flutter: flutter The location of the listening initial user is not in the EU");
            break;
          case InitUserLocation.initUserLocationUnknown:
            print("flutter: flutter The location of the initial listening user is unknown");
            break;
        }
      }

      if (value.consentDismiss != null) {
        print("flutter: flutter consent dismiss callback");
      }

    });
  }


}