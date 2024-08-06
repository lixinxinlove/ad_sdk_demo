import 'dart:convert';

import 'package:anythink_sdk/at_banner_response.dart';
import 'package:anythink_sdk/at_index.dart';
import 'package:anythink_sdk/at_interstitial_response.dart';
import 'package:anythink_sdk/at_listener.dart';

import '../ad_manager.dart';
import '../types.dart';

final ListenerManager = ListenerTool();

class ListenerTool {
  rewarderListen() {
    ATListenerManager.rewardedVideoEventHandler.listen((value) {
      switch (value.rewardStatus) {
        case RewardedStatus.rewardedVideoDidFailToLoad:
          print(
              "激励广告--flutter rewardedVideoDidFailToLoad ---- placementID: ${value.placementID} ---- errStr:${value.requestMessage}");
          adManager.onAdLoadFailed(adType: AdType.reward.code);
          break;
        case RewardedStatus.rewardedVideoDidFinishLoading:
          print(
              "激励广告--flutter rewardedVideoDidFinishLoading ---- placementID: ${value.placementID}");
          adManager.onAdLoaded(adType: AdType.reward.code);
          break;
        case RewardedStatus.rewardedVideoDidStartPlaying:
          print(
              "激励广告--flutter rewardedVideoDidStartPlaying ---- placementID: ${value.placementID} ---- extra:${value.extraMap}");
          Map<String, dynamic> adInfo =
              jsonDecode(jsonEncode(value.extraMap)) as Map<String, dynamic>;
          print("atInfo ${adInfo}");
          adManager.onAdImpression(adType: AdType.reward.code, adInfo: adInfo);
          break;
        case RewardedStatus.rewardedVideoDidEndPlaying:
          print(
              "激励广告--flutter rewardedVideoDidEndPlaying ---- placementID: ${value.placementID} ---- extra:${value.extraMap}");
          break;
        case RewardedStatus.rewardedVideoDidFailToPlay:
          print(
              "激励广告--flutter rewardedVideoDidFailToPlay ---- placementID: ${value.placementID} ---- errStr:${value.extraMap}");
          break;
        case RewardedStatus.rewardedVideoDidRewardSuccess:
          print(
              "激励广告--flutter rewardedVideoDidRewardSuccess ---- placementID: ${value.placementID} ---- extra:${value.extraMap}");
          break;
        case RewardedStatus.rewardedVideoDidClick:
          print(
              "激励广告--flutter rewardedVideoDidClick ---- placementID: ${value.placementID} ---- extra:${value.extraMap}");
          adManager.onAdClick(adType: AdType.reward.code);
          break;
        case RewardedStatus.rewardedVideoDidDeepLink:
          print(
              "激励广告--flutter rewardedVideoDidDeepLink ---- placementID: ${value.placementID} ---- extra:${value.extraMap} ---- isDeeplinkSuccess:${value.isDeeplinkSuccess}");
          break;
        case RewardedStatus.rewardedVideoDidClose:
          print(
              "激励广告--flutter rewardedVideoDidClose ---- placementID: ${value.placementID} ---- extra:${value.extraMap}");
          adManager.onAdClose(adType: AdType.reward.code);
          break;
        case RewardedStatus.rewardedVideoUnknown:
          print("激励广告--flutter rewardedVideoUnknown");
          break;

        case RewardedStatus.rewardedVideoDidAgainStartPlaying:
          print(
              "激励广告--flutter rewardedVideoDidAgainStartPlaying ---- placementID: ${value.placementID} ---- extra:${value.extraMap}");
          break;
        case RewardedStatus.rewardedVideoDidAgainEndPlaying:
          print(
              "激励广告--flutter rewardedVideoDidAgainEndPlaying ---- placementID: ${value.placementID} ---- extra:${value.extraMap}");
          break;
        case RewardedStatus.rewardedVideoDidAgainFailToPlay:
          print(
              "激励广告--flutter rewardedVideoDidAgainFailToPlay ---- placementID: ${value.placementID} ---- extra:${value.extraMap}");
          break;
        case RewardedStatus.rewardedVideoDidAgainRewardSuccess:
          print(
              "激励广告--flutter rewardedVideoDidAgainRewardSuccess ---- placementID: ${value.placementID} ---- extra:${value.extraMap}");
          break;
        case RewardedStatus.rewardedVideoDidAgainClick:
          print(
              "激励广告--flutter rewardedVideoDidAgainClick ---- placementID: ${value.placementID} ---- extra:${value.extraMap}");
          break;
      }
    });
  }

  interListen() {
    ATListenerManager.interstitialEventHandler.listen((value) {
      switch (value.interstatus) {
        case InterstitialStatus.interstitialAdFailToLoadAD:
          print(
              "插屏广告--flutter interstitialAdFailToLoadAD ---- placementID: ${value.placementID} ---- errStr:${value.requestMessage}");
          adManager.onAdLoadFailed(adType: AdType.intertitial.code);
          break;
        case InterstitialStatus.interstitialAdDidFinishLoading:
          print(
              "插屏广告--flutter interstitialAdDidFinishLoading ---- placementID: ${value.placementID}");
          adManager.onAdLoaded(adType: AdType.intertitial.code);
          break;
        case InterstitialStatus.interstitialAdDidStartPlaying:
          print(
              "插屏广告--flutter interstitialAdDidStartPlaying ---- placementID: ${value.placementID} ---- extra:${value.extraMap}");

          break;
        case InterstitialStatus.interstitialAdDidEndPlaying:
          print(
              "插屏广告--flutter interstitialAdDidEndPlaying ---- placementID: ${value.placementID} ---- extra:${value.extraMap}");
          break;
        case InterstitialStatus.interstitialDidFailToPlayVideo:
          print(
              "插屏广告--flutter interstitialDidFailToPlayVideo ---- placementID: ${value.placementID} ---- errStr:${value.requestMessage}");
          break;
        case InterstitialStatus.interstitialDidShowSucceed:
          print(
              "插屏广告--flutter interstitialDidShowSucceed ---- placementID: ${value.placementID} ---- extra:${value.extraMap}");
          Map<String, dynamic> adInfo =
              jsonDecode(jsonEncode(value.extraMap)) as Map<String, dynamic>;
          adManager.onAdImpression(
              adType: AdType.intertitial.code, adInfo: adInfo);
          break;
        case InterstitialStatus.interstitialFailedToShow:
          print(
              "插屏广告--flutter interstitialFailedToShow ---- placementID: ${value.placementID} ---- errStr:${value.requestMessage}");
          break;
        case InterstitialStatus.interstitialAdDidClick:
          print(
              "插屏广告--flutter interstitialAdDidClick ---- placementID: ${value.placementID} ---- extra:${value.extraMap}");
          adManager.onAdClick(adType: AdType.intertitial.code);
          break;
        case InterstitialStatus.interstitialAdDidDeepLink:
          print(
              "插屏广告--flutter interstitialAdDidDeepLink ---- placementID: ${value.placementID} ---- extra:${value.extraMap}");
          break;
        case InterstitialStatus.interstitialAdDidClose:
          print(
              "插屏广告--flutter interstitialAdDidClose ---- placementID: ${value.placementID} ---- extra:${value.extraMap}");
          adManager.onAdClose(adType: AdType.intertitial.code);
          break;
        case InterstitialStatus.interstitialUnknown:
          print("插屏广告--flutter interstitialUnknown");
          break;
      }
    });
  }

  bannerListen() {
    ATListenerManager.bannerEventHandler.listen((value) {
      switch (value.bannerStatus) {
        case BannerStatus.bannerAdFailToLoadAD:
          print(
              "横幅广告--flutter bannerAdFailToLoadAD ---- placementID: ${value.placementID} ---- errStr:${value.requestMessage}");
          adManager.onAdLoadFailed(adType: AdType.banner.code);
          break;
        case BannerStatus.bannerAdDidFinishLoading:
          print(
              "横幅广告--flutter bannerAdDidFinishLoading ---- placementID: ${value.placementID}");
          adManager.onAdLoaded(adType: AdType.banner.code);
          break;
        case BannerStatus.bannerAdAutoRefreshSucceed:
          print(
              "横幅广告--flutter bannerAdAutoRefreshSucceed ---- placementID: ${value.placementID} ---- extra:${value.extraMap}");
          break;
        case BannerStatus.bannerAdDidClick:
          print(
              "横幅广告--flutter bannerAdDidClick ---- placementID: ${value.placementID} ---- extra:${value.extraMap}");
          adManager.onAdClick(adType: AdType.banner.code);
          break;
        case BannerStatus.bannerAdDidDeepLink:
          print(
              "横幅广告--flutter bannerAdDidDeepLink ---- placementID: ${value.placementID} ---- extra:${value.extraMap} ---- isDeeplinkSuccess:${value.isDeeplinkSuccess}");
          break;
        case BannerStatus.bannerAdDidShowSucceed:
          print(
              "横幅广告--flutter bannerAdDidShowSucceed ---- placementID: ${value.placementID} ---- extra:${value.extraMap}");
          Map<String, dynamic> adInfo =
              jsonDecode(jsonEncode(value.extraMap)) as Map<String, dynamic>;
          adManager.onAdImpression(adType: AdType.banner.code, adInfo: adInfo);
          break;
        case BannerStatus.bannerAdTapCloseButton:
          print(
              "横幅广告--flutter bannerAdTapCloseButton ---- placementID: ${value.placementID} ---- extra:${value.extraMap}");
          adManager.onAdClose(adType: AdType.banner.code);
          break;
        case BannerStatus.bannerAdAutoRefreshFail:
          print(
              "横幅广告--flutter bannerAdAutoRefreshFail ---- placementID: ${value.placementID} ---- errStr:${value.requestMessage}");
          break;
        case BannerStatus.bannerAdUnknown:
          print("横幅广告--flutter bannerAdUnknown");
          break;
      }
    });
  }

  nativeListen() {
    ATListenerManager.nativeEventHandler.listen((value) {
      switch (value.nativeStatus) {
        case NativeStatus.nativeAdFailToLoadAD:
          print(
              "原生广告--flutter nativeAdFailToLoadAD ---- placementID: ${value.placementID} ---- errStr:${value.requestMessage}");
          adManager.onAdLoadFailed(adType: AdType.native.code);
          break;
        case NativeStatus.nativeAdDidFinishLoading:
          print(
              "原生广告--flutter nativeAdDidFinishLoading ---- placementID: ${value.placementID}");
          adManager.onAdLoaded(adType: AdType.native.code);
          break;
        case NativeStatus.nativeAdDidClick:
          print(
              "原生广告--flutter nativeAdDidClick ---- placementID: ${value.placementID} ---- extra:${value.extraMap}");
          adManager.onAdClick(adType: AdType.native.code);
          break;
        case NativeStatus.nativeAdDidDeepLink:
          print(
              "原生广告--flutter nativeAdDidDeepLink ---- placementID: ${value.placementID} ---- extra:${value.extraMap} ---- isDeeplinkSuccess:${value.isDeeplinkSuccess}");
          break;
        case NativeStatus.nativeAdDidEndPlayingVideo:
          print(
              "原生广告--flutter nativeAdDidEndPlayingVideo ---- placementID: ${value.placementID} ---- extra:${value.extraMap}");
          break;
        case NativeStatus.nativeAdEnterFullScreenVideo:
          print(
              "原生广告--flutter nativeAdEnterFullScreenVideo ---- placementID: ${value.placementID} ---- extra:${value.extraMap}");
          break;
        case NativeStatus.nativeAdExitFullScreenVideoInAd:
          print(
              "原生广告--flutter nativeAdExitFullScreenVideoInAd ---- placementID: ${value.placementID} ---- extra:${value.extraMap}");
          break;
        case NativeStatus.nativeAdDidShowNativeAd:
          print(
              "原生广告--flutter nativeAdDidShowNativeAd ---- placementID: ${value.placementID} ---- extra:${value.extraMap}");
          Map<String, dynamic> adInfo =
              jsonDecode(jsonEncode(value.extraMap)) as Map<String, dynamic>;
          adManager.onAdImpression(adType: AdType.native.code, adInfo: adInfo);
          break;
        case NativeStatus.nativeAdDidStartPlayingVideo:
          print(
              "原生广告--flutter nativeAdDidStartPlayingVideo ---- placementID: ${value.placementID} ---- extra:${value.extraMap}");
          break;
        case NativeStatus.nativeAdDidTapCloseButton:
          print(
              "原生广告--flutter nativeAdDidTapCloseButton ---- placementID: ${value.placementID} ---- extra:${value.extraMap}");
          adManager.onAdClose(adType: AdType.native.code);
          break;
        case NativeStatus.nativeAdDidCloseDetailInAdView:
          print(
              "原生广告--flutter nativeAdDidCloseDetailInAdView ---- placementID: ${value.placementID} ---- extra:${value.extraMap}");
          break;
        case NativeStatus.nativeAdDidLoadSuccessDraw:
          print(
              "原生广告--flutter nativeAdDidLoadSuccessDraw ---- placementID: ${value.placementID} ---- extra:${value.extraMap}");
          break;
        case NativeStatus.nativeAdUnknown:
          print("原生广告--flutter downloadUnknown");
          break;
      }
    });
  }

  downLoadListen() {
    ATListenerManager.downloadEventHandler.listen((value) {
      switch (value.downloadStatus) {
        case DownloadStatus.downloadStart:
          print(
              "flutter downloadStart ---- placementID: ${value.placementID}, totalBytes: ${value.totalBytes}, currBytes: ${value.currBytes}, "
              "fileName: ${value.fileName}, appName: ${value.appName}, extra: ${value.extraMap}");
          break;
        case DownloadStatus.downloadUpdate:
          print(
              "flutter downloadUpdate ---- placementID: ${value.placementID}, totalBytes: ${value.totalBytes}, currBytes: ${value.currBytes}, "
              "fileName: ${value.fileName}, appName: ${value.appName}, extra: ${value.extraMap}");
          break;
        case DownloadStatus.downloadPause:
          print(
              "flutter downloadPause ---- placementID: ${value.placementID}, totalBytes: ${value.totalBytes}, currBytes: ${value.currBytes}, "
              "fileName: ${value.fileName}, appName: ${value.appName}, extra: ${value.extraMap}");
          break;
        case DownloadStatus.downloadFinished:
          print(
              "flutter downloadFinished ---- placementID: ${value.placementID}, totalBytes: ${value.totalBytes}, "
              "fileName: ${value.fileName}, appName: ${value.appName}, extra: ${value.extraMap}");
          break;
        case DownloadStatus.downloadFailed:
          print(
              "flutter downloadFailed ---- placementID: ${value.placementID}, totalBytes: ${value.totalBytes}, currBytes: ${value.currBytes}, "
              "fileName: ${value.fileName}, appName: ${value.appName}, extra: ${value.extraMap}");
          break;
        case DownloadStatus.downloadInstalled:
          print(
              "flutter downloadInstalled ---- placementID: ${value.placementID}, "
              "fileName: ${value.fileName}, appName: ${value.appName}, extra: ${value.extraMap}");
          break;
        case DownloadStatus.downloadUnknown:
          print("flutter downloadUnknow");
          break;
      }
    });
  }
}
