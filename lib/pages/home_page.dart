import 'package:anythink_sdk/at_banner.dart';
import 'package:anythink_sdk/at_common.dart';
import 'package:anythink_sdk/at_index.dart';
import 'package:anythink_sdk/at_interstitial.dart';
import 'package:anythink_sdk/at_rewarded.dart';
import 'package:flutter/material.dart';

import '../ad/topon_sdk.dart';
import '../ad/topsize.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    TopOnSDK.setupSDK();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          "TopOn",
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 100,
            child: PlatformBannerWidget("b62b41522d24a3"),
          ),
          SizedBox(
            height: 100,
            child: getNativeWidget(),
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  _loadInterstitialAd();
                },
                child: const Text("加载插屏广告"),
              ),
              TextButton(
                onPressed: () {
                  _showInterAd();
                },
                child: const Text("显示插屏"),
              ),
            ],
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  _loadRewardedVideo();
                },
                child: const Text("加载激励广告"),
              ),
              TextButton(
                onPressed: () {
                  _showRewardedAd();
                },
                child: const Text("显示激励"),
              ),
            ],
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  _loadBannerAd();
                },
                child: const Text("加载Banner广告"),
              ),
              TextButton(
                onPressed: () {
                  // 隐藏横幅广告
                  // ATBannerManager.hideBannerAd(placementID: 'b62b41522d24a3');
                  // 移除横幅广告
                  // ATBannerManager.removeBannerAd(placementID: 'b62b41522d24a3');
                  // 显示横幅广告

                  setState(() {
                    ATBannerManager.afreshShowBannerAd(
                        placementID: 'b62b41522d24a3');
                  });
                },
                child: const Text("显示Banner广告"),
              ),
            ],
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  _loadNativeAd();
                },
                child: const Text("加载原生广告"),
              ),
              TextButton(
                onPressed: () {
                  setState(() {});
                },
                child: const Text("显示原生广告"),
              ),
            ],
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  _loadSplash();
                },
                child: const Text("加载开屏广告"),
              ),
              TextButton(
                onPressed: () {
                  _showSplash();
                },
                child: const Text("显示开屏广告"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _loadInterstitialAd() async {
    ATInterstitialManager.loadInterstitialAd(
        placementID: 'b62b4152262689', extraMap: {});
  }

  _showInterAd() async {
    await ATInterstitialManager.showInterstitialAd(
      placementID: 'b62b4152262689',
    );
  }

  _loadRewardedVideo() async {
    await ATRewardedManager.loadRewardedVideo(
        placementID: 'b62b41523c054c',
        extraMap: {
          ATRewardedManager.kATAdLoadingExtraUserDataKeywordKey(): '1234',
          ATRewardedManager.kATAdLoadingExtraUserIDKey(): '1234',
        });
  }

  _showRewardedAd() async {
    await ATRewardedManager.showRewardedVideo(
      placementID: 'b62b41523c054c',
    );
  }

  _loadBannerAd() async {
    await ATBannerManager.loadBannerAd(
        placementID: 'b62b41522d24a3',
        extraMap: {
          // 该高度是根据横幅宽高比为320:50来计算，如果是其他宽高比请按实际来计算。
          ATCommon.getAdSizeKey(): ATBannerManager.createLoadBannerAdSize(
              TopSize().getWidth(), TopSize().getWidth() * (50 / 320)),
          ATBannerManager.getAdaptiveWidthKey(): TopSize().getWidth(),
          ATBannerManager.getAdaptiveOrientationKey():
              ATBannerManager.adaptiveOrientationCurrent(),
        });
  }

  _loadNativeAd() async {
    await ATNativeManager.loadNativeAd(
        placementID: 'b62b41524379fe',
        extraMap: {
          ATNativeManager.parent():
              ATNativeManager.createNativeSubViewAttribute(
            topSizeTool.getWidth(),
            topSizeTool.getHeight(),
          ),
        });
  }

  Widget getNativeWidget() {
    return PlatformNativeWidget(
      'b62b41524379fe',
      {
        ATNativeManager.parent(): ATNativeManager.createNativeSubViewAttribute(
            topSizeTool.getWidth(), 210,
            backgroundColorStr: '#FFFFFF'),
        ATNativeManager.mainImage():
            ATNativeManager.createNativeSubViewAttribute(
                topSizeTool.getWidth() - 20, 134,
                x: 10, y: 10, backgroundColorStr: '#00000000'),
        ATNativeManager.appIcon(): ATNativeManager.createNativeSubViewAttribute(
            50, 50,
            x: 10, y: 138, backgroundColorStr: 'clearColor'),
        ATNativeManager.mainTitle():
            ATNativeManager.createNativeSubViewAttribute(
          topSizeTool.getWidth() - 190,
          20,
          x: 80,
          y: 142,
          textSize: 15,
        ),
        ATNativeManager.desc(): ATNativeManager.createNativeSubViewAttribute(
            topSizeTool.getWidth() - 190, 20,
            x: 80, y: 173, textSize: 15),
        ATNativeManager.cta(): ATNativeManager.createNativeSubViewAttribute(
          100,
          37,
          x: topSizeTool.getWidth() - 110,
          y: 152,
          textSize: 15,
          textColorStr: "#FFFFFF",
          backgroundColorStr: "#2095F1",
          textAlignmentStr: "center",
        ),
        ATNativeManager.adLogo(): ATNativeManager.createNativeSubViewAttribute(
            20, 10,
            x: 10, y: 10, backgroundColorStr: '#00000000'),
        ATNativeManager.dislike(): ATNativeManager.createNativeSubViewAttribute(
          20,
          20,
          x: topSizeTool.getWidth() - 30,
          y: 10,
        ),
      },
      sceneID: "",
    );
  }

  _loadSplash() async {
    await ATSplashManager.loadSplash(
        placementID: 'b62b41c7818614', extraMap: {});
  }

  _showSplash() async {
    await ATSplashManager.showSplash(placementID: 'b62b41c7818614');
  }
}
