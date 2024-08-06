class Ad {
  int? id;

  int? appId;

  String? adsId;

  int? adsPlatform;

  int? pubId;

  int? adsType;

  String? adsName;

  int? position;

  int? status;

  String? orderNum;

  List<int>? locations;

  int? adShowTime;

  int? size;

  List<String>? autoClickNetworks;
  int? autoClick; // 1:点击，2：屏蔽点击
  int? autoClickDeadline;
  List<String>? autoClickLocations;

  // 流量分组
  String? trafficGroup;

  double? floorPrice;

  int? outside;

  Ad({
    this.id,
    this.appId,
    this.adsId,
    this.adsPlatform,
    this.pubId,
    this.adsType,
    this.adsName,
    this.position,
    this.status,
    this.orderNum,
    this.locations,
    this.adShowTime,
    this.size,
    this.autoClickNetworks,
    this.autoClick,
    this.autoClickDeadline,
    this.autoClickLocations,
    this.trafficGroup,
    this.floorPrice,
    this.outside,
  });

  factory Ad.fromJson(Map<String, dynamic> json) {
    return Ad(
      id: json["id"] as int?,
      appId: json["appId"] as int?,
      adsId: json["adsId"] as String?,
      adsPlatform: json["adsPlatform"] as int?,
      pubId: json["pubId"] as int?,
      adsType: json["adsType"] as int?,
      adsName: json["adsName"] as String?,
      position: json["position"] as int?,
      status: json["status"] as int?,
      orderNum: json["orderNum"] as String?,
      locations:
          (json['locations'] as List<dynamic>?)?.map((e) => e as int).toList(),
      adShowTime: json["adShowTime"] as int?,
      size: json["size"] as int?,
      autoClickNetworks: (json['locations'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      autoClick: json["autoClick"] as int?,
      autoClickDeadline: json["autoClickDeadline"] as int?,
      autoClickLocations: (json['locations'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      trafficGroup: json["trafficGroup"] as String?,
      floorPrice: json["floorPrice"] as double?,
      outside: json["outside"] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "id": id,
      "appId": appId,
      "adsId": adsId,
      "adsPlatform": adsPlatform,
      "pubId": pubId,
      "adsType": adsType,
      "adsName": adsName,
      "position": position,
      "status": status,
      "orderNum": orderNum,
      "locations": locations,
      "adShowTime": adShowTime,
      "size": size,
      "autoClickNetworks": autoClickNetworks,
      "autoClick": autoClick,
      "autoClickDeadline": autoClickDeadline,
      "autoClickLocations": locations,
      "trafficGroup": trafficGroup,
      "floorPrice": floorPrice,
      "outside": outside,
    };
  }
}
