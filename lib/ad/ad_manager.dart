import 'dart:async';

import 'package:anythink_sdk/at_index.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'ad_listener.dart';
import 'base_ad.dart';
import 'configuration_sdk.dart';
import 'model/ad.dart';
import 'model/models.dart';
import 'topsize.dart';
import 'types.dart';

final adManager = AdManager();

class AdManager {
  bool _isInit = false;

  ClientConfig? clientConfig;

  final Map<int, BaseAd> _loadedAds = {};

  final List<BaseAd> _realtimeAds = [];

  final List<AdOrderStatus> _events = [];
  final List<AdDetail> _adDetails = [];

  BaseAd? loadedAdForType(int type) {
    if (_loadedAds.containsKey(type)) {
      BaseAd? baseAd = _loadedAds[type];
      if (baseAd?.loadSuccess == true) {
        return baseAd;
      }
    }
    return null;
  }

  void closeAd(int type) {
    debugPrint("closeAd");
    if (_loadedAds.containsKey(type)) {
      _loadedAds.remove(type);
    }
  }

  Future<void> loadNextRealtimeAd() async {
    debugPrint("loadNextRealtimeAd beign");

    if (_realtimeAds.isNotEmpty) {
      BaseAd baseAd = _realtimeAds.first;
      _realtimeAds.remove(baseAd);

      if (baseAd.ad.adsType == AdType.intertitial.code) {
        _loadedAds.remove(AdType.intertitial.code);
        loadInterstitialAd(baseAd.ad,
            showAfterLoaded: baseAd.showAfterLoaded,
            listener: baseAd.listener,
            locationId: baseAd.locationId);
      } else if (baseAd.ad.adsType == AdType.reward.code) {
        _loadedAds.remove(AdType.reward.code);
        loadRewardAd(baseAd.ad,
            listener: baseAd.listener,
            showAfterLoaded: baseAd.showAfterLoaded,
            locationId: baseAd.locationId);
      } else {
        loadNextRealtimeAd();
      }
    }
  }

  Future<bool> realtimeShowFullscreenAd(
      {String? intLocation, String? rewLocation, AdListener? listener}) async {
    _realtimeAds.clear();

    debugPrint("realtimeShowFullscreenAd begin");

    if (intLocation?.isNotEmpty == true) {
      bool hasAd = await hasInterstitialAdReady();
      if (hasAd) {
        _loadedAds[AdType.intertitial.code]?.listener = listener;
        showInterstitialAd();
        return true;
      }
    }

    if (rewLocation?.isNotEmpty == true) {
      bool hasAd = await hasRewardAdReady();
      if (hasAd) {
        _loadedAds[AdType.reward.code]?.listener = listener;
        showRewardedVideo();
        return true;
      }
    }

    if (intLocation?.isNotEmpty == true) {
      if (!_loadedAds.containsKey(AdType.intertitial)) {
        //  Ad? ad = createAd(AdType.intertitial);

        Ad? ad = Ad(
            id: 0,
            appId: 0,
            adsId: intLocation,
            adsPlatform: AdPlatform.pangle.code,
            position: 0,
            adsType: AdType.intertitial.code);

        if (ad != null) {
          BaseAd baseAd = BaseAd(ad: ad, showAfterLoaded: true);
          baseAd.listener = listener;
          baseAd.locationId = intLocation;

          _realtimeAds.add(baseAd);
        } else {
          debugPrint("createAd intertitial null");
        }
      }
    }

    if (rewLocation?.isNotEmpty == true) {
      if (!_loadedAds.containsKey(AdType.reward)) {
        Ad? ad = createAd(AdType.reward);
        if (ad != null) {
          BaseAd baseAd = BaseAd(ad: ad, showAfterLoaded: true);
          baseAd.listener = listener;
          baseAd.locationId = rewLocation;
          _realtimeAds.add(baseAd);
        } else {
          debugPrint("createAd reward null");
        }
      }
    }
    if (_realtimeAds.isNotEmpty) {
      loadNextRealtimeAd();
    } else {
      listener?.onLoadedFailed?.call(Ad());
    }
    // listener?.onClose?.call(Ad());
    return Future.value(false);
  }

  Future<bool> showFullscreenAd(
      {String? intLocation, String? rewLocation, AdListener? listener}) async {
    debugPrint("showFullscreenAd beign");
    if (intLocation?.isNotEmpty == true) {
      bool hasAd = await hasInterstitialAdReady();
      if (hasAd) {
        if (listener != null) {
          _loadedAds[AdType.intertitial.code]?.listener = listener;
        }

        showInterstitialAd();
        return true;
      }
    }

    if (rewLocation?.isNotEmpty == true) {
      bool hasAd = await hasRewardAdReady();
      if (hasAd) {
        _loadedAds[AdType.reward.code]?.listener = listener;
        showRewardedVideo();
        return true;
      }
    }
    listener?.onClose?.call(Ad());
    return Future.value(false);
  }

  // 定时拉取配置
  scheduleTask() {
    if (!_isInit) {
      _isInit = true;
      getClientConfig();
      Timer.periodic(const Duration(seconds: 120), (timer) {
        getClientConfig();
      });

      Timer.periodic(const Duration(seconds: 30), (timer) {
        if (_adDetails.isNotEmpty) {
          _doSendDetails();
        }
        if (_events.isNotEmpty) {
          _doSendEvents();
        }
      });
    }
  }

  getClientConfig() async {
    debugPrint("getClientConfig beign");
    //  ApiResponse<ClientConfig> response = await AdApi.getClientConfig(md5: clientConfig?.md5);
    //   if (response.isSuccess()) {
    //     if (response.data != null && response.data?.md5 != clientConfig?.md5) {
    //       clientConfig = response.data;
    //     }
    //   }
  }

  bool isAdEnabled() {
    return clientConfig?.appConfig?.adSwitch == 1;
  }

  bool isLocationEnabled(String locationId) {
    if (clientConfig?.location?.isNotEmpty == true) {
      for (Location location in clientConfig!.location!) {
        if (location.locationUid == locationId) {
          return true;
        }
      }
    }
    return false;
  }

// 创建广告
  Ad? createAd(AdType type) {
    if (clientConfig?.ads?.isNotEmpty != true) {
      debugPrint("clientConfig ads is null ");
      return null;
    }

    Ad? ad;
    for (Ad item in clientConfig!.ads!) {
      if (item.adsType == type.code) {
        ad = item;
        break;
      }
    }

    ad?.orderNum = const Uuid().v4();
    return ad;
  }

  String getPlacementId(Ad ad) {
    if (Configuration.inProduction) {
      return ad.adsId ?? "";
    }
    if (ad.adsType == AdType.intertitial.code) {
      return Configuration.interstitialPlacementID;
    }
    if (ad.adsType == AdType.reward.code) {
      return Configuration.rewarderPlacementID;
    }
    if (ad.adsType == AdType.native.code) {
      return Configuration.nativePlacementID;
    }
    if (ad.adsType == AdType.banner.code) {
      return Configuration.bannerPlacementID;
    }

    return "";
  }

// 加载插屏
  Future<void> loadInterstitialAd(Ad ad,
      {bool showAfterLoaded = false,
      String? locationId,
      AdListener? listener}) async {
    debugPrint("loadInterstitialAd");
    if (ad.adsType == null || _loadedAds.containsKey(ad.adsType)) {
      return Future<void>.value();
    }

    BaseAd baseAd = BaseAd(ad: ad, showAfterLoaded: showAfterLoaded);

    baseAd.locationId = locationId;
    if (listener != null) {
      baseAd.listener = listener;
    }

    _loadedAds[ad.adsType!] = baseAd;

    String placementID = getPlacementId(ad);
    // Configuration.interstitialPlacementID;
    await ATInterstitialManager.loadInterstitialAd(
        placementID: placementID,
        extraMap: {
          // "testKInterKey": "aaaaaa",
          // Sigmob rewarded video ----> Interstitial ads
          // ATInterstitialManager.useRewardedVideoAsInterstitialKey(): true
        });
  }

  Future<bool> hasInterstitialAdReady() async {
    BaseAd? baseAd = _loadedAds[AdType.intertitial.code];
    if (baseAd == null) {
      return Future.value(false);
    }

    String placementID = getPlacementId(baseAd.ad);

// Configuration.interstitialPlacementID
    return await ATInterstitialManager.hasInterstitialAdReady(
      placementID: placementID,
    );
  }

  showInterstitialAd() async {
    BaseAd? baseAd = _loadedAds[AdType.intertitial.code];
    if (baseAd == null) {
      return Future.value(false);
    }
    String placementID = getPlacementId(baseAd.ad);
    // Configuration.interstitialPlacementID

    await ATInterstitialManager.showInterstitialAd(
      placementID: placementID,
    );
  }

// 加载激励
  Future<void> loadRewardAd(Ad ad,
      {bool showAfterLoaded = false,
      String? locationId,
      AdListener? listener}) async {
    debugPrint("loadRewardAd");
    if (ad.adsType == null ||
        ad.adsId == null ||
        _loadedAds.containsKey(ad.adsType)) {
      return Future<void>.value();
    }

    BaseAd baseAd = BaseAd(ad: ad, showAfterLoaded: showAfterLoaded);
    baseAd.locationId = locationId;
    if (listener != null) {
      baseAd.listener = listener;
    }
    _loadedAds[ad.adsType!] = baseAd;

    String placementID = getPlacementId(ad);
    // Configuration.rewarderPlacementID
    await ATRewardedManager.loadRewardedVideo(
        placementID: placementID,
        extraMap: {
          // ATRewardedManager.kATAdLoadingExtraUserDataKeywordKey(): '1234',
          // ATRewardedManager.kATAdLoadingExtraUserIDKey(): '1234',
        });
  }

  Future<bool> hasRewardAdReady() async {
    BaseAd? baseAd = _loadedAds[AdType.reward.code];
    if (baseAd == null) {
      return Future.value(false);
    }
    String placementID = getPlacementId(baseAd.ad);

    return await ATRewardedManager.rewardedVideoReady(
      placementID: placementID,
    );
  }

  showRewardedVideo() async {
    BaseAd? baseAd = _loadedAds[AdType.reward.code];
    if (baseAd == null) {
      return Future.value(false);
    }
    String placementID = getPlacementId(baseAd.ad);
    await ATRewardedManager.showRewardedVideo(
      placementID: placementID,
    );
  }

  // native

  // 加载原生
  Future<void> loadNativeAdByLocation(
      {required String locationId, AdListener? listener}) async {
    debugPrint("loadNativeAd");

    // 查看有没有缓存
    if (_loadedAds.containsKey(AdType.native.code)) {
      // 判断是否过期
      BaseAd? baseAd = _loadedAds[AdType.native.code];
      if (baseAd?.loadSuccess == true) {
        listener?.onLoaded?.call(baseAd);
        baseAd?.listener = listener;
        return Future.value();
      }
      if (baseAd?.loadTime != null &&
          (DateTime.now().millisecondsSinceEpoch - baseAd!.loadTime > 30000)) {
        _loadedAds.remove(AdType.native.code);
      } else {
        listener?.onLoaded?.call(baseAd);
        return Future.value();
      }
    }

    Ad? ad = createAd(AdType.native);
    if (ad != null) {
      BaseAd baseAd = BaseAd(ad: ad, showAfterLoaded: true);
      baseAd.listener = listener;
      baseAd.locationId = locationId;

      await loadNativeAd(ad, listener: listener);
    } else {
      listener?.onLoadedFailed?.call("create native error");
    }
  }

  Future<void> loadNativeAd(Ad ad,
      {String? locationId, AdListener? listener}) async {
    debugPrint("loadNativeAd");

    if (ad.adsType == null ||
        ad.adsId == null ||
        _loadedAds.containsKey(ad.adsType)) {
      listener?.onLoadedFailed?.call(ad);
      return Future<void>.value();
    }

    BaseAd baseAd = BaseAd(ad: ad);
    baseAd.locationId = locationId;
    if (listener != null) {
      baseAd.listener = listener;
    }
    _loadedAds[ad.adsType!] = baseAd;

    String placementID = getPlacementId(ad);
    // Configuration.rewarderPlacementID
    await ATNativeManager.loadNativeAd(placementID: placementID, extraMap: {
      ATCommon.isNativeShow(): true,
      ATCommon.getAdSizeKey(): ATNativeManager.createNativeSubViewAttribute(
        topSizeTool.getWidth(),
        340,
      ),
      ATNativeManager.isAdaptiveHeight(): true
      // ATRewardedManager.kATAdLoadingExtraUserDataKeywordKey(): '1234',
      // ATRewardedManager.kATAdLoadingExtraUserIDKey(): '1234',
    });
  }

  Future<bool> hasNativeAdReady() async {
    BaseAd? baseAd = _loadedAds[AdType.native.code];
    if (baseAd == null) {
      return Future.value(false);
    }
    String placementID = getPlacementId(baseAd.ad);

    return await ATNativeManager.nativeAdReady(
      placementID: placementID,
    );
  }

  Widget getNativeWidget(BaseAd ad) {
    return PlatformNativeWidget(
      getPlacementId(ad.ad),
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

  // 加载banner
  Future<void> loadBannerAdByLocation(
      {required String locationId, AdListener? listener}) async {
    debugPrint("loadBannerAdByLocation");

// 查看有没有缓存
    if (_loadedAds.containsKey(AdType.banner.code)) {
      // 判断是否过期
      BaseAd? baseAd = _loadedAds[AdType.banner.code];
      if (baseAd?.loadSuccess == true) {
        listener?.onLoaded?.call(baseAd);
        baseAd?.listener = listener;
        return Future.value();
      }
      if (baseAd?.loadTime != null &&
          (DateTime.now().millisecondsSinceEpoch - baseAd!.loadTime > 30000)) {
        _loadedAds.remove(AdType.banner.code);
      } else {
        listener?.onLoaded?.call(baseAd);
        return Future.value();
      }
    }
    Ad? ad = createAd(AdType.banner);

    // ad = Ad();
    // ad.adsType = AdType.banner.code;
    // ad.adsId = "";
    if (ad != null) {
      BaseAd baseAd = BaseAd(ad: ad, showAfterLoaded: true);
      baseAd.listener = listener;
      baseAd.locationId = locationId;

      await loadBannerAd(ad, listener: listener);
    } else {
      listener?.onLoadedFailed?.call(ad);
    }
  }

  Future<void> loadBannerAd(Ad ad,
      {String? locationId, AdListener? listener}) async {
    debugPrint("loaBannerAd");
    if (ad.adsType == null ||
        ad.adsId == null ||
        _loadedAds.containsKey(ad.adsType)) {
      listener?.onLoadedFailed?.call("create banner error");
      return Future<void>.value();
    }

    BaseAd baseAd = BaseAd(ad: ad);
    baseAd.locationId = locationId;
    if (listener != null) {
      baseAd.listener = listener;
    }
    _loadedAds[ad.adsType!] = baseAd;

    String placementID = getPlacementId(ad);
    debugPrint("loaBannerAd placementID $placementID");

    // Configuration.rewarderPlacementID
    await ATBannerManager.loadBannerAd(placementID: placementID, extraMap: {
      ATCommon.isNativeShow(): true,
      ATCommon.getAdSizeKey(): ATBannerManager.createLoadBannerAdSize(
          TopSize().getWidth(), TopSize().getWidth() * (50 / 320)),
      ATBannerManager.getAdaptiveWidthKey(): TopSize().getWidth(),
      ATBannerManager.getAdaptiveOrientationKey():
          ATBannerManager.adaptiveOrientationCurrent(),
      // ATRewardedManager.kATAdLoadingExtraUserDataKeywordKey(): '1234',
      // ATRewardedManager.kATAdLoadingExtraUserIDKey(): '1234',
    });
  }

  Future<bool> hasBannerAdReady() async {
    BaseAd? baseAd = _loadedAds[AdType.banner.code];
    if (baseAd == null) {
      return Future.value(false);
    }
    String placementID = getPlacementId(baseAd.ad);

    return await ATBannerManager.bannerAdReady(
      placementID: placementID,
    );
  }

  Widget getBannerWidget(BaseAd ad) {
    debugPrint("getBannerWidget ${ad.ad.adsId} ${ad.ad.orderNum}");
    return PlatformBannerWidget(
      getPlacementId(ad.ad),
      sceneID: "",
      // uniqueKey: ad.key,
    );
  }

  // listener

  // listener
  onAdLoaded({required int adType}) {
    BaseAd? baseAd = _loadedAds[adType];
    baseAd?.loadSuccess = true;
    baseAd?.listener?.onLoaded?.call(baseAd);

    if (baseAd?.showAfterLoaded == true) {
      if (baseAd?.ad.adsType == AdType.intertitial.code) {
        showInterstitialAd();
      } else if (baseAd?.ad.adsType == AdType.reward.code) {
        showRewardedVideo();
      }
    }
    if (baseAd != null) {
      sendAdEvent(baseAd, AdEvent.loadSuccess);
    }
  }

  onAdLoadFailed({required int adType}) {
    BaseAd? baseAd = _loadedAds[adType];
    _loadedAds.remove(adType);
    baseAd?.listener?.onLoadedFailed?.call(baseAd);

    // 加载下一个实时广告
    if (adType == AdType.intertitial.code || adType == AdType.reward.code) {
      if (_realtimeAds.isNotEmpty) {
        loadNextRealtimeAd();
      }
    }

    if (baseAd != null) {
      sendAdEvent(baseAd, AdEvent.loadFailed);
    }
  }

  onAdImpression({required int adType, Map<String, dynamic>? adInfo}) {
    //  Log.d("onAdImpression $adType");
    BaseAd? baseAd = _loadedAds[adType];
    baseAd?.listener?.onImpression?.call(baseAd);
    if (baseAd != null) {
      baseAd.networkName = networkNameFromCode(adInfo?["network_firm_id"]);
      sendAdEvent(baseAd, AdEvent.impression);
      sendAdDetail(baseAd, adInfo);
    }
  }

  onAdClose({required int adType}) {
    BaseAd? baseAd = _loadedAds[adType];
    baseAd?.listener?.onClose?.call(baseAd);
    _loadedAds.remove(adType);
  }

  onAdClick({required int adType}) {
    BaseAd? baseAd = _loadedAds[adType];
    baseAd?.listener?.onClick?.call(baseAd);
    if (baseAd != null) {
      sendAdEvent(baseAd, AdEvent.click);
    }
  }

  sendAdEvent(BaseAd baseAd, AdEvent event) {
    _events.add(AdOrderStatus(
        status: event.code,
        adPlatform: baseAd.ad.adsPlatform,
        adType: baseAd.ad.adsType,
        orderNum: baseAd.ad.orderNum,
        adLocationUid: baseAd.locationId));
  }

  sendAdDetail(BaseAd baseAd, Map<String, dynamic>? detail) {
    _adDetails.add(AdDetail(
        adPlatform: baseAd.ad.adsPlatform,
        adType: baseAd.ad.adsType,
        networkName: baseAd.networkName,
        orderNum: baseAd.ad.orderNum,
        adLocationUid: baseAd.locationId,
        detail: detail));
  }

  _doSendEvents() async {
    List<AdOrderStatus> list = List.from(_events);
    _events.clear();
    // ApiResponse response = await AdApi.batchSyncAdOrder(list);
  }

  _doSendDetails() async {
    List<AdDetail> list = List.from(_adDetails);
    _adDetails.clear();
    //  ApiResponse response = await AdApi.reportAdDetailBatch(list);
  }

  String networkNameFromCode(int code) {
    switch (code) {
      case 1:
        return "Facebook";
      case 2:
        return "Admob";
      case 3:
        return "Inmobi";
      case 5:
        return "Applovin";
      case 6:
        return "Mintegral";
      case 9:
        return "Chartboost";
      case 11:
        return "Ironsource";
      case 12:
        return "UnityAds";
      case 13:
        return "Vungle";
      case 50:
        return "Pangle";
      default:
        return "firmId:$code";
    }
  }
}
