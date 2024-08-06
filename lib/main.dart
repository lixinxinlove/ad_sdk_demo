import 'package:flutter/material.dart';
import 'ad/topon_sdk.dart';
import 'ad/ad_manager.dart';
import 'package:anythink_sdk/at_index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    TopOnSDK.setupSDK();
  }

  _loadRewardedVideo() async {
    await ATRewardedManager.loadRewardedVideo(
        placementID: 'b62b41523c054c',
        extraMap: {
          ATRewardedManager.kATAdLoadingExtraUserDataKeywordKey(): '1234',
          ATRewardedManager.kATAdLoadingExtraUserIDKey(): '1234',
        });
  }

  _showAd() async {
    await ATRewardedManager.showRewardedVideo(
      placementID: 'b62b41523c054c',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _incrementCounter();
          // _loadRewardedVideo();
          // _showAd();
          _loadInterstitialAd();

          //_showInterAd();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
