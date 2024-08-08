import 'package:ad_sdk_demo/ad/ad_manager.dart';
import 'package:anythink_sdk/at_index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../ad/ad_listener.dart';
import '../ad/topon_sdk.dart';
import '../ad/topsize.dart';
import '../ad/wigget/ad_platform_banner_widget.dart';

import 'dart:isolate';
import 'package:async/async.dart';

import 'draggable_scrollable_sheet_page.dart';

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AdPlatformBannerWidget("b62b41522d24a3"),
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
                TextButton(
                  onPressed: () {
                    _showInt();
                  },
                  child: const Text("加载显示插屏"),
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
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    ff1();
                  },
                  child: const Text("同步"),
                ),
                TextButton(
                  onPressed: () {
                    ff2();
                  },
                  child: const Text("异步"),
                ),
                TextButton(
                  onPressed: () {
                    final v = f3();
                    print(v.$1);
                    print(v.$2);
                  },
                  child: const Text("多返回值"),
                ),
                TextButton(
                  onPressed: () {
                    final v = f4();
                    print(v.x);
                    print(v.y);
                  },
                  child: const Text("多返回值"),
                ),
                TextButton(
                  onPressed: () {
                    mainIsolate();
                    //  fIsolate();
                    // isolateFun1();
                  },
                  child: const Text("Isolate"),
                ),
              ],
            ),

            Row(children: [


              TextButton(
                onPressed: () {
                  Navigator.push(context, CupertinoPageRoute(builder: (buildContext) {
                    return const DraggableScrollableSheetPage();
                  }));
                },
                child: const Text("Draggable"),
              ),

            ],)

          ],
        ),
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

  _hasInterAdReady({required String placementID}) async {
    await ATInterstitialManager.hasInterstitialAdReady(
      placementID: placementID,
    ).then((value) {
      debugPrint('flutter插屏广告视频缓存$value');
    });
  }

  _showInt() {
    adManager.realtimeShowFullscreenAd(
        intLocation: "b62b4152262689",
        rewLocation: null,
        listener: AdListener(onLoaded: (ad) {
          print("_showInt--onLoaded");
        }, onLoadedFailed: (ad) {
          print("_showInt--onLoadedFailed");
        }, onImpression: (ad) {
          print("_showInt--onImpression");
        }, onClick: (ad) {
          print("_showInt--onClick");
        }, onClose: (ad) {
          print("_showInt--onClose");
        }));
  }

  ///****************************************
  ///同步生成器
  Iterable<int> f1(int x) sync* {
    int k = 0;
    while (k < x) {
      k++;
      yield k;
    }
  }

  ///异步生成器
  Stream<int> f2(int x) async* {
    int k = 0;
    while (k < x) {
      k++;
      yield k;
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  ff1() {
    final val = f1(10);
    print(val);
  }

  ff2() {
    final Stream<int> stream = f2(10);
    stream.listen((v) {
      debugPrint("$v");
    });
  }

  (int, int) f3() {
    return (1, 2);
  }

  ({int x, int y}) f4() {
    return (x: 1, y: 2);
  }

  fIsolate() async {
    final future = Isolate.run<int>(() async {
      return await fMax(100000000000);
    });
    print(future);
  }

  //final ReceivePort receivePort = ReceivePort();
  //Isolate.spawn(isolateWorker, receivePort.sendPort);

  mainIsolate() async {
    final ReceivePort receivePort = ReceivePort();
    Isolate.spawn(isolateWorker, receivePort.sendPort);

    final events = StreamQueue(receivePort);
    final SendPort sendPort = await events.next;

    await Future.delayed(const Duration(seconds: 2));
    sendPort.send(100);

    final sum = await events.next;
    print("sum=$sum");
    events.cancel();
    Isolate.exit();
  }

  isolateFun1() {
    // Isolate.spawn((message) {
    //   print("匿名函数线程：$message");
    // }, "ddd");

    Isolate.spawn(newThread1, "普通线程");
  }
}

// 创建一个额外线程
//在flutter中使用时newThread1不能写在主进程所在的类里。否则会提示
void newThread1(String message) async {
  print(message);
}

void isolateWorker(SendPort mainSendPost) async {
  final ReceivePort receivePort = ReceivePort();
  mainSendPost.send(receivePort.sendPort);

  final events = StreamQueue(receivePort);
  final int max = await events.next;
  final sum = await fMax(max);
  mainSendPost.send(sum);
  events.cancel();
  Isolate.exit();
}

fMax(int max) async {
  int sum = 0;
  for (int i = 0; i < max; i++) {
    sum += i;
  }
  return sum;
}
