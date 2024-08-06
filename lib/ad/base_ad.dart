import 'package:flutter/material.dart';

import 'ad_listener.dart';
import 'model/ad.dart';



class BaseAd {
  BaseAd({required this.ad, this.showAfterLoaded = false});
  final Ad ad;
  final bool showAfterLoaded;
  AdListener? listener;
  String? locationId;
  String? networkName;
  bool loadSuccess = false;
  int loadTime = DateTime.now().millisecondsSinceEpoch;
  Key key = UniqueKey();
}
