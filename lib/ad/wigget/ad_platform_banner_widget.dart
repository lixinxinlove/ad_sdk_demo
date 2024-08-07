import 'package:anythink_sdk/at_banner.dart';
import 'package:anythink_sdk/at_common.dart';
import 'package:anythink_sdk/at_platformview/at_banner_platform_widget.dart';
import 'package:flutter/material.dart';

import '../topsize.dart';

///Banner 广告
class AdPlatformBannerWidget extends StatefulWidget {
  final String placementID;

  final String? sceneID;

  const AdPlatformBannerWidget(this.placementID, {super.key, this.sceneID});

  @override
  State<AdPlatformBannerWidget> createState() => _AdPlatformBannerWidgetState();
}

class _AdPlatformBannerWidgetState extends State<AdPlatformBannerWidget> {
  bool isAdReady = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      print("flutter横幅广告视频缓存--------加载广告0");
      _loadBannerAd();
    });

    Future.delayed(const Duration(seconds: 8), () {
      _hasBannerAdReady();
    });

    //_hasBannerAdReady();
  }

  _loadBannerAd() async {
    print("flutter横幅广告视频缓存--------加载广告1");
    await ATBannerManager.loadBannerAd(
        placementID: widget.placementID,
        extraMap: {
          // 该高度是根据横幅宽高比为320:50来计算，如果是其他宽高比请按实际来计算。
          ATCommon.getAdSizeKey(): ATBannerManager.createLoadBannerAdSize(
              TopSize().getWidth(), TopSize().getWidth() * (50 / 320)),
          ATBannerManager.getAdaptiveWidthKey(): TopSize().getWidth(),
          ATBannerManager.getAdaptiveOrientationKey():
              ATBannerManager.adaptiveOrientationCurrent(),
        }).then((v) {
      print("flutter横幅广告视频缓存--------加载广告4$v");
    });

    print("flutter横幅广告视频缓存--------加载广告3");
  }

  ///判断是否有广告缓存以及获取广告状态
  _hasBannerAdReady() async {
    print("flutter横幅广告视频缓存--------0");
    await ATBannerManager.bannerAdReady(placementID: widget.placementID)
        .then((value) {
      print('flutter横幅广告视频缓存------1$value');


      if (value) {
        setState(() {
          isAdReady = value;
          //ATBannerManager.afreshShowBannerAd(placementID: widget.placementID);
        });

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isAdReady) {
      return SizedBox(
        height: 80,
        child:
            PlatformBannerWidget(widget.placementID, sceneID: widget.sceneID),
      );
    }
    return Container(
      height: 80,
    );
  }
}
