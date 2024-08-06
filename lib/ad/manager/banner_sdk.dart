import 'package:anythink_sdk/at_index.dart';

class BannerSdk {
  loadSplash() async {
    await ATSplashManager.loadSplash(placementID: 'you placementId', extraMap: {
      ATSplashManager.tolerateTimeout(): 5000,
    });
  }

  //使用以下代码判断是否有广告缓存：
  splashReady() async {
    await ATSplashManager.splashReady(placementID: 'you placementId');
  }

  //使用以下代码获取广告状态（返回值类型为Map） key-value如下：
  checkSplashLoadStatus() async {
    await ATSplashManager.checkSplashLoadStatus(placementID: 'you placementId');
  }

  showSplash() async {
    await ATSplashManager.showSplash(placementID: 'you placementId');
  }

  showSceneSplash() async {
    await ATSplashManager.showSceneSplash(
      sceneID: 'you sceneID',
      placementID: 'you placementId',
    );
  }

  splashListen() {
    ATListenerManager.splashEventHandler.listen((value) {
      switch (value.splashStatus) {
        //广告加载失败
        case SplashStatus.splashDidFailToLoad:
          print(
              "flutter splash--splashDidFailToLoad ---- placementID: ${value.placementID} ---- errStr:${value.requestMessage}");
          break;
        //广告加载成功
        case SplashStatus.splashDidFinishLoading:
          print(
              "flutter splash--splashDidFinishLoading ---- placementID: ${value.placementID} ---- isTimeout：${value.isTimeout}");
          break;
        //广告加载超时
        case SplashStatus.splashDidTimeout:
          print(
              "flutter splash--splashDidTimeout ---- placementID: ${value.placementID}");
          break;
        //广告展示成功
        case SplashStatus.splashDidShowSuccess:
          print(
              "flutter splash--splashDidShowSuccess ---- placementID: ${value.placementID} ---- extra:${value.extraMap}");
          break;
        //广告加载失败
        case SplashStatus.splashDidShowFailed:
          print(
              "flutter splash--splashDidShowFailed ---- placementID: ${value.placementID} ---- errStr:${value.requestMessage}");
          break;
        //广告被点击
        case SplashStatus.splashDidClick:
          print(
              "flutter splash--splashDidClick ---- placementID: ${value.placementID} ---- extra:${value.extraMap}");
          break;
        //DeepLink
        case SplashStatus.splashDidDeepLink:
          print(
              "flutter splash--splashDidDeepLink ---- placementID: ${value.placementID} ---- extra:${value.extraMap} ---- isDeeplinkSuccess:${value.isDeeplinkSuccess}");
          break;
        //广告被关闭
        case SplashStatus.splashDidClose:
          print(
              "flutter splash--splashDidClose ---- placementID: ${value.placementID} ---- extra:${value.extraMap}");
          break;

        case SplashStatus.splashUnknown:
          print("flutter splash--splashUnknown");
          break;
        case SplashStatus.splashWillClose:
          break;
          defalut:
          break;
      }
    });
  }
}
