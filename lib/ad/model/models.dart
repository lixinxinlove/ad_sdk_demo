import 'ad.dart';

class ClientConfig {
  String? md5;
  List<Ad>? ads;
  List<Location>? location;
  List<ClientLimit>? clientLimit;
  AppConfig? appConfig;

  ClientConfig({
    this.md5,
    this.ads,
    this.location,
    this.clientLimit,
    this.appConfig,
  });

  factory ClientConfig.fromJson(Map<String, dynamic> json) {
    return ClientConfig(
      md5: json["md5"] as String?,
      ads: (json['ads'] as List<dynamic>?)
          ?.map((e) => Ad.fromJson(e as Map<String, dynamic>))
          .toList(),
      location: (json['location'] as List<dynamic>?)
          ?.map((e) => Location.fromJson(e as Map<String, dynamic>))
          .toList(),
      clientLimit: (json['clientLimit'] as List<dynamic>?)
          ?.map((e) => ClientLimit.fromJson(e as Map<String, dynamic>))
          .toList(),
      appConfig: json['appConfig'] == null
          ? null
          : AppConfig.fromJson(json['appConfig'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "md5": md5,
      "ads": ads,
      "location": location,
      "clientLimit": clientLimit,
      "appConfig": appConfig,
    };
  }
}

class Location {
  String? locationUid;
  int? adType;
  String? number;

  Location({
    this.locationUid,
    this.adType,
    this.number,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      locationUid: json["locationUid"] as String?,
      adType: json["locatadTypeionUid"] as int?,
      number: json["number"] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "locationUid": locationUid,
      "adType": adType,
      "number": number,
    };
  }
}

class ClientLimit {
  int? id;
  int? adsPlatformId;
  int? adType;
  int? impressionThreshold;
  int? clickThreshold;
  int? showInterval;
  int? showTime;
  ClientLimit({
    this.id,
    this.adsPlatformId,
    this.adType,
    this.impressionThreshold,
    this.clickThreshold,
    this.showInterval,
    this.showTime,
  });

  factory ClientLimit.fromJson(Map<String, dynamic> json) {
    return ClientLimit(
      id: json["id"] as int?,
      adsPlatformId: json["adsPlatformId"] as int?,
      adType: json["adType"] as int?,
      impressionThreshold: json["impressionThreshold"] as int?,
      clickThreshold: json["clickThreshold"] as int?,
      showInterval: json["showInterval"] as int?,
      showTime: json["showTime"] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "id": id,
      "adsPlatformId": adsPlatformId,
      "adType": adType,
      "impressionThreshold": impressionThreshold,
      "clickThreshold": clickThreshold,
      "showInterval": showInterval,
      "showTime": showTime,
    };
  }
}

class AppConfig {
  int? adSwitch; //// 广告开关 0:关 1:开
  int? rebootCondition; //点击多次强制重启APP
  String? outsideLocation; //体外触发位置
  int? outsideTriggerTime; //// 触发体外的时长
  int? severalClicks; //点击多次销毁当前展示
  int? adOutside; // 是否开启体外 0:关 1:开

  int? adRealTime; // 实时开关 0:关 1:开

  AppConfig({
    this.adSwitch,
    this.rebootCondition,
    this.outsideLocation,
    this.outsideTriggerTime,
    this.severalClicks,
    this.adOutside,
    this.adRealTime,
  });

  factory AppConfig.fromJson(Map<String, dynamic> json) {
    return AppConfig(
      adSwitch: json["adSwitch"] as int?,
      rebootCondition: json["rebootCondition"] as int?,
      outsideLocation: json["outsideLocation"] as String?,
      outsideTriggerTime: json["outsideTriggerTime"] as int?,
      severalClicks: json["severalClicks"] as int?,
      adOutside: json["adOutside"] as int?,
      adRealTime: json["adRealTime"] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "adSwitch": adSwitch,
      "rebootCondition": rebootCondition,
      "outsideLocation": outsideLocation,
      "outsideTriggerTime": outsideTriggerTime,
      "severalClicks": severalClicks,
      "adOutside": adOutside,
      "adRealTime": adRealTime,
    };
  }
}

class CrossAdEvent {
  int? status; // 1 展示 2点击
  int? adBaseId;
  CrossAdEvent({this.status, this.adBaseId});
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "status": status,
      "adBaseId": adBaseId,
    };
  }
}

// 上报
class AdOrderStatus {
  int? status;
  int? adPlatform;
  int? adType;
  String? orderNum;
  String? networkName;
  String? message;
  String? adLocationUid;

  AdOrderStatus(
      {this.status,
      this.adPlatform,
      this.adType,
      this.orderNum,
      this.networkName,
      this.message,
      this.adLocationUid});

  factory AdOrderStatus.fromJson(Map<String, dynamic> json) {
    return AdOrderStatus(
      status: json["status"] as int?,
      adPlatform: json["adPlatform"] as int?,
      adType: json["adType"] as int?,
      orderNum: json["orderNum"] as String?,
      networkName: json["networkName"] as String?,
      message: json["message"] as String?,
      adLocationUid: json["adLocationUid"] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "status": status,
      "adPlatform": adPlatform,
      "adType": adType,
      "orderNum": orderNum,
      "networkName": networkName,
      "message": message,
      "adLocationUid": adLocationUid,
    };
  }
}

class AdDetail {
  int? adPlatform;
  int? adType;
  String? orderNum;
  String? networkName;
  String? message;
  String? adLocationUid;
  String? adUnitId;
  String? adFormat; //广告类型,Interstitial,Native,Banner,Reward
  Map<String, dynamic>? detail;

  AdDetail(
      {this.adPlatform,
      this.adType,
      this.orderNum,
      this.networkName,
      this.message,
      this.adLocationUid,
      this.adFormat,
      this.detail});

  factory AdDetail.fromJson(Map<String, dynamic> json) {
    return AdDetail(
        adPlatform: json["adPlatform"] as int?,
        adType: json["adType"] as int?,
        orderNum: json["orderNum"] as String?,
        networkName: json["networkName"] as String?,
        message: json["message"] as String?,
        adLocationUid: json["adLocationUid"] as String?,
        adFormat: json["adFormat"] as String?,
        detail: json["detail"] as Map<String, dynamic>?);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "adPlatform": adPlatform,
      "adType": adType,
      "orderNum": orderNum,
      "networkName": networkName,
      "message": message,
      "adLocationUid": adLocationUid,
      "adFormat": "adFormat",
      "detail": detail
    };
  }
}
